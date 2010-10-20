//
//  CGVector2D
//  Electric3D
//
//  Created by Robert McDowell on 21/09/2010.
//  Copyright 2010 Electric TopHat Ltd. All rights reserved.
//

#if !defined(__CGVector2D_h__)
#define __CGVector2D_h__

#import "CGMathsConstants.h"
#import "CGMathsTypes.h"

namespace CGMaths 
{	
#pragma mark ---------------------------------------------------------
#pragma mark CGVector2D consts 
#pragma mark ---------------------------------------------------------
	
	const CGVector2D CGVector2DZero = { 0, 0 };
	
#pragma mark ---------------------------------------------------------
#pragma mark End CGVector2D consts 
#pragma mark ---------------------------------------------------------
		
#pragma mark ---------------------------------------------------------
#pragma mark CGVector2D Functions
#pragma mark ---------------------------------------------------------

	// ---------------------------------------------------
	// Get the Length Squared of a vector
	// ---------------------------------------------------
	inline float CGVector2DLengthSquared( float _x, float _y )
	{
		return (_x * _x) + (_y * _y);
	}
	
	// ---------------------------------------------------
	// Length Squared of a CGVector2D
	// ---------------------------------------------------
	inline float CGVector2DLengthSquared( const CGVector2D & _vector )
	{
		return CGVector2DLengthSquared(_vector.x, _vector.y);
	}
	
	// ---------------------------------------------------
	// Length of a CGVector2D 
	// ---------------------------------------------------
	inline float CGVector2DLength( float _x, float _y )
	{
		return sqrt(CGVector2DLengthSquared(_x, _y));
	}
	
	// ---------------------------------------------------
	// Length of a CGVector2D 
	// ---------------------------------------------------
	inline float CGVector2DLength( const CGVector2D & _vector )
	{
		return sqrt(CGVector2DLengthSquared(_vector));
	}
	
	// ---------------------------------------------------
	// Normalise a 2D Vector
	// ---------------------------------------------------
	inline void CGVector2DNormalise( CGVector2D & _vector )
	{
		float lenSq = CGVector2DLengthSquared(_vector);
		if ( lenSq > EPSILON )
		{
			if ( lenSq != 1.0f ) // Maybe add a tollerance ??
			{
				float len = sqrt(lenSq);
				_vector.x /= len;
				_vector.y /= len;
			}
		}
		else
		{
			// Maybe add a log message
			
			_vector.x = 0.0f;
			_vector.y = 0.0f;
		}
	}
	
	// ---------------------------------------------------
	// DotProduct of two 2D Vectors
	// ---------------------------------------------------
	inline float CGVector2DDotProduct( const CGVector2D & _vectorA, const CGVector2D & _vectorB )
	{
		return (_vectorA.x * _vectorB.x) + (_vectorA.y * _vectorB.y);
	}
	
	// ---------------------------------------------------
	// Angle between two 2D Vectors (Radians)
	// ---------------------------------------------------
	inline float CGVector2DAngle( const CGVector2D & _vectorA, const CGVector2D & _vectorB )
	{
		CGVector2D normA = _vectorA;
		CGVector2D normB = _vectorB;
		
		CGVector2DNormalise( normA );
		CGVector2DNormalise( normB );
		
		float dotProduct		= CGVector2DDotProduct( normA, normB );
		float angleInRadians	= acos(dotProduct);
		
		return angleInRadians;
	}
	
	// ---------------------------------------------------
	// Are equal
	// ---------------------------------------------------
	inline BOOL CGVector2DAreEqual( const CGVector2D & _vectorA, const CGVector2D & _vectorB, float _tolerance = EPSILON )
	{
		return ( ( fabsf(_vectorA.x - _vectorB.x) < _tolerance ) &&
				 ( fabsf(_vectorA.y - _vectorB.y) < _tolerance ) );
	}
	
#pragma mark ---------------------------------------------------------
#pragma mark End CGVector2D Functions
#pragma mark ---------------------------------------------------------
	
#pragma mark ---------------------------------------------------------
#pragma mark CGVector2D Make Functions
#pragma mark ---------------------------------------------------------
	
	// ---------------------------------------------------
	// Make a CGVector2D
	// ---------------------------------------------------
	inline CGVector2D CGVector2DMake( float _x, float _y )
	{
		CGVector2D vec;
		vec.x = _x;
		vec.y = _y;
		return vec;
	}
	
	// ---------------------------------------------------
	// Make a Rotated CGVector2D (radians)
	// ---------------------------------------------------
	inline CGVector2D CGVector2DMakeRotation( float _angle )
	{
		float cosTheta = cos(_angle);
		float sinTheta = sin(_angle);
		
		return CGVector2DMake(-sinTheta, cosTheta);
	}
	
	// ---------------------------------------------------
	// Rotate an existing CGVectro2D
	// ---------------------------------------------------
	inline CGVector2D CGVector2DMakeRotate( float _x, float _y, float _angle)
	{
		// rotate a vector
		// x' = cos(theta)*x - sin(theta)*y 
		// y' = sin(theta)*x + cos(theta)*y
		
		float cosTheta = cos(_angle);
		float sinTheta = sin(_angle);
		
		float x = cosTheta*_x - sinTheta*_y;
		float y = sinTheta*_x + cosTheta*_y;
		
		return CGVector2DMake(x, y);		
	}
	
	// ---------------------------------------------------
	// Rotate an existing CGVectro2D
	// ---------------------------------------------------
	inline CGVector2D CGVector2DMakeRotate( const CGVector2D & _vector, float _angle )
	{
		return CGVector2DMakeRotate(_vector.x, _vector.y, _angle);
	}
	
	// ---------------------------------------------------
	// Scale an existing CGVectro2D
	// ---------------------------------------------------
	inline CGVector2D CGVector2DMakeScale( const CGVector2D & _vector, float _scale )
	{
		return CGVector2DMake( _vector.x * _scale, _vector.y * _scale );
	}
	
	// ---------------------------------------------------
	// Add 2 CGVectro2D's
	// ---------------------------------------------------
	inline CGVector2D CGVector2DMakeAdd( const CGVector2D & _vectorA, const CGVector2D & _vectorB )
	{
		return CGVector2DMake( _vectorA.x + _vectorB.x, _vectorA.y + _vectorB.y );
	}
	
	// ---------------------------------------------------
	// Sub 2 CGVectro2D's
	// ---------------------------------------------------
	inline CGVector2D CGVector2DMakeSub( const CGVector2D & _vectorA, const CGVector2D & _vectorB )
	{
		return CGVector2DMake( _vectorA.x - _vectorB.x, _vectorA.y - _vectorB.y );
	}
	
	// ---------------------------------------------------
	// Multiply 2 CGVectro2D's
	// ---------------------------------------------------
	inline CGVector2D CGVector2DMakeMultiply( const CGVector2D & _vectorA, const CGVector2D & _vectorB )
	{
		return CGVector2DMake( _vectorA.x * _vectorB.x, _vectorA.y * _vectorB.y );
	}
	
	// ---------------------------------------------------
	// Divide 2 CGVectro2D's
	// ---------------------------------------------------
	inline CGVector2D CGVector2DMakeDivide( const CGVector2D & _vectorA, const CGVector2D & _vectorB )
	{
		return CGVector2DMake( _vectorA.x / _vectorB.x, _vectorA.y / _vectorB.y );
	}
	
	// ---------------------------------------------------
	// Negate a CGVectro2D
	// ---------------------------------------------------
	inline CGVector2D CGVector2DMakeNegate( const CGVector2D & _vector )
	{
		return CGVector2DMake( -_vector.x, -_vector.y );
	}
	
	// ---------------------------------------------------
	// CGVectro2D minimum values of x,y independently
	// ---------------------------------------------------
	inline CGVector2D CGVector2DMakeMin( const CGVector2D & _vectorA, const CGVector2D & _vectorB )
	{
		return CGVector2DMake( ( ( _vectorA.x < _vectorB.x ) ? _vectorA.x : _vectorB.x ),
							   ( ( _vectorA.y < _vectorB.y ) ? _vectorA.y : _vectorB.y ) );
	}
	
	// ---------------------------------------------------
	// CGVectro2D maximum values of x,y independently
	// ---------------------------------------------------
	inline CGVector2D CGVector2DMakeMax( const CGVector2D & _vectorA, const CGVector2D & _vectorB )
	{
		return CGVector2DMake( ( ( _vectorA.x > _vectorB.x ) ? _vectorA.x : _vectorB.x ),
							   ( ( _vectorA.y > _vectorB.y ) ? _vectorA.y : _vectorB.y ) );
	}
	
	// ---------------------------------------------------
	// Make a Normalise 2D Vector
	// ---------------------------------------------------
	inline CGVector2D CGVector2DMakeNormalised( const CGVector2D & _vector )
	{
		CGVector2D normalisedVector = _vector;
		CGVector2DNormalise( normalisedVector );
		return normalisedVector;
	}
	
#pragma mark ---------------------------------------------------------
#pragma mark End CGVector2D Make Functions
#pragma mark ---------------------------------------------------------
	
};

#endif