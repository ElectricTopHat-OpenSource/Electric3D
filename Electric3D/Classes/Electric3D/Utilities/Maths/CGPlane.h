/*
 *  CGPlane.h
 *  Electric3D
 *
 *  Created by Robert McDowell on 14/10/2010.
 *  Copyright 2010 Electric TopHat Ltd. All rights reserved.
 *
 */

#if !defined(_CGPlane_h__)
#define __CGPlane_h__

#import "CGMathsConstants.h"
#import "CGMathsTypes.h"

namespace CGMaths 
{
		
#pragma mark ---------------------------------------------------------
#pragma mark CGPlane consts 
#pragma mark ---------------------------------------------------------
	
	const CGPlane CGPlaneZero = {  0.0f,  0.0f,  0.0f, 0.0f, 0.0f, 0.0f };
	const CGPlane CGPlaneUnit = {  0.0f,  0.0f,  0.0f, 1.0f, 0.0f, 0.0f };
	
#pragma mark ---------------------------------------------------------
#pragma mark End CGPlane consts 
#pragma mark ---------------------------------------------------------

#pragma mark ---------------------------------------------------------
#pragma mark CGPlane Functions
#pragma mark ---------------------------------------------------------
	
	// ---------------------------------------------------
	// Make a CGPlane
	// ---------------------------------------------------
	CGPlane CGPlaneMake( const CGVector3D & _point, const CGVector3D & _normal )
	{
		CGPlane plane;
		plane.d			= CGVector3DDotProduct(_normal, _point);
		plane.normal	= _normal;
		return plane;
	}
	
	// ---------------------------------------------------
	// Make a CGPlane
	// ---------------------------------------------------
	CGPlane CGPlaneMake( const CGVector3D & _pointA, const CGVector3D & _pointB, const CGVector3D & _pointC )
	{
		CGPlane plane;
		plane.normal	= CGVector3DCrossProduct( CGVector3DSub(_pointB, _pointA), CGVector3DSub(_pointC, _pointA) );
		CGVector3DNormalise( plane.normal );
		plane.point		= CGVector3DDotProduct(plane.normal, _pointA);
		return plane;
	}
	
	// ---------------------------------------------------
	// Find the closest point on the plane from a point
	// ---------------------------------------------------
	CGVector3D CGPlaneClosestPointOn( const CGPlane & _plane, const CGVector3D & _point )
	{
		float t = CGVector3DDotProduct( CGVector3DSub(_plane.normal, _point) ) - _plane.d;
		return CGVector3DSub( _point, CGVector3DScale(_plane.normal, t) );
	}
	
	// ---------------------------------------------------
	// Find the closest point on the plane from a ray
	// ---------------------------------------------------
	CGVector3D CGPlaneClosestPoint( const CGPlane & _plane, const CGVector3D & _start, const CGVector3D & _end )
	{
		CGVector3D r	= CGVector3DSub( _end, _start );
		float a			= CGVector3DDotProduct( r, _plane.normal );
	
		// parallel to the plane
		if (a==0)
		{
			return _start;
		}
		else 
		{
			float t  = CGVector3DDotProduct(_start, _plane.normal);	
			float distance = t / a;
			float length   = CGVector3DNormalised(r);
			return CGVector3DAdd( _start, CGVector3DScale( r, MIN( distance, length ) ) );
		}
	}
	
#pragma mark ---------------------------------------------------------
#pragma mark End CGPlane Functions
#pragma mark ---------------------------------------------------------
	
};

#endif