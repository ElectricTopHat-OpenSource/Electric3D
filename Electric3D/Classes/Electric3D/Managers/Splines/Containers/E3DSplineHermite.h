/*
 *  E3DSplineHermite.h
 *  Electric3D
 *
 *  Created by Robert McDowell on 18/10/2010.
 *  Copyright 2010 Electric TopHat Ltd. All rights reserved.
 *
 */

#if !defined(__E3DSplineHermite_h__)
#define __E3DSplineHermite_h__

#import "E3DSplineTypes.h"
#import "E3DSpline.h"
#import "CGMaths.h"

namespace E3D 
{
	class E3DSplineHermite : public E3DSpline
	{
#pragma mark ---------------------------------------------------------
#pragma mark Constructor / Destructor
#pragma mark ---------------------------------------------------------
	public: // Functions
		
		E3DSplineHermite( NSString * _name, NSUInteger _capacity = 16 );
		virtual ~E3DSplineHermite();
		
#pragma mark ---------------------------------------------------------
#pragma mark End Constructor / Destructor
#pragma mark ---------------------------------------------------------
		
#pragma mark ---------------------------------------------------------
#pragma mark === Public Functions  ===
#pragma mark ---------------------------------------------------------
	public: // Functions
		
		// get the spline type
		inline eE3DSplineType type() const { return eE3DSplineType_Hermite; };
		
		// add a point to the spline
		BOOL add( float _x, float _y, float _z );
		BOOL add( const CGMaths::CGVector3D & _point );
		BOOL add( const CGMaths::CGVector3D * _point, NSInteger _count );
		
		// get a point in the spline
		const CGMaths::CGVector3D & getPoint( NSUInteger _index ) const;
		
		// update a point in the spline
		void updatePoint( NSUInteger _index, float _x, float _y, float _z );
		void updatePoint( NSUInteger _index, const CGMaths::CGVector3D & _point );
		
		// get the number of points in the spline
		inline NSUInteger count()		{ return m_count; }
		inline NSUInteger capacity()	{ return m_capacity; };
		
		// clear the entire spline points
		void clear();
		
		// interpolate the point on the spline
		CGMaths::CGVector3D interpolate( float _interp ) const;
		
#pragma mark ---------------------------------------------------------
#pragma mark === End Public Functions  ===
#pragma mark ---------------------------------------------------------
		
#pragma mark ---------------------------------------------------------
#pragma mark === Private Functions  ===
#pragma mark ---------------------------------------------------------
	private: // Functions
		
		CGMaths::CGVector3D interpolate( NSUInteger _index, float _interp ) const;
		
		void calculateTangents();
		
#pragma mark ---------------------------------------------------------
#pragma mark === End Private Functions  ===
#pragma mark ---------------------------------------------------------
		
#pragma mark ---------------------------------------------------------
#pragma mark === Private Data  ===
#pragma mark ---------------------------------------------------------
	private: // Data
				
		NSData *				m_data;
		
		CGMaths::CGVector3D *	m_points;
		CGMaths::CGVector3D *	m_tangents;
		
		NSUInteger				m_capacity;
		NSUInteger				m_count;
		
		CGMaths::CGMatrix4x4	m_coefficients;
		
#pragma mark ---------------------------------------------------------
#pragma mark === Private Data  ===
#pragma mark ---------------------------------------------------------
		
	};
};

#endif
