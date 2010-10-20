/*
 *  E3DSplineHermite.mm
 *  Electric3D
 *
 *  Created by Robert McDowell on 18/10/2010.
 *  Copyright 2010 Electric TopHat Ltd. All rights reserved.
 *
 */

#include "E3DSplineHermite.h"

namespace E3D 
{
	
#pragma mark ---------------------------------------------------------
#pragma mark Constructor / Destructor
#pragma mark ---------------------------------------------------------

	// --------------------------------------------------
	// Constructor
	// --------------------------------------------------
	E3DSplineHermite::E3DSplineHermite( NSString * _name, NSUInteger _capacity )
	: E3DSpline		( _name )
	, m_data		( nil )
	, m_points		( nil )
	, m_tangents	( nil )
	, m_capacity	( _capacity )
	, m_count		( 0 )
	{
		// ---------------------------------------------------------
		// create the Hermite polynomial
		// ---------------------------------------------------------
        m_coefficients = CGMaths::CGMatrix4x4Make( 2, -2,  1,  1,
												  -3,  3, -2, -1,
												  0,  0,  1,  0,
												  1,  0,  0,  0 );
		// ---------------------------------------------------------
		
		// ---------------------------------------------------------
		// malloc the data
		// ---------------------------------------------------------
		int points   = sizeof(CGMaths::CGVector3D) * _capacity;
		int tangents = sizeof(CGMaths::CGVector3D) * _capacity;
		int space	 = points + tangents;
		
		void * bytes = (void*)malloc( space );
		memset(bytes, 0, space);
		// ---------------------------------------------------------
		
		// ---------------------------------------------------------
		// pass the bytes into an NSData object 
		// and control over to it
		// ---------------------------------------------------------
		m_data = [[NSData alloc] initWithBytesNoCopy:bytes length:space];
		// ---------------------------------------------------------
		
		// ---------------------------------------------------------
		// set up the pointers
		// ---------------------------------------------------------
		unsigned char * p = (unsigned char*)bytes;
		m_points	= (CGMaths::CGVector3D*)&p[0];
		m_tangents	= (CGMaths::CGVector3D*)&p[points];
		// ---------------------------------------------------------
	}
	
	// --------------------------------------------------
	// Destructor
	// --------------------------------------------------
	E3DSplineHermite::~E3DSplineHermite()
	{
	}

#pragma mark ---------------------------------------------------------
#pragma mark End Constructor / Destructor
#pragma mark ---------------------------------------------------------
	
	
#pragma mark ---------------------------------------------------------
#pragma mark === Public Functions  ===
#pragma mark ---------------------------------------------------------
	
	// --------------------------------------------------
	// add a point to the spline
	// --------------------------------------------------
	BOOL E3DSplineHermite::add( float _x, float _y, float _z )
	{
		if ( m_count < m_capacity )
		{
			m_points[m_count].x = _x;
			m_points[m_count].y = _y;
			m_points[m_count].z = _z;
			m_count++;
			
			calculateTangents();
			calculateAABB();
			return TRUE;
		}
		return FALSE;
	}
	
	// --------------------------------------------------
	// add a point to the spline
	// --------------------------------------------------
	BOOL E3DSplineHermite::add( const CGMaths::CGVector3D & _point )
	{
		if ( m_count < m_capacity )
		{
			m_points[m_count].x = _point.x;
			m_points[m_count].y = _point.y;
			m_points[m_count].z = _point.z;
			m_count++;
			
			calculateTangents();
			calculateAABB();
			return TRUE;
		}
		return FALSE;
	}
	
	// --------------------------------------------------
	// add a bunch of points
	// --------------------------------------------------
	BOOL E3DSplineHermite::add( const CGMaths::CGVector3D * _points, NSInteger _count )
	{
		if ( m_count + _count <= m_capacity )
		{		
			memcpy(&m_points[m_count], _points, sizeof(CGMaths::CGVector3D)*_count);
			m_count += _count;
			calculateTangents();
			calculateAABB();
		}
		return FALSE;
	}
	
	// --------------------------------------------------
	// get a point in the spline
	// --------------------------------------------------
	const CGMaths::CGVector3D & E3DSplineHermite::getPoint( NSUInteger _index ) const
	{
		if ( m_count > _index )
		{
			return m_points[_index];
		}
		return CGMaths::CGVector3DZero;
	}
	
	// --------------------------------------------------
	// update a point in the spline
	// --------------------------------------------------
	void E3DSplineHermite::updatePoint( NSUInteger _index, float _x, float _y, float _z )
	{
		if ( m_count > _index )
		{
			m_points[_index].x = _x;
			m_points[_index].y = _y;
			m_points[_index].z = _z;
			
			calculateTangents();
			calculateAABB();
		}
	}
	
	// --------------------------------------------------
	// update a point in the spline
	// --------------------------------------------------
	void E3DSplineHermite::updatePoint( NSUInteger _index, const CGMaths::CGVector3D & _point )
	{
		if ( m_count > _index )
		{
			m_points[_index] = _point;
			
			calculateTangents();
			calculateAABB();
		}
	}
	
	// --------------------------------------------------
	// clear the entire spline points
	// --------------------------------------------------
	void E3DSplineHermite::clear()
	{
		m_count = 0;
	}
	
	// --------------------------------------------------
	// interpolate the point on the spline
	// --------------------------------------------------
	CGMaths::CGVector3D E3DSplineHermite::interpolate( float _interp ) const
	{
		if ( m_count > 2 )
		{
			float		value  = ( _interp * ( m_count-1 ) );
			NSUInteger	index  = (NSUInteger)value;
			float		interp = value - index;
			
			return interpolate( index, interp );
		}
		else if ( m_count > 0 )
		{
			// simple 2 point lerp
			const CGMaths::CGVector3D & start = m_points[0];
			const CGMaths::CGVector3D & end   = m_points[m_count-1];
			
			// clamp the value
			float interp = MIN( MAX( _interp, 0.0f ), 1.0f );
			
			CGMaths::CGVector3D vec = CGMaths::CGVector3DMakeSub( end, start );
			
			return CGMaths::CGVector3DMakeAdd( start, vec, interp );
		}
		return CGMaths::CGVector3DZero;
	}
	
#pragma mark ---------------------------------------------------------
#pragma mark === End Public Functions  ===
#pragma mark ---------------------------------------------------------
	
#pragma mark ---------------------------------------------------------
#pragma mark === Private Functions  ===
#pragma mark ---------------------------------------------------------
	
	// --------------------------------------------------
	// interpolate the current points
	// --------------------------------------------------
	CGMaths::CGVector3D E3DSplineHermite::interpolate( NSUInteger _index, float _interp ) const
	{
		if ( _index < m_count-1 )
		{
			if ( _interp <= CGMaths::EPSILON )
			{
				return m_points[_index];
			}
			else if ( _interp >= 1.0f-CGMaths::EPSILON )
			{
				return m_points[_index+1];
			}
			else 
			{
				// powers of the interp time
				CGMaths::CGVector4D p;
				p.w = 1.0f;
				p.z = _interp;
				p.y = _interp * _interp;
				p.x = p.y * _interp;
				
				// Algorithm is ret = p *coefficients * Matrix4x4(point1, point2, tangent1, tangent2)
				const CGMaths::CGVector3D & point1	= m_points[_index];
				const CGMaths::CGVector3D & point2	= m_points[_index+1];
				const CGMaths::CGVector3D & tan1	= m_tangents[_index];
				const CGMaths::CGVector3D & tan2	= m_tangents[_index+1];
				
				CGMaths::CGMatrix4x4 mtx = CGMaths::CGMatrix4x4Make( point1.x, point1.y,	point1.z, 1.0f,
																	 point2.x, point2.y,	point2.z, 1.0f,
																	 tan1.x,	 tan1.y,	tan1.z,	  1.0f,
																	 tan2.x,	 tan2.y,	tan2.z,	  1.0f );
				
				CGMaths::CGMatrix4x4 mmtx = CGMaths::CGMatrix4x4MakeMultiply(m_coefficients, mtx);
				
				CGMaths::CGVector4D vec = CGMaths::CGMatrix4x4TransformVector(mmtx, p);
				
				return CGMaths::CGVector3DMake( vec.x, vec.y, vec.z );
			}
		}
		else 
		{
			// out of bounds so just 
			// return the end point
			return m_points[m_count-1];
		}
	}
	
	// --------------------------------------------------
	// calculate Tangents
	// --------------------------------------------------
	void E3DSplineHermite::calculateTangents()
	{
		// need more than two points
		// calculate the tangents
		if ( m_count > 2 )
		{
			// check to see if it's a closed spline
			CGMaths::CGVector3D start = m_points[0];
			CGMaths::CGVector3D end   = m_points[m_count-1];
			BOOL isClosed = CGMaths::CGVector3DAreEqual( start, end );
			
			// deal with the start node and end nodes
			if ( isClosed )
			{
				// special case where the start and end nodes are the same position
				// and create a closed loop and there for there tangents are the
				// same
				CGMaths::CGVector3D tangent = CGMaths::CGVector3DMakeScale( CGMaths::CGVector3DMakeSub(m_points[1], m_points[m_count-2]), 0.5f );
				m_tangents[0]		  = tangent;
				m_tangents[m_count-1] = tangent;
			}
			else 
			{
				m_tangents[0]		  = CGMaths::CGVector3DMakeScale( CGMaths::CGVector3DMakeSub(m_points[1], m_points[0]), 0.5f );
				m_tangents[m_count-1] = CGMaths::CGVector3DMakeScale( CGMaths::CGVector3DMakeSub(m_points[m_count-1], m_points[m_count-2]), 0.5f );
			}
			
			// central points
			int i;
			for ( i=1; i<m_count-2; i++ )
			{
				CGMaths::CGVector3D tangent = CGMaths::CGVector3DMakeSub( m_points[i+1], m_points[i-1] );
				CGMaths::CGVector3DScale( tangent, 0.5f );
				m_tangents[i] = tangent;
			}
		}
	}
	
#pragma mark ---------------------------------------------------------
#pragma mark === End Private Functions  ===
#pragma mark ---------------------------------------------------------

};