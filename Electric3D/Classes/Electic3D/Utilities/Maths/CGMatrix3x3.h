/*
 *  CGMatric3x3.h
 *  Electric3D
 *
 *  Created by Robert McDowell on 21/09/2010.
 *  Copyright 2010 Electric TopHat Ltd. All rights reserved.
 *
 */

#if !defined(__CGMatrix3x3_h__)
#define __CGMatrix3x3_h__

#import "CGMathsConstants.h"
#import "CGVector3D.h"

namespace CGMaths 
{
	
#pragma mark ---------------------------------------------------------
#pragma mark CGMatrix3x3 typedef
#pragma mark ---------------------------------------------------------
	
	typedef struct 
	{ 
		float m[3][3];
	} CGMatrix3x3;
	
#pragma mark ---------------------------------------------------------
#pragma mark End CGMatrix3x3 typedef
#pragma mark ---------------------------------------------------------
	
#pragma mark ---------------------------------------------------------
#pragma mark CGMatrix3x3 consts 
#pragma mark ---------------------------------------------------------
	
	const CGMatrix3x3 CGMatrix3x3Zero		= { 0, 0, 0,
												0, 0, 0,
												0, 0, 0 };
	
	const CGMatrix3x3 CGMatrix3x3Identity	= { 1, 0, 0,
												0, 1, 0,
												0, 0, 1 };
	
#pragma mark ---------------------------------------------------------
#pragma mark End CGMatrix3x3 consts 
#pragma mark ---------------------------------------------------------
	
#pragma mark ---------------------------------------------------------
#pragma mark CGMatrix3x3 Functions
#pragma mark ---------------------------------------------------------
	
	// ---------------------------------------------------
	// Make a CGMatrix3x3
	// ---------------------------------------------------
	inline CGMatrix3x3 CGMatrix3x3Make( float _m00, float _m01, float _m02,
									    float _m10, float _m11, float _m12,
									    float _m20, float _m21, float _m22 )
	{
		CGMatrix3x3 matrix;
		matrix.m[0][0] = _m00; matrix.m[0][1] = _m01; matrix.m[0][2] = _m02;
		matrix.m[1][0] = _m10; matrix.m[1][1] = _m11; matrix.m[1][2] = _m12;
		matrix.m[2][0] = _m20; matrix.m[2][1] = _m21; matrix.m[2][2] = _m22;
		return matrix;
	}
	
	// ---------------------------------------------------
	// Make a CGMatrix3x3
	// ---------------------------------------------------
	inline CGMatrix3x3 CGMatrix3x3Make( const CGVector3D & _r0, const CGVector3D & _r1, const CGVector3D & _r2 )
	{
		CGMatrix3x3 matrix;
		matrix.m[0][0] = _r0.x; matrix.m[0][1] = _r0.y; matrix.m[0][2] = _r0.z;
		matrix.m[1][0] = _r1.x; matrix.m[1][1] = _r1.y; matrix.m[1][2] = _r1.z;
		matrix.m[2][0] = _r2.x; matrix.m[2][1] = _r2.y; matrix.m[2][2] = _r2.z;
		return matrix;
	}
	
#pragma mark ---------------------------------------------------------
#pragma mark CGMatrix3x3 Functions
#pragma mark ---------------------------------------------------------

};

#endif