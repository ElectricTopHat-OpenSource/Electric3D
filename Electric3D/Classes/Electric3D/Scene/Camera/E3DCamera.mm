//
//  E3DCamera.m
//  Electric3D
//
//  Created by Robert McDowell on 19/10/2010.
//  Copyright 2010 Electric TopHat Ltd. All rights reserved.
//

#import "E3DCamera.h"

namespace E3D  
{
#pragma mark ---------------------------------------------------------
#pragma mark Constructor / Destructor
#pragma mark ---------------------------------------------------------
	
	// --------------------------------------------------
	// Constructor
	// --------------------------------------------------
	E3DCamera::E3DCamera( NSString * _name )
	: m_name		( [_name copy] )
	, m_transform	( CGMaths::CGMatrix4x4Identity )
	, m_fov			( 45.0f )
	, m_near		( 1.0f )
	, m_far			( 10000.0f )
	, m_viewport	( CGRectMake(0, 0, 320, 480) )
	{
	}
	
	// --------------------------------------------------
	// Destructor
	// --------------------------------------------------
	E3DCamera::~E3DCamera()
	{
	}

#pragma mark ---------------------------------------------------------
#pragma mark End Constructor / Destructor
#pragma mark ---------------------------------------------------------

#pragma mark ---------------------------------------------------------
#pragma mark === Public Functions  ===
#pragma mark ---------------------------------------------------------

	// --------------------------------------------------
	// create the projection Matrix
	// --------------------------------------------------
	CGMaths::CGMatrix4x4 E3DCamera::projectionMatrix()
	{
		float deltaz  = far() - near();
		float aspect  = m_viewport.size.width / m_viewport.size.height;
		float radians = CGMaths::Degrees2Radians( fov() / 2.0f );
		float sine = sinf(radians);
		if ( (deltaz != 0) && (sine != 0) && (aspect != 0) ) 
		{
			CGMaths::CGMatrix4x4 matrix;
			
			float cotangent = cosf(radians) / sine;
			matrix.m[0]  = cotangent / aspect;
			matrix.m[1]	 = 0; 
			matrix.m[2]	 = 0; 
			matrix.m[3]	 = 0;
			matrix.m[4]	 = 0;
			matrix.m[5]  = cotangent;
			matrix.m[6]	 = 0;
			matrix.m[7]	 = 0;
			matrix.m[8]	 = 0;
			matrix.m[9]	 = 0;
			matrix.m[10] = 1;
			matrix.m[11] = 0;
			matrix.m[12] = 0;
			matrix.m[10] = -( far() + near()) / deltaz;
			matrix.m[11] = -1;
			matrix.m[12] = 0;
			matrix.m[13] = 0;
			matrix.m[14] = -2 * near() * far() / deltaz;
			matrix.m[15] = 0;
			
			return matrix;
		}	
		return CGMaths::CGMatrix4x4Identity;
	}
	
	// --------------------------------------------------
	// create the model Matrix
	// --------------------------------------------------
	CGMaths::CGMatrix4x4 E3DCamera::modelMatrix()
	{
		const CGMaths::CGMatrix4x4 & mat = m_transform;
		CGMaths::CGMatrix4x4 rot;
		
		// --------------------------------------
		// copy the right up and at axis ( flip the last )
		// --------------------------------------
		rot.m[0]  = mat.m[0]; 	rot.m[1]  = mat.m[1];	rot.m[2]  = -mat.m[2];	 rot.m[3] = 0.0f;
		rot.m[4]  = mat.m[4];	rot.m[5]  = mat.m[5];	rot.m[6]  = -mat.m[6];	 rot.m[7] = 0.0f;
		rot.m[8]  = mat.m[8];	rot.m[9]  = mat.m[9];	rot.m[10] = -mat.m[10];	 rot.m[11] = 0.0f;
		rot.m[12] = 0.0f;		rot.m[13] = 0.0f;		rot.m[14] = 0.0f;		 rot.m[15] = 1.0f;
		// --------------------------------------
		
		// --------------------------------------
		// Transform the positional information
		// --------------------------------------
		CGMaths::CGVector3D p = CGMaths::CGMatrix4x4TransformVector( rot, -mat.m[12], -mat.m[13], -mat.m[14] );
		// --------------------------------------
		
		// --------------------------------------
		// copy the traslated point into the mat 
		// --------------------------------------
		rot.m[12] = p.x; rot.m[13] = p.y; rot.m[14] = p.z;
		// --------------------------------------
		
		return rot;
	}
	
	// --------------------------------------------------
	// Project a point into the world
	// --------------------------------------------------
	CGMaths::CGVector3D E3DCamera::worldToScreen( const CGMaths::CGVector3D & _point )
	{
		CGMaths::CGMatrix4x4 model		= modelMatrix();
		CGMaths::CGMatrix4x4 projection = projectionMatrix();
		
		CGMaths::CGVector4D t0 = CGMaths::CGMatrix4x4TransformVector( model, _point.x, _point.y, _point.z, 1.0f );
		CGMaths::CGVector4D t1 = CGMaths::CGMatrix4x4TransformVector( projection, t0 );
		if ( t1.w != 0.0f )
		{
			t1.x /= t1.w;
			t1.y /= t1.w;
			
			// Map x, y to range 0-1 
			// Map z to the real depth in meters
			// Map x,y to viewport 
			CGMaths::CGVector3D point = CGMaths::CGVector3DMake( ( t1.x * 0.5 + 0.5 ) * m_viewport.size.width  + m_viewport.origin.x,
																 ( t1.y * 0.5 + 0.5 ) * m_viewport.size.height + m_viewport.origin.y,
																 ( t1.w ) );
			
			return point;
		}
		return CGMaths::CGVector3DZero;
	}
	
	// --------------------------------------------------
	// the z cordinate specifies the distance into the screen
	// --------------------------------------------------
	CGMaths::CGVector3D E3DCamera::screenToWorld( const CGMaths::CGVector3D & _point )
	{	
		CGMaths::CGMatrix4x4 model		= modelMatrix();
		CGMaths::CGMatrix4x4 projection = projectionMatrix();
		
		CGMaths::CGMatrix4x4 matrix		= CGMaths::CGMatrix4x4MakeMultiply( model, projection );
		if ( CGMaths::CGMatrix4x4Invert( matrix ) )
		{
			float x		= (_point.x - m_viewport.origin.x) / m_viewport.size.width  * 2.0 - 1.0f;
			float y		= (_point.y - m_viewport.origin.y) / m_viewport.size.height * 2.0 - 1.0f;
			float minz	= ( 2.0f * 0.0f - 1.0f );
			float maxz	= ( 2.0f * 1.0f - 1.0f );
			
			CGMaths::CGVector4D t0 = CGMaths::CGMatrix4x4TransformVector( matrix, x, y, minz, 1.0f );
			CGMaths::CGVector4D t1 = CGMaths::CGMatrix4x4TransformVector( matrix, x, y, maxz, 1.0f );
			
			CGMaths::CGVector3D p0 = CGMaths::CGVector3DMake( t0.x / t0.w, t0.y / t0.w, t0.z / t0.w );
			CGMaths::CGVector3D p1 = CGMaths::CGVector3DMake( t1.x / t1.w, t1.y / t1.w, t1.z / t1.w );
			
			float scale = ( _point.z - near() ) / ( far() - near() );
			CGMaths::CGVector3D vec   = CGMaths::CGVector3DMakeSub( p1, p0 );
			CGMaths::CGVector3D point = CGMaths::CGVector3DMakeAdd( p0, vec, scale );
			
			return point;
			
		}
		return CGMaths::CGVector3DZero;
	}
	
#pragma mark ---------------------------------------------------------
#pragma mark === End Public Functions  ===
#pragma mark ---------------------------------------------------------

};