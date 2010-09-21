//
//  CGMathsConstants.h
//  Electric3D
//
//  Created by Robert McDowell on 21/09/2010.
//  Copyright 2010 Electric TopHat Ltd. All rights reserved.
//

#if !defined(__CGMathsConstants_h__)
#define __CGMathsConstants_h__

namespace CGMaths 
{
	
#pragma mark ---------------------------------------------------------
#pragma mark Math Constants
#pragma mark ---------------------------------------------------------
	
	// -------------------------------------------------------------------
	
	const double PI		= M_PI;
	const double PI2	= M_PI_2;
	const double PI_SQR = 9.86960440108935861883449099987615114f;
	const double HalfPI = M_PI * 0.5f;
	
	// -------------------------------------------------------------------
	
	const float EPSILON = 0.000001f;
	const float E		= 2.71828183f;
	
	// -------------------------------------------------------------------
	
	const double degreesToRadians	= M_PI / 180.0f;
	const double radiansToDegrees	= 180.0f / M_PI;
	
	const float _45_DegreesInRadians	= 045.0f * degreesToRadians;
	const float _90_DegreesInRadians	= 090.0f * degreesToRadians;
	const float _135_DegreesInRadians	= 135.0f * degreesToRadians;
	const float _180_DegreesInRadians	= 180.0f * degreesToRadians;
	const float _225_DegreesInRadians	= 225.0f * degreesToRadians;
	const float _270_DegreesInRadians	= 270.0f * degreesToRadians;
	const float _315_DegreesInRadians	= 315.0f * degreesToRadians;
	const float _360_DegreesInRadians	= 360.0f * degreesToRadians;
	
	// -------------------------------------------------------------------
	
#pragma mark ---------------------------------------------------------
#pragma mark End Math Constants
#pragma mark ---------------------------------------------------------
	
#pragma mark ---------------------------------------------------------
#pragma mark Math Macros
#pragma mark ---------------------------------------------------------
	
	inline float Degrees2Radians( float _angle ) { return _angle * degreesToRadians; };
	inline float Radians2Degrees( float _angle ) { return _angle * radiansToDegrees; };
	
#pragma mark ---------------------------------------------------------
#pragma mark End Math Macros
#pragma mark ---------------------------------------------------------
	
};

#endif
