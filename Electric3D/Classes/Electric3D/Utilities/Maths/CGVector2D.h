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

namespace CGMaths 
{
#pragma mark ---------------------------------------------------------
#pragma mark CGVector2D typedef
#pragma mark ---------------------------------------------------------
	
	typedef CGPoint CGVector2D;

#pragma mark ---------------------------------------------------------
#pragma mark End CGVector2D typedef
#pragma mark ---------------------------------------------------------
	
#pragma mark ---------------------------------------------------------
#pragma mark Utilty Functions
#pragma mark ---------------------------------------------------------
	
	// ---------------------------------------------------
	// Get the Length Squared of a vector
	// ---------------------------------------------------
	inline float VectorLengthSquared( float _x, float _y )
	{
		return (_x * _x) + (_y * _y);
	}
	
	// ---------------------------------------------------
	// Get the Length of a vector
	// ---------------------------------------------------
	inline float VectorLength( float _x, float _y )
	{
		return sqrt(VectorLengthSquared(_x, _y));
	}
	
#pragma mark ---------------------------------------------------------
#pragma mark End Utilty Functions
#pragma mark ---------------------------------------------------------
	
#pragma mark ---------------------------------------------------------
#pragma mark CGVector2D Functions
#pragma mark ---------------------------------------------------------
		
	// ---------------------------------------------------
	// Make a CGVector2D
	// ---------------------------------------------------
	inline CGVector2D CGVector2DMake( float _x, float _y )
	{
		return CGPointMake(_x, _y);
	}
	
	// ---------------------------------------------------
	// Make a Rotated CGVector2D (radians)
	// ---------------------------------------------------
	inline CGVector2D CGVector2DMakeRotation( float _angle )
	{
		float cosTheta = cos(_angle);
		float sinTheta = sin(_angle);
		
		return CGPointMake(-sinTheta, cosTheta);
	}
	
	// ---------------------------------------------------
	// Rotate an existing CGVectro2D
	// ---------------------------------------------------
	inline CGVector2D CGVector2DRotate( float _x, float _y, float _angle)
	{
		// rotate a vector
		// x' = cos(theta)*x - sin(theta)*y 
		// y' = sin(theta)*x + cos(theta)*y
		
		float cosTheta = cos(_angle);
		float sinTheta = sin(_angle);
		
		float x = cosTheta*_x - sinTheta*_y;
		float y = sinTheta*_x + cosTheta*_y;
		
		return CGPointMake(x, y);		
	}
	
	// ---------------------------------------------------
	// Rotate an existing CGVectro2D
	// ---------------------------------------------------
	inline CGVector2D CGVector2DRotate( const CGVector2D & _vector, float _angle )
	{
		return CGVector2DRotate(_vector.x, _vector.y, _angle);
	}
	
	// ---------------------------------------------------
	// Scale an existing CGVectro2D
	// ---------------------------------------------------
	inline CGVector2D CGVector2DScale( const CGVector2D & _vector, float _scale )
	{
		return CGVector2DMake( _vector.x * _scale, _vector.y * _scale );
	}
	
	// ---------------------------------------------------
	// Add 2 CGVectro2D's
	// ---------------------------------------------------
	inline CGVector2D CGVector2DAdd( const CGVector2D & _vectorA, const CGVector2D & _vectorB )
	{
		return CGVector2DMake( _vectorA.x + _vectorB.x, _vectorA.y + _vectorB.y );
	}
	
	// ---------------------------------------------------
	// Sub 2 CGVectro2D's
	// ---------------------------------------------------
	inline CGVector2D CGVector2DSub( const CGVector2D & _vectorA, const CGVector2D & _vectorB )
	{
		return CGVector2DMake( _vectorA.x - _vectorB.x, _vectorA.y - _vectorB.y );
	}
	
	// ---------------------------------------------------
	// Multiply 2 CGVectro2D's
	// ---------------------------------------------------
	inline CGVector2D CGVector2DMultiply( const CGVector2D & _vectorA, const CGVector2D & _vectorB )
	{
		return CGVector2DMake( _vectorA.x * _vectorB.x, _vectorA.y * _vectorB.y );
	}
	
	// ---------------------------------------------------
	// Divide 2 CGVectro2D's
	// ---------------------------------------------------
	inline CGVector2D CGVector2DDivide( const CGVector2D & _vectorA, const CGVector2D & _vectorB )
	{
		return CGVector2DMake( _vectorA.x / _vectorB.x, _vectorA.y / _vectorB.y );
	}
	
	// ---------------------------------------------------
	// Negate a CGVectro2D
	// ---------------------------------------------------
	inline CGVector2D CGVector2DNegate( const CGVector2D & _vector )
	{
		return CGVector2DMake( -_vector.x, -_vector.y );
	}
	
	// ---------------------------------------------------
	// CGVectro2D minimum values of x,y independently
	// ---------------------------------------------------
	inline CGVector2D CGVector2DMin( const CGVector2D & _vectorA, const CGVector2D & _vectorB )
	{
		return CGVector2DMake( ( ( _vectorA.x < _vectorB.x ) ? _vectorA.x : _vectorB.x ),
							   ( ( _vectorA.y < _vectorB.y ) ? _vectorA.y : _vectorB.y ) );
	}
	
	// ---------------------------------------------------
	// CGVectro2D maximum values of x,y independently
	// ---------------------------------------------------
	inline CGVector2D CGVector2DMax( const CGVector2D & _vectorA, const CGVector2D & _vectorB )
	{
		return CGVector2DMake( ( ( _vectorA.x > _vectorB.x ) ? _vectorA.x : _vectorB.x ),
							   ( ( _vectorA.y > _vectorB.y ) ? _vectorA.y : _vectorB.y ) );
	}
	
	// ---------------------------------------------------
	// Length Squared of a CGVector2D
	// ---------------------------------------------------
	inline float CGVector2DLengthSquared( const CGVector2D & _vector )
	{
		return (_vector.x * _vector.x) + (_vector.y * _vector.y);
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
	// Normalise a 2D Vector
	// ---------------------------------------------------
	inline CGVector2D CGVector2DNormalised( const CGVector2D & _vector )
	{
		CGVector2D normalisedVector = _vector;
		CGVector2DNormalise( normalisedVector );
		return normalisedVector;
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
		CGVector2D normA = CGVector2DNormalised( _vectorA );
		CGVector2D normB = CGVector2DNormalised( _vectorB );
		
		float dotProduct		= CGVector2DDotProduct( normA, normB );
		float angleInRadians	= acos(dotProduct);
		
		return angleInRadians;
	}
	
#pragma mark ---------------------------------------------------------
#pragma mark End CGVector2D Functions
#pragma mark ---------------------------------------------------------

#pragma mark ---------------------------------------------------------
#pragma mark CGVector2D consts 
#pragma mark ---------------------------------------------------------
	
	const CGVector2D CGVector2DZero = CGVector2DMake( 0, 0 );
	
#pragma mark ---------------------------------------------------------
#pragma mark End CGVector2D consts 
#pragma mark ---------------------------------------------------------
	
};

#endif