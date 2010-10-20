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
#import "CGMathsTypes.h"

namespace CGMaths 
{
	
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
		matrix.m00  = _m00; matrix.m01 = _m01; matrix.m02 = _m02;
		matrix.m10  = _m10; matrix.m11 = _m11; matrix.m12 = _m12;
		matrix.m20  = _m20; matrix.m21 = _m21; matrix.m22 = _m22;
		return matrix;
	}
	
	// ---------------------------------------------------
	// Make a CGMatrix3x3
	// ---------------------------------------------------
	inline CGMatrix3x3 CGMatrix3x3Make( const CGVector3D & _r0, const CGVector3D & _r1, const CGVector3D & _r2 )
	{
		CGMatrix3x3 matrix;
		matrix.m00 = _r0.x; matrix.m01 = _r0.y; matrix.m02 = _r0.z;
		matrix.m10 = _r1.x; matrix.m11 = _r1.y; matrix.m12 = _r1.z;
		matrix.m20 = _r2.x; matrix.m21 = _r2.y; matrix.m22 = _r2.z;
		return matrix;
	}
	
	// ---------------------------------------------------
	// Make a CGMatrix3x3
	// ---------------------------------------------------
	inline CGMatrix3x3 CGMatrix3x3Make( const CGMatrix4x4 & _matrix )
	{
		CGMatrix3x3 matrix;
		matrix.m00 = _matrix.m00; matrix.m01 = _matrix.m01; matrix.m02 = _matrix.m02;
		matrix.m10 = _matrix.m10; matrix.m11 = _matrix.m11; matrix.m12 = _matrix.m12;
		matrix.m20 = _matrix.m20; matrix.m21 = _matrix.m21; matrix.m22 = _matrix.m22;
		return matrix;
	}
	
#pragma mark ---------------------------------------------------------
#pragma mark CGMatrix3x3 Functions
#pragma mark ---------------------------------------------------------

};

#endif