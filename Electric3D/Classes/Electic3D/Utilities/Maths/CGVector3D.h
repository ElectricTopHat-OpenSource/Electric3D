//
//  CGVector3D.h
//  Electric3D
//
//  Created by Robert McDowell on 21/09/2010.
//  Copyright 2010 Electric TopHat Ltd. All rights reserved.
//

#if !defined(__CGVector3D_h__)
#define __CGVector3D_h__

#import "CGMathsConstants.h"

namespace CGMaths 
{
#pragma mark ---------------------------------------------------------
#pragma mark Vector3D typedef
#pragma mark ---------------------------------------------------------
	
	typedef struct 
	{ 
		float x;
		float y;
		float z;
		
	} CGVector3D;
	
#pragma mark ---------------------------------------------------------
#pragma mark End Vector3D typedef
#pragma mark ---------------------------------------------------------
	
#pragma mark ---------------------------------------------------------
#pragma mark CGVector3D consts 
#pragma mark ---------------------------------------------------------
	
	const CGVector3D CGVector3DZero = { 0, 0, 0 };
	
#pragma mark ---------------------------------------------------------
#pragma mark End CGVector3D consts 
#pragma mark ---------------------------------------------------------
	
#pragma mark ---------------------------------------------------------
#pragma mark Utilty Functions
#pragma mark ---------------------------------------------------------
	
	// ---------------------------------------------------
	// Get the Length Squared of a vector
	// ---------------------------------------------------
	inline float VectorLengthSquared( float _x, float _y, float _z )
	{
		return (_x * _x) + (_y * _y) + (_z * _z);
	}
	
	// ---------------------------------------------------
	// Get the Length of a vector
	// ---------------------------------------------------
	inline float VectorLength( float _x, float _y, float _z )
	{
		return sqrt(VectorLengthSquared(_x, _y, _z));
	}
	
#pragma mark ---------------------------------------------------------
#pragma mark End Utilty Functions
#pragma mark ---------------------------------------------------------

#pragma mark ---------------------------------------------------------
#pragma mark CGVector3D Functions
#pragma mark ---------------------------------------------------------
	
	// ---------------------------------------------------
	// Make a CGVector2D
	// ---------------------------------------------------
	inline CGVector3D CGVector3DMake( float _x, float _y, float _z )
	{
		CGVector3D vector; 
		vector.x = _x; 
		vector.y = _y;
		vector.z = _z;
		return vector;
	}
	
	/*
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
	*/
	
	// ---------------------------------------------------
	// Scale an existing CGVectro3D
	// ---------------------------------------------------
	inline CGVector3D CGVector3DScale( const CGVector3D & _vector, float _scale )
	{
		return CGVector3DMake( _vector.x * _scale, _vector.y * _scale, _vector.z * _scale );
	}
	
	// ---------------------------------------------------
	// Add 2 CGVectro3D's
	// ---------------------------------------------------
	inline CGVector3D CGVector3DAdd( const CGVector3D & _vectorA, const CGVector3D & _vectorB )
	{
		return CGVector3DMake( _vectorA.x + _vectorB.x, _vectorA.y + _vectorB.y, _vectorA.z + _vectorB.z );
	}
	
	// ---------------------------------------------------
	// Sub 2 CGVectro3D's
	// ---------------------------------------------------
	inline CGVector3D CGVector3DSub( const CGVector3D & _vectorA, const CGVector3D & _vectorB )
	{
		return CGVector3DMake( _vectorA.x - _vectorB.x, _vectorA.y - _vectorB.y, _vectorA.z - _vectorB.z );
	}
	
	// ---------------------------------------------------
	// Multiply 2 CGVectro3D's
	// ---------------------------------------------------
	inline CGVector3D CGVector3DMult( const CGVector3D & _vectorA, const CGVector3D & _vectorB )
	{
		return CGVector3DMake( _vectorA.x * _vectorB.x, _vectorA.y * _vectorB.y, _vectorA.z * _vectorB.z );
	}
	
	// ---------------------------------------------------
	// Divide 2 CGVectro3D's
	// ---------------------------------------------------
	inline CGVector3D CGVector3DDiv( const CGVector3D & _vectorA, const CGVector3D & _vectorB )
	{
		return CGVector3DMake( _vectorA.x / _vectorB.x, _vectorA.y / _vectorB.y, _vectorA.z / _vectorB.z );
	}
	
	// ---------------------------------------------------
	// Negate a CGVectro3D
	// ---------------------------------------------------
	inline CGVector3D CGVector3DNegate( const CGVector3D & _vector )
	{
		return CGVector3DMake( -_vector.x, -_vector.y, -_vector.z );
	}
	
	// ---------------------------------------------------
	// CGVectro3D minimum values of x,y,z independently
	// ---------------------------------------------------
	inline CGVector3D CGVector3DMin( const CGVector3D & _vectorA, const CGVector3D & _vectorB )
	{
		return CGVector3DMake( ( ( _vectorA.x < _vectorB.x ) ? _vectorA.x : _vectorB.x ),
							   ( ( _vectorA.y < _vectorB.y ) ? _vectorA.y : _vectorB.y ),
							   ( ( _vectorA.z < _vectorB.z ) ? _vectorA.z : _vectorB.z ) );
	}
	
	// ---------------------------------------------------
	// CGVectro3D maximum values of x,y,z independently
	// ---------------------------------------------------
	inline CGVector3D CGVector3DMax( const CGVector3D & _vectorA, const CGVector3D & _vectorB )
	{
		return CGVector3DMake( ( ( _vectorA.x > _vectorB.x ) ? _vectorA.x : _vectorB.x ),
							   ( ( _vectorA.y > _vectorB.y ) ? _vectorA.y : _vectorB.y ),
							   ( ( _vectorA.z > _vectorB.z ) ? _vectorA.z : _vectorB.z ) );
	}
	
	// ---------------------------------------------------
	// Length Squared of a CGVector3D
	// ---------------------------------------------------
	inline float CGVector3DLengthSquared( const CGVector3D & _vector )
	{
		return (_vector.x * _vector.x) + (_vector.y * _vector.y) + (_vector.z * _vector.z);
	}
	
	// ---------------------------------------------------
	// Length of a CGVector3D 
	// ---------------------------------------------------
	inline float CGVector3DLength( const CGVector3D & _vector )
	{
		return sqrt(CGVector3DLengthSquared(_vector));
	}
	
	// ---------------------------------------------------
	// Normalise a 3D Vector
	// ---------------------------------------------------
	inline void CGVector3DNormalise( CGVector3D & _vector )
	{
		float lenSq = CGVector3DLengthSquared(_vector);
		if ( lenSq > EPSILON )
		{
			if ( lenSq != 1.0f ) // Maybe add a tollerance ??
			{
				float len = sqrt(lenSq);
				_vector.x /= len;
				_vector.y /= len;
				_vector.z /= len;
			}
		}
		else
		{
			// Maybe add a log message
			
			_vector.x = 0.0f;
			_vector.y = 0.0f;
			_vector.z = 0.0f;
		}
	}
	
	// ---------------------------------------------------
	// Normalise a 3D Vector
	// ---------------------------------------------------
	inline CGVector3D CGVector3DNormalised( const CGVector3D & _vector )
	{
		CGVector3D normalisedVector = _vector;
		CGVector3DNormalise( normalisedVector );
		return normalisedVector;
	}
	
	// ---------------------------------------------------
	// CrossProduct of two 3D Vectors
	// ---------------------------------------------------
	inline CGVector3D CGVector3DCrossProduct( const CGVector3D & _vectorA, const CGVector3D & _vectorB )
	{
		return CGVector3DMake( ( _vectorA.y * _vectorB.z - _vectorA.z * _vectorB.y ),
							   ( _vectorA.z * _vectorB.x - _vectorA.x * _vectorB.z ),
							   ( _vectorA.x * _vectorB.y - _vectorA.y * _vectorB.x ) );
	}
	
	// ---------------------------------------------------
	// DotProduct of two 3D Vectors
	// ---------------------------------------------------
	inline float CGVector3DDotProduct( const CGVector3D & _vectorA, const CGVector3D & _vectorB )
	{
		return (_vectorA.x * _vectorB.x) + 
			   (_vectorA.y * _vectorB.y) + 
		       (_vectorA.y * _vectorB.y);
	}
	
	// ---------------------------------------------------
	// Angle between two 3D Vectors (Radians)
	// ---------------------------------------------------
	inline float CGVector3DAngle( const CGVector3D & _vectorA, const CGVector3D & _vectorB )
	{
		CGVector3D normA = CGVector3DNormalised( _vectorA );
		CGVector3D normB = CGVector3DNormalised( _vectorB );
		float dotProduct = CGVector3DDotProduct( normA, normB );
		float angleInRadians = acos(dotProduct);
		return angleInRadians;
	}
	
#pragma mark ---------------------------------------------------------
#pragma mark End Math Utilty Functions : CGPoint
#pragma mark ---------------------------------------------------------
};
	
#endif