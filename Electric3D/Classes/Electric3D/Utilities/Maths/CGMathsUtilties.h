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
	
	// simple linear tweening - no easing, no acceleration
	inline float linearTween( float _time, float _start, float _end, float _duration )
	{
		return ( _start - _end ) * _time / _duration + _start;
	}
	
	// quadratic easing in - accelerating from zero velocity
	inline float easeInQuad( float _time, float _start, float _end, float _duration )
	{
		float val = _time / _duration;
		return ( _start - _end ) * val * val + _start;
	}
	
	// quadratic easing out - decelerating to zero velocity
	inline float easeOutQuad( float _time, float _start, float _end, float _duration )
	{
		float val = _time / _duration;
		return -( _start - _end ) * val * (val-2.0f) + _start;
	}
	
	// quadratic easing in/out - acceleration until halfway, then deceleration
	inline float easeInOutQuad( float _time, float _start, float _end, float _duration )
	{
		float val = _time / ( _duration / 2.0f );
		if (val < 1) 
		{
			return ( _start - _end ) / 2.0f * val * val + _start;
		}
		else 
		{
			val--;
			return -( _start - _end ) / 2.0f * ( val * ( val - 2.0f ) - 1 ) + _start;
		}
	}
	
	// cubic easing in - accelerating from zero velocity
	inline float easeInCubic( float _time, float _start, float _end, float _duration )
	{
		float val = _time / _duration;
		return ( _start - _end ) * val * val * val + _start;
	}
	
	// cubic easing out - decelerating to zero velocity
	inline float easeOutCubic( float _time, float _start, float _end, float _duration )
	{
		float val = _time / _duration;
		val--;
		return ( _start - _end ) * ( val * val * val + 1.0f) + _start;
	}
	
	// cubic easing in/out - acceleration until halfway, then deceleration
	inline float easeInOutCubic( float _time, float _start, float _end, float _duration )
	{
		float val = _time / ( _duration / 2.0f );
		if ( val < 1 ) 
		{
			return ( _start - _end ) / 2.0f * val * val * val + _start;
		}
		else 
		{
			val -= 2.0f;
			return ( _start - _end ) / 2.0f * ( val * val * val + 2.0f ) + _start;
		}
	}
	
	// quartic easing in - accelerating from zero velocity
	inline float easeInQuart( float _time, float _start, float _end, float _duration )
	{
		float val = _time / _duration;
		return ( _start - _end ) * val * val * val * val + _start;
	}
	
	// quartic easing out - decelerating to zero velocity
	inline float easeOutQuart( float _time, float _start, float _end, float _duration )
	{
		float val = _time / _duration;
		val--;
		return -( _start - _end ) * (val * val * val * val - 1.0f) + _start;
	}
	
	// quartic easing in/out - acceleration until halfway, then decelerati
	inline float easeInOutQuart( float _time, float _start, float _end, float _duration )
	{
		float val = _time / ( _duration / 2.0f );
		if (val < 1) 
		{
			return ( _start - _end ) / 2.0f * val * val * val * val + _start;
		}
		else 
		{
			val -= 2.0f;
			return -( _start - _end ) / 2.0f * ( val * val * val * val - 2.0f) + _start;
		}
	}
	
	// quintic easing in - accelerating from zero velocity
	inline float easeInQuint( float _time, float _start, float _end, float _duration )
	{
		float val = _time / _duration;
		return ( _start - _end ) * val * val * val * val * val + _start;
	}
	
	// quintic easing out - decelerating to zero velocity
	inline float easeOutQuint( float _time, float _start, float _end, float _duration )
	{
		float val = _time / _duration;
		val--;
		return ( _start - _end ) * ( val * val * val * val * val + 1.0f ) + _start;
	}
	
	// quintic easing in/out - acceleration until halfway, then deceleration
	inline float easeInOutQuint( float _time, float _start, float _end, float _duration )
	{
		float val = _time / ( _duration / 2.0f );
		if (val < 1) 
		{ 
			return ( _start - _end ) / 2.0f * val * val * val * val * val + _start;
		}
		else 
		{
			val -= 2.0f;
			return ( _start - _end ) / 2.0f * (val * val * val * val * val + 2.0f) + _start;
		}
	}
	
	// sinusoidal easing in - accelerating from zero velocit
	inline float easeInSine( float _time, float _start, float _end, float _duration )
	{
		float val = _time / _duration;
		float change = ( _start - _end );
		return -change * cosf(val * PI_HALF) + change + _start;
	}
	
	// sinusoidal easing out - decelerating to zero velocity
	inline float easeOutSine( float _time, float _start, float _end, float _duration )
	{
		float val		= _time / _duration;
		float change	= ( _start - _end );
		return change * sinf(val * PI_HALF) + _start;
	}
	
	// sinusoidal easing in/out - accelerating until halfway, then decelerating
	inline float easeInOutSine( float _time, float _start, float _end, float _duration )
	{
		float val		= _time / _duration;
		float change	= ( _start - _end );
		return -change / 2.0f * ( cosf( PI * val ) - 1.0f ) + _start;
	}
	
	// exponential easing in - accelerating from zero velocity
	inline float easeInExpo( float _time, float _start, float _end, float _duration )
	{
		float val		= _time / _duration;
		float change	= ( _start - _end );
		return change * powf( 2.0f, 10.0f * (val - 1.0f) ) + _start;
	}
	
	// exponential easing out - decelerating to zero velocity
	inline float easeOutExpo( float _time, float _start, float _end, float _duration )
	{
		float val		= _time / _duration;
		float change	= ( _start - _end );
		return change * ( -powf( 2.0f, -10.0f * val ) + 1.0f ) + _start;
	}
	
	// exponential easing in/out - accelerating until halfway, then decelerating
	inline float easeInOutExpo( float _time, float _start, float _end, float _duration )
	{
		float val		= _time / ( _duration / 2.0f );
		float change	= ( _start - _end );
		if ( val < 1.0f ) 
		{
			return change / 2.0f * powf( 2.0f, 10.0f * (val - 1.0f) ) + _start;
		}
		else 
		{
			val--;
			return change / 2.0f * ( -powf( 2.0f, -10.0f * val) + 2.0f ) + _start;
		}
	}
	
	// circular easing in - accelerating from zero velocity
	inline float easeInCirc( float _time, float _start, float _end, float _duration )
	{
		float val		= _time / _duration;
		float change	= ( _start - _end );
		return -change * ( sqrtf( 1.0f - val * val ) - 1.0f ) + _start;
	}
	
	// circular easing out - decelerating to zero velocity
	inline float easeOutCirc( float _time, float _start, float _end, float _duration )
	{
		float val		= _time / _duration;
		float change	= ( _start - _end );
		val--;
		return change * sqrtf(1.0f - val*val) + _start;
	}
	
	// circular easing in/out - acceleration until halfway, then deceleration
	inline float easeInOutCirc( float _time, float _start, float _end, float _duration )
	{
		float val		= _time / ( _duration / 2.0f );
		float change	= ( _start - _end );
		if ( val < 1.0f ) 
		{
			return -change / 2.0f * ( sqrtf( 1.0f - val * val ) - 1.0f ) + _start;
		}
		else 
		{
			val -= 2.0f;
			return change/2.0f * ( sqrtf( 1.0f - val * val ) + 1.0f ) + _start;
		}
	}
	
	// elastic easing in - exponentially decaying sine wave
	inline float easeInElastic( float _time, float _start, float _end, float _duration ) 
	{
		if (_time == 0) 
		{
			return _start;
		}
		else if ((_time/=_duration)==1)
		{
			return _end;  
		}
		else 
		{
			float p = _duration * 0.3f;
			float a = ( _start - _end );
			float s = p / 4.0f;
			// this is a fix, again, with post-increment operators
			float postFix = a * powf( 2.0f, 10.0f * ( _time -= 1.0f ) ); 
			return -(postFix * sinf((_time*_duration-s) * ( 2.0f * PI ) / p )) + _start;
		}
	}
	
	// elastic easing out - exponentially decaying sine wave
	inline float easeOutElastic( float _time, float _start, float _end, float _duration )
	{
		if (_time == 0) 
		{
			return _start;
		}
		else if ((_time/=_duration)==1)
		{
			return _end;  
		}
		else 
		{
			float p = _duration * 0.3f;
			float a = ( _start - _end );
			float s = p / 4.0f;
			return (a * powf( 2.0f, -10.0f * _time) * sinf( (_time*_duration-s) * ( 2 * PI )/p ) + ( _start - _end ) + _start );	
		}
	}
	
	// elastic easing in out - exponentially decaying sine wave
	inline float easeInOutElastic( float _time, float _start, float _end, float _duration )
	{
		if (_time == 0) 
		{
			return _start;
		}
		else if ((_time/=_duration/2)==2)
		{
			return _end;  
		}
		else 
		{
			float p = _duration * ( 0.3f * 1.5f );
			float a = ( _start - _end );
			float s = p / 4.0f;
			
			if (_time < 1) 
			{
				// postIncrement is evil
				float postFix = a * powf( 2.0f, 10.0f * ( _time -= 1.0f ) ); 
				return -0.5f*( postFix * sin( ( _time * _duration - s ) * ( 2.0f * PI ) / p )) + _start;
			}
			else 
			{
				// postIncrement is evil
				float postFix =  a * powf( 2.0f, -10.0f * ( _time -= 1.0f ) );
				return postFix * sinf( ( _time * _duration - s ) * ( 2.0f * PI ) / p ) * 0.5f + ( _start - _end ) + _start;	
			}
		}
	}
	
	// bounce easing in - exponentially decaying parabolic bounce
	inline float easeInBounce( float _time, float _start, float _end, float _duration )
	{
		float change	= ( _start - _end ); 
		float value     = 0.0f;
		if ((_time/=_duration) < (1.0f/2.75f)) 
		{
			value = change * ( 7.5625f * _time * _time );
		}
		else if (_time < (2.0f/2.75f)) 
		{
			float postFix = _time -= ( 1.5f / 2.75f );
			value = change * ( 7.5625f * (postFix) * _time + 0.75f );
		}
		else if (_time < (2.5f/2.75f)) 
		{
			float postFix = _time -= ( 2.25f / 2.75f );
			value = change * ( 7.5625f * (postFix) * _time + 0.9375f );
		}
		else
		{
			float postFix = _time -= ( 2.625f / 2.75f );
			value = change * ( 7.5625f * (postFix) * _time + 0.984375f );
		}
		
		return change - value + _start;
	}
	
	// bounce easing out - exponentially decaying parabolic bounce
	inline float easeOutBounce( float _time, float _start, float _end, float _duration )
	{
		float change	= ( _start - _end ); 
		if ((_time/=_duration) < (1.0f/2.75f)) 
		{
			return change * ( 7.5625f * _time * _time ) + _start;
		}
		else if (_time < (2.0f/2.75f)) 
		{
			float postFix = _time -= ( 1.5f / 2.75f );
			return change * ( 7.5625f * (postFix) * _time + 0.75f ) + _start;
		}
		else if (_time < (2.5f/2.75f)) 
		{
			float postFix = _time -= ( 2.25f / 2.75f );
			return change * ( 7.5625f * (postFix) * _time + 0.9375f ) + _start;
		}
		else
		{
			float postFix = _time -= ( 2.625f / 2.75f );
			return change * ( 7.5625f * (postFix) * _time + 0.984375f) + _start;
		}
	}
	
	// bounce easing in out - exponentially decaying parabolic bounce
	inline float easeInOutBounce( float _time, float _start, float _end, float _duration )
	{
		float change	= ( _start - _end ); 
		if ( _time < _duration/2.0f )
		{
			_time *= 2.0f;
			
			float value     = 0.0f;
			if ((_time/=_duration) < (1.0f/2.75f)) 
			{
				value = change * ( 7.5625f * _time * _time );
			}
			else if (_time < (2.0f/2.75f)) 
			{
				float postFix = _time -= ( 1.5f / 2.75f );
				value = change * ( 7.5625f * (postFix) * _time + 0.75f );
			}
			else if (_time < (2.5f/2.75f)) 
			{
				float postFix = _time -= ( 2.25f / 2.75f );
				value = change * ( 7.5625f * (postFix) * _time + 0.9375f );
			}
			else
			{
				float postFix = _time -= ( 2.625f / 2.75f );
				value = change * ( 7.5625f * (postFix) * _time + 0.984375f );
			}
			
			return value * 0.5f + _start;
		}
		else 
		{
			_time = _time * 2.0f - _duration;
			
			float value     = 0.0f;
			if ((_time/=_duration) < (1.0f/2.75f)) 
			{
				value = change * ( 7.5625f * _time * _time );
			}
			else if (_time < (2.0f/2.75f)) 
			{
				float postFix = _time -= ( 1.5f / 2.75f );
				value = change * ( 7.5625f * (postFix) * _time + 0.75f );
			}
			else if (_time < (2.5f/2.75f)) 
			{
				float postFix = _time -= ( 2.25f / 2.75f );
				value = change * ( 7.5625f * (postFix) * _time + 0.9375f );
			}
			else
			{
				float postFix = _time -= ( 2.625f / 2.75f );
				value = change * ( 7.5625f * (postFix) * _time + 0.984375f );
			}
			
			return value * 0.5f + change * 0.5f + _start;
		}
	}
	
#pragma mark ---------------------------------------------------------
#pragma mark End Utilty Functions
#pragma mark ---------------------------------------------------------

};

#endif
