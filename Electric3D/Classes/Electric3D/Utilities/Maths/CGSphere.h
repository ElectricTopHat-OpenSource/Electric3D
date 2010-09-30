/*
 *  CGSphere.h
 *  Electric3D
 *
 *  Created by Robert McDowell on 30/09/2010.
 *  Copyright 2010 Electric TopHat Ltd. All rights reserved.
 *
 */

#if !defined(__CGAABB_h__)
#define __CGAABB_h__

#import "CGMathsConstants.h"
#import "CGVector3D.h"

namespace CGMaths 
{
	
#pragma mark ---------------------------------------------------------
#pragma mark CGSphere typedef
#pragma mark ---------------------------------------------------------
	
	typedef struct 
	{ 
		CGVector3D center;
		float	   radius;
	} CGSphere;
	
#pragma mark ---------------------------------------------------------
#pragma mark End CGSphere typedef
#pragma mark ---------------------------------------------------------
	
#pragma mark ---------------------------------------------------------
#pragma mark CGSphere consts 
#pragma mark ---------------------------------------------------------
	
	const CGSphere CGSphereZero = {  0.0f,  0.0f,  0.0f, 0.0f };
	const CGSphere CGSphereUnit = {  0.0f,  0.0f,  0.0f, 1.0f };
	
#pragma mark ---------------------------------------------------------
#pragma mark End CGSphere consts 
#pragma mark ---------------------------------------------------------

#pragma mark ---------------------------------------------------------
#pragma mark CGSphere Functions
#pragma mark ---------------------------------------------------------
	
	// ---------------------------------------------------
	// Make a CGSphere
	// ---------------------------------------------------
	inline CGSphere CGAABBMake( float _x, float _y, float _z,float _r )
	{
		CGSphere sphere; 
		sphere.center.x = _x;
		sphere.center.x = _y;
		sphere.center.x = _z;
		sphere.radius   = _r;
		return sphere;
	}
	
	// ---------------------------------------------------
	// Does the line intersect with the CGSphere
	// ---------------------------------------------------
	inline BOOL CGSphereIntersects( const CGSphere & _sphere, const CGVector3D & _start, const CGVector3D & _end )
	{
		CGVector3D lineA			= CGVector3DSub( _end, _start );
		CGVector3D lineB			= CGVector3DSub( _sphere.center, _start );
		
		float t = CGMaths::CGVector3DDotProduct( lineB, lineA ) / CGMaths::CGVector3DDotProduct( lineA, lineA );
		t = CGMaths::fClamp( t, 0.0f, 1.0f );  
		
		CGVector3D shift = CGMaths::CGVector3DScale( lineA, t );
		CGVector3D point = CGMaths::CGVector3DAdd( _start, shift );
		
		CGVector3D lineC = CGMaths::CGVector3DSub( _sphere.center, point );
		float lenc = CGMaths::CGVector3DLengthSquared( lineC );
		
		return ( lenc <= ( _sphere.radius * _sphere.radius ) );
	}
	
#pragma mark ---------------------------------------------------------
#pragma mark CGSphere Functions
#pragma mark ---------------------------------------------------------
	
};

#endif