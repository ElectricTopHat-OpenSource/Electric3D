//
//  CGMathsUtilties
//  Electric3D
//
//  Created by Robert McDowell on 21/09/2010.
//  Copyright 2010 Electric TopHat Ltd. All rights reserved.
//


#if !defined(__CGMathsUtilties_h__)
#define __CGMathsUtilties_h__

namespace CGMaths 
{
#pragma mark ---------------------------------------------------------
#pragma mark Utilty Functions : Float
#pragma mark ---------------------------------------------------------
	
	// --------------------------------------------------
	// Fast Sin Function
	// --------------------------------------------------
	inline float fastSin( float _rad )
	{
		//always wrap input angle to -PI..PI
		while (_rad < -3.14159265f)
		{
			_rad += 6.28318531f;
		}
		while (_rad >  3.14159265f)
		{
			_rad -= 6.28318531f;
		}
		
		float sinVal = 0.0f;
		
		//compute sine
		if (_rad < 0)
			sinVal = _rad*(1.27323954 + .405284735 * _rad);
		else
			sinVal = _rad*(1.27323954 - 0.405284735 * _rad);
		
		if (sinVal < 0)
			sinVal = sinVal*(-0.225f * (sinVal + 1) + 1);
		else
			sinVal = sinVal*(0.225f * (sinVal - 1) + 1);
		
		return sinVal;
	}
	
	// --------------------------------------------------
	// Fast Cos Function
	// --------------------------------------------------
	inline float fastCos( float _rad )
	{
		//compute cosine: sin(x + PI/2) = cos(x)
		_rad += 1.57079632f;
		while (_rad < -3.14159265f)
		{
			_rad += 6.28318531f;
		}
		while (_rad >  3.14159265f)
		{
			_rad -= 6.28318531f;
		}
		
		float cosVal;
		if (_rad < 0)
			cosVal = 1.27323954f * _rad + 0.405284735f * _rad * _rad;
		else
			cosVal = 1.27323954f * _rad - 0.405284735f * _rad * _rad;
		
		if (cosVal < 0)
			cosVal = 0.225f * (cosVal *-cosVal - cosVal) + cosVal;
		else
			cosVal = 0.225f * (cosVal * cosVal - cosVal) + cosVal;
		
		return cosVal;
	}
	
	// --------------------------------------------------
	// Clamp a float between two values
	// --------------------------------------------------
	inline float fClamp( float _value, float _min, float _max )
	{
		return (_value > _min) ? (_value < _max ) ? _value : _max : _min;
	}
	
	// --------------------------------------------------
	// Loop the value
	// --------------------------------------------------
	inline float fLoop( float _value, float _min, float _max )
	{
		// TODO : Fix this function so that the value is looped correctly
		return (_value > _min) ? (_value < _max ) ? _value : _min : _max;
	}
	
	// ---------------------------------------------------
	// Lerp function
	// ---------------------------------------------------
	inline float fLerp( float _start, float _end, float _value )
	{	
		return ((1.0f - _value) * _start) + (_value * _end);
	}
	
	// ---------------------------------------------------
	// Sin Lerp function
	// ---------------------------------------------------
	inline float fSinLerp( float _start, float _end, float _value )
	{
		float value = sin(_value * HalfPI);
		
		return fLerp(_start,_end,value);
	}
	
	// ---------------------------------------------------
	// Hermite function
	// ---------------------------------------------------
	inline float fHermite( float _start, float _end, float _value )
	{
		float value = _value * _value * (3.0f - 2.0f * _value);
		
		return fLerp(_start,_end,value);
	}
	
#pragma mark ---------------------------------------------------------
#pragma mark End Utilty Functions : Float
#pragma mark ---------------------------------------------------------
};

#endif
