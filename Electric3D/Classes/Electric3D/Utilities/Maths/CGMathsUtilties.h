//
//  CGMathsUtilties
//  Electric3D
//
//  Created by Robert McDowell on 21/09/2010.
//  Copyright 2010 Electric TopHat Ltd. All rights reserved.
//


#if !defined(__CGMathsUtilties_h__)
#define __CGMathsUtilties_h__

#import "CGMathsConstants.h"

namespace CGMaths 
{
#pragma mark ---------------------------------------------------------
#pragma mark MACROS
#pragma mark ---------------------------------------------------------
	
#define CLAMP( _value, _min, _max )		MAX( MIN( _value, _max ), _min )
#define LERP( _start, _end, _interp )	(((1.0f - _interp) * _start) + (_interp * _end))
	
#pragma mark ---------------------------------------------------------
#pragma mark End MACROS
#pragma mark ---------------------------------------------------------
	
#pragma mark ---------------------------------------------------------
#pragma mark Utilty Functions
#pragma mark ---------------------------------------------------------
	
	inline float Degrees2Radians( float _angle ) { return _angle * degreesToRadians; };
	inline float Radians2Degrees( float _angle ) { return _angle * radiansToDegrees; };
	
	inline float Clamp( float _value, float _min, float _max )			{ return CLAMP( _value, _min, _max ); };
	inline int   Clamp( int _value, int _min, int _max )				{ return CLAMP( _value, _min, _max ); };
	
	inline float Lerp( float _start, float _end, float _value )			{ return LERP( _start, _end, _value ); };
	inline float LerpSin( float _start, float _end, float _value )		{ float v = sin(_value * PI_HALF); return LERP( _start, _end, v ); }
	inline float LerpHermite( float _start, float _end, float _value )	{ float v = _value * _value * (3.0f - 2.0f * _value); return LERP( _start, _end, v ); }
	
#pragma mark ---------------------------------------------------------
#pragma mark End Utilty Functions
#pragma mark ---------------------------------------------------------

};

#endif
