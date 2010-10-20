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
#import "CGMathsTypes.h"

namespace CGMaths 
{
	
#pragma mark ---------------------------------------------------------
#pragma mark CGVector3D consts 
#pragma mark ---------------------------------------------------------
	
	const CGVector3D CGVector3DZero		= { 0, 0, 0 };
	const CGVector3D CGVector3DUnit		= { 1, 1, 1 };
	const CGVector3D CGVector3DXAxis	= { 1, 0, 0 };
	const CGVector3D CGVector3DYAxis	= { 0, 1, 0 };
	const CGVector3D CGVector3DZAxis	= { 0, 0, 1 };
	
#pragma mark ---------------------------------------------------------
#pragma mark End CGVector3D consts 
#pragma mark ---------------------------------------------------------
	
#pragma mark ---------------------------------------------------------
#pragma mark CGVector3D Functions
#pragma mark ---------------------------------------------------------

	// ---------------------------------------------------
	// Get the Length Squared of a vector
	// ---------------------------------------------------
	inline float CGVector3DLengthSquared( float _x, float _y, float _z )
	{
		return (_x * _x) + (_y * _y) + (_z * _z);
	}
	
	// ---------------------------------------------------
	// Length Squared of a CGVector3D
	// ---------------------------------------------------
	inline float CGVector3DLengthSquared( const CGVector3D & _vector )
	{
		return CGVector3DLengthSquared(_vector.x, _vector.y, _vector.z);
	}
	
	// ---------------------------------------------------
	// Length of a CGVector3D 
	// ---------------------------------------------------
	inline float CGVector3DLength( float _x, float _y, float _z )
	{
		return sqrt(CGVector3DLengthSquared(_x,_y,_z));
	}
	
	// ---------------------------------------------------
	// Length of a CGVector3D 
	// ---------------------------------------------------
	inline float CGVector3DLength( const CGVector3D & _vector )
	{
		return sqrt(CGVector3DLengthSquared(_vector));
	}
	
	// ---------------------------------------------------
	// Negate a CGVectro3D
	// ---------------------------------------------------
	inline void CGVector3DNegate( CGVector3D & _vector )
	{
		_vector.x = -_vector.x;
		_vector.y = -_vector.y;
		_vector.z = -_vector.z;
	}
	
	// ---------------------------------------------------
	// Scale a CGVectro3D
	// ---------------------------------------------------
	inline void CGVector3DScale( CGVector3D & _vector, float _scale )
	{
		_vector.x = _vector.x * _scale;
		_vector.y = _vector.y * _scale;
		_vector.z = _vector.z * _scale;
	}
	
	// ---------------------------------------------------
	// Add 2 CGVectro3D's
	// ---------------------------------------------------
	inline void CGVector3DAdd( CGVector3D & _to, const CGVector3D & _from )
	{
		_to.x += _from.x;
		_to.y += _from.y;
		_to.z += _from.z;
	}
	
	// ---------------------------------------------------
	// Sub 2 CGVectro3D's
	// ---------------------------------------------------
	inline void CGVector3DSub( CGVector3D & _to, const CGVector3D & _from )
	{
		_to.x -= _from.x;
		_to.y -= _from.y;
		_to.z -= _from.z;
	}
	
	// ---------------------------------------------------
	// Multiply 2 CGVectro3D's
	// ---------------------------------------------------
	inline void CGVector3DMultiply( CGVector3D & _to, const CGVector3D & _from )
	{
		_to.x *= _from.x;
		_to.y *= _from.y;
		_to.z *= _from.z;
	}
	
	// ---------------------------------------------------
	// Divide 2 CGVectro3D's
	// ---------------------------------------------------
	inline void CGVector3DDivide( CGVector3D & _to, const CGVector3D & _from )
	{
		_to.x /= _from.x;
		_to.y /= _from.y;
		_to.z /= _from.z;
	}
	
	// ---------------------------------------------------
	// Normalise a 3D Vector
	// ---------------------------------------------------
	inline float CGVector3DNormalise( CGVector3D & _vector )
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
				
				return len;
			}
			return 1.0f;
		}
		else
		{
			// Maybe add a log message
			
			_vector.x = 0.0f;
			_vector.y = 0.0f;
			_vector.z = 0.0f;
		}
		return 0.0f;
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
		CGVector3D normA = _vectorA;
		CGVector3D normB = _vectorB;
		
		CGVector3DNormalise( normA );
		CGVector3DNormalise( normB );
		
		float dotProduct = CGVector3DDotProduct( normA, normB );
		float angleInRadians = acos(dotProduct);
		return angleInRadians;
	}
	
	// ---------------------------------------------------
	// Are equal
	// ---------------------------------------------------
	inline BOOL CGVector3DAreEqual( const CGVector3D & _vectorA, const CGVector3D & _vectorB, float _tolerance = EPSILON )
	{
		return ( ( fabsf(_vectorA.x - _vectorB.x) < _tolerance ) &&
				 ( fabsf(_vectorA.y - _vectorB.y) < _tolerance ) &&
				 ( fabsf(_vectorA.z - _vectorB.z) < _tolerance ) );
	}
	
#pragma mark ---------------------------------------------------------
#pragma mark End CGVector3D Functions
#pragma mark ---------------------------------------------------------
	
#pragma mark ---------------------------------------------------------
#pragma mark CGVector3D Make Functions
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
	
	// ---------------------------------------------------
	// Scale an existing CGVectro3D
	// ---------------------------------------------------
	inline CGVector3D CGVector3DMakeScale( const CGVector3D & _vector, float _scale )
	{
		return CGVector3DMake( _vector.x * _scale, _vector.y * _scale, _vector.z * _scale );
	}
	
	// ---------------------------------------------------
	// Add 2 CGVectro3D's
	// ---------------------------------------------------
	inline CGVector3D CGVector3DMakeAdd( const CGVector3D & _vectorA, const CGVector3D & _vectorB )
	{
		return CGVector3DMake( _vectorA.x + _vectorB.x, 
							   _vectorA.y + _vectorB.y, 
							   _vectorA.z + _vectorB.z );
	}
	
	// ---------------------------------------------------
	// Add 2 CGVectro3D's
	// ---------------------------------------------------
	inline CGVector3D CGVector3DMakeAdd( const CGVector3D & _vectorA, const CGVector3D & _vectorB, float _scaleB )
	{
		return CGVector3DMake( _vectorA.x + ( _vectorB.x * _scaleB ), 
							   _vectorA.y + ( _vectorB.y * _scaleB ), 
							   _vectorA.z + ( _vectorB.z * _scaleB ) );
	}
	
	// ---------------------------------------------------
	// Sub 2 CGVectro3D's
	// ---------------------------------------------------
	inline CGVector3D CGVector3DMakeSub( const CGVector3D & _vectorA, const CGVector3D & _vectorB )
	{
		return CGVector3DMake( _vectorA.x - _vectorB.x, _vectorA.y - _vectorB.y, _vectorA.z - _vectorB.z );
	}
	
	// ---------------------------------------------------
	// Multiply 2 CGVectro3D's
	// ---------------------------------------------------
	inline CGVector3D CGVector3DMakeMultiply( const CGVector3D & _vectorA, const CGVector3D & _vectorB )
	{
		return CGVector3DMake( _vectorA.x * _vectorB.x, _vectorA.y * _vectorB.y, _vectorA.z * _vectorB.z );
	}
	
	// ---------------------------------------------------
	// Divide 2 CGVectro3D's
	// ---------------------------------------------------
	inline CGVector3D CGVector3DMakeDivide( const CGVector3D & _vectorA, const CGVector3D & _vectorB )
	{
		return CGVector3DMake( _vectorA.x / _vectorB.x, _vectorA.y / _vectorB.y, _vectorA.z / _vectorB.z );
	}
	
	// ---------------------------------------------------
	// Negate a CGVectro3D
	// ---------------------------------------------------
	inline CGVector3D CGVector3DMakeNegate( const CGVector3D & _vector )
	{
		return CGVector3DMake( -_vector.x, -_vector.y, -_vector.z );
	}
	
	// ---------------------------------------------------
	// CGVectro3D minimum values of x,y,z independently
	// ---------------------------------------------------
	inline CGVector3D CGVector3DMakeMin( const CGVector3D & _vectorA, const CGVector3D & _vectorB )
	{
		return CGVector3DMake( ( ( _vectorA.x < _vectorB.x ) ? _vectorA.x : _vectorB.x ),
							   ( ( _vectorA.y < _vectorB.y ) ? _vectorA.y : _vectorB.y ),
							   ( ( _vectorA.z < _vectorB.z ) ? _vectorA.z : _vectorB.z ) );
	}
	
	// ---------------------------------------------------
	// CGVectro3D maximum values of x,y,z independently
	// ---------------------------------------------------
	inline CGVector3D CGVector3DMakeMax( const CGVector3D & _vectorA, const CGVector3D & _vectorB )
	{
		return CGVector3DMake( ( ( _vectorA.x > _vectorB.x ) ? _vectorA.x : _vectorB.x ),
							   ( ( _vectorA.y > _vectorB.y ) ? _vectorA.y : _vectorB.y ),
							   ( ( _vectorA.z > _vectorB.z ) ? _vectorA.z : _vectorB.z ) );
	}
	
	// ---------------------------------------------------
	// Normalise a 3D Vector
	// ---------------------------------------------------
	inline CGVector3D CGVector3DMakeNormalised( const CGVector3D & _vector )
	{
		CGVector3D normalisedVector = _vector;
		CGVector3DNormalise( normalisedVector );
		return normalisedVector;
	}
	
	// ---------------------------------------------------
	// CrossProduct of two 3D Vectors
	// ---------------------------------------------------
	inline CGVector3D CGVector3DMakeCrossProduct( const CGVector3D & _vectorA, const CGVector3D & _vectorB )
	{
		return CGVector3DMake( ( _vectorA.y * _vectorB.z - _vectorA.z * _vectorB.y ),
							   ( _vectorA.z * _vectorB.x - _vectorA.x * _vectorB.z ),
							   ( _vectorA.x * _vectorB.y - _vectorA.y * _vectorB.x ) );
	}
	
	// ---------------------------------------------------
	// Work out the closest point on the line to the target
	// ---------------------------------------------------
	inline CGVector3D CGVector3DMakeClosestPoint( const CGVector3D & _target, const CGVector3D & _start, const CGVector3D & _end )
	{
		CGVector3D lineA			= CGVector3DMakeSub( _end, _start );
		CGVector3D lineB			= CGVector3DMakeSub( _target, _start );
		
		float len	= CGVector3DNormalise( lineA );
		CGVector3DNormalise( lineB );
		
		float dotAA = CGVector3DDotProduct( lineA, lineA );
		float dotAB = CGVector3DDotProduct( lineB, lineA );
		float scale = Clamp( dotAB / dotAA, 0.0f, 1.0f );  
		
		CGVector3D point = CGVector3DMakeAdd( _start, lineA, len * scale );
		
		return point;
	}
	
#pragma mark ---------------------------------------------------------
#pragma mark End CGVector3D Make Functions
#pragma mark ---------------------------------------------------------
};
	
#endif