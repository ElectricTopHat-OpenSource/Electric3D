/*
 *  CGAABB.h
 *  Electric3D
 *
 *  Created by Robert McDowell on 24/09/2010.
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
#pragma mark CGAABB typedef
#pragma mark ---------------------------------------------------------
	
	typedef struct 
	{ 
		CGVector3D min;
		CGVector3D max;
	} CGAABB;
	
#pragma mark ---------------------------------------------------------
#pragma mark End CGAABB typedef
#pragma mark ---------------------------------------------------------

#pragma mark ---------------------------------------------------------
#pragma mark CGAABB consts 
#pragma mark ---------------------------------------------------------
	
	const CGAABB CGAABBZero = { 0, 0, 0, 0, 0, 0 };
	
#pragma mark ---------------------------------------------------------
#pragma mark End CGAABB consts 
#pragma mark ---------------------------------------------------------
	
#pragma mark ---------------------------------------------------------
#pragma mark CGAABB Functions
#pragma mark ---------------------------------------------------------
	
	// ---------------------------------------------------
	// Make a CGAABB
	// ---------------------------------------------------
	inline CGAABB CGAABBMake( float _xA, float _yA, float _zA,float _xB, float _yB, float _zB )
	{
		CGAABB aabb; 
		if ( _xA < _xB )
		{
			aabb.min.x = _xA;
			aabb.max.x = _xB;
		}
		else 
		{
			aabb.min.x = _xB;
			aabb.max.x = _xA;
		}
		if ( _yA < _yB )
		{
			aabb.min.y = _yA;
			aabb.max.y = _yB;
		}
		else 
		{
			aabb.min.y = _yB;
			aabb.max.y = _yA;
		}
		if ( _zA < _zB )
		{
			aabb.min.z = _zA;
			aabb.max.z = _zB;
		}
		else 
		{
			aabb.min.z = _zB;
			aabb.max.z = _zA;
		}
		return aabb;
	}
	
#pragma mark ---------------------------------------------------------
#pragma mark End CGAABB Functions
#pragma mark ---------------------------------------------------------
	
#endif
