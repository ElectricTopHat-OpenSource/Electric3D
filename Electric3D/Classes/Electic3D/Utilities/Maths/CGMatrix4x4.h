/*
 *  CGMatrix4x4.h
 *  Electric3D
 *
 *  Created by Robert McDowell on 21/09/2010.
 *  Copyright 2010 Electric TopHat Ltd. All rights reserved.
 *
 */

#if !defined(__CGMatrix4x4_h__)
#define __CGMatrix4x4_h__

#import "CGMathsConstants.h"
#import "CGVector3D.h"
#import "CGVector4D.h"

namespace CGMaths 
{
	
#pragma mark ---------------------------------------------------------
#pragma mark CGMatrix4x4 typedef
#pragma mark ---------------------------------------------------------
	
	typedef struct 
	{ 
		float m[16];
	} CGMatrix4x4;
	
#pragma mark ---------------------------------------------------------
#pragma mark End CGMatrix4x4 typedef
#pragma mark ---------------------------------------------------------

#pragma mark ---------------------------------------------------------
#pragma mark CGMatrix4x4 consts 
#pragma mark ---------------------------------------------------------
	
	const CGMatrix4x4 CGMatrix4x4Zero		= { 0, 0, 0, 0,
												0, 0, 0, 0,
												0, 0, 0, 0,
												0, 0, 0, 0 };
	
	const CGMatrix4x4 CGMatrix4x4Identity	= { 1, 0, 0, 0,
												0, 1, 0, 0,
												0, 0, 1, 0,
												0, 0, 0, 1 };
	
#pragma mark ---------------------------------------------------------
#pragma mark End CGMatrix4x4 consts 
#pragma mark ---------------------------------------------------------
	
#pragma mark ---------------------------------------------------------
#pragma mark CGMatrix4x4 Functions
#pragma mark ---------------------------------------------------------
	
	// ---------------------------------------------------
	// Make a CGMatrix4x4
	// ---------------------------------------------------
	inline CGMatrix4x4 CGMatrix4x4Make( float _m00, float _m01, float _m02, float _m03, 
									    float _m10, float _m11, float _m12, float _m13,
									    float _m20, float _m21, float _m22, float _m23,
									    float _m30, float _m31, float _m32, float _m33)
	{
		CGMatrix4x4 matrix;
		matrix.m[0]  = _m00; matrix.m[1]  = _m01; matrix.m[2]  = _m02; matrix.m[3]  = _m03;
		matrix.m[4]  = _m10; matrix.m[5]  = _m11; matrix.m[6]  = _m12; matrix.m[7]  = _m13;
		matrix.m[8]  = _m20; matrix.m[9]  = _m21; matrix.m[10] = _m22; matrix.m[11] = _m23;
		matrix.m[12] = _m30; matrix.m[13] = _m31; matrix.m[14] = _m32; matrix.m[15] = _m33;
		return matrix;
	}
	
	// ---------------------------------------------------
	// Make a CGMatrix4x4
	// ---------------------------------------------------
	inline CGMatrix4x4 CGMatrix4x4Make( const CGVector4D & _r0, const CGVector4D & _r1, const CGVector4D & _r2, const CGVector4D & _r3 )
	{
		CGMatrix4x4 matrix;
		matrix.m[0]  = _r0.x; matrix.m[1]  = _r0.y; matrix.m[2]  = _r0.z; matrix.m[3]  = _r0.w;
		matrix.m[4]  = _r1.x; matrix.m[5]  = _r1.y; matrix.m[6]  = _r1.z; matrix.m[7]  = _r1.w;
		matrix.m[8]  = _r2.x; matrix.m[9]  = _r2.y; matrix.m[10] = _r2.z; matrix.m[11] = _r2.w;
		matrix.m[12] = _r3.x; matrix.m[13] = _r3.y; matrix.m[14] = _r3.z; matrix.m[15] = _r3.w;
		return matrix;
	}
	
	// ---------------------------------------------------
	// Make a CGMatrix4x4
	// ---------------------------------------------------
	inline CGMatrix4x4 CGMatrix4x4Make( const CGMatrix4x4 & _matrix )
	{
		return _matrix;
	}
	
	// ---------------------------------------------------
	// Make a CGMatrix4x4 Rotation ( Radians )
	// ---------------------------------------------------
	inline CGMatrix4x4 CGMatrix4x4MakeRotation( float _x, float _y, float _z, float _angle )
	{
		CGMatrix4x4 matrix;
		
        const float c  = cos(_angle);
        const float s  = sin(_angle);
		const float c1 = (1-c);
		
        matrix.m[0]  = _x * _x * c1 + c;
        matrix.m[1]  = _y * _x * c1 + _z * s;
        matrix.m[2]  = _z * _x * c1 - _y * s;
        matrix.m[3]  = 0;
		
        matrix.m[4]  = _x * _y * c1 - _z * s;
        matrix.m[5]  = _y * _y * c1 + c;
        matrix.m[6]  = _z * _y * c1 + _x * s;
        matrix.m[7]  = 0;
		
        matrix.m[8]  = _x * _z * c1 + _y * s;
        matrix.m[9]  = _y * _z * c1 - _x * s;
        matrix.m[10] = _z * _z * c1 + c;
        matrix.m[11] = 0;
		
        matrix.m[12] = 0;
        matrix.m[13] = 0;
        matrix.m[14] = 0;
        matrix.m[15] = 1;
		
		return matrix;
	}
	
	// ---------------------------------------------------
	// Make a CGMatrix4x4 Rotation ( Radians )
	// ---------------------------------------------------
	inline CGMatrix4x4 CGMatrix4x4MakeRotation( const CGVector3D & _axis, float _angle )
	{
		CGVector3D v = CGVector3DNormalised(_axis);
		return CGMatrix4x4MakeRotation( v.x, v.y, v.z, _angle );
	}
	
	// ---------------------------------------------------
	// Make a CGMatrix4x4 Scale
	// ---------------------------------------------------
	inline CGMatrix4x4 CGMatrix4x4MakeScale( float _x, float _y, float _z )
	{
		CGMatrix4x4 matrix;
		
		matrix.m[0]  = _x;	 matrix.m[1]  = 0.0f; matrix.m[2]  = 0.0f; matrix.m[3]  = 0.0f;
		matrix.m[4]  = 0.0f; matrix.m[5]  = _y;	  matrix.m[6]  = 0.0f; matrix.m[7]  = 0.0f;
		matrix.m[8]  = 0.0f; matrix.m[9]  = 0.0f; matrix.m[10] = _z;   matrix.m[11] = 0.0f;
		matrix.m[12] = 0.0f; matrix.m[13] = 0.0f; matrix.m[14] = 0.0f; matrix.m[15] = 1.0f;
		
		return matrix;
	}
	
	// ---------------------------------------------------
	// Make a CGMatrix4x4 Scale
	// ---------------------------------------------------
	inline CGMatrix4x4 CGMatrix4x4MakeScale( const CGVector3D & _scale )
	{
		return CGMatrix4x4MakeScale( _scale.x, _scale.y, _scale.z );
	}
	
	// ---------------------------------------------------
	// Make a CGMatrix4x4 Translation
	// ---------------------------------------------------
	inline CGMatrix4x4 CGMatrix4x4MakeTranslation( float _x, float _y, float _z )
	{
		CGMatrix4x4 matrix;
		
		matrix.m[0]  = 1.0f; matrix.m[1]  = 0.0f; matrix.m[2]  = 0.0f; matrix.m[3]  = 0.0f;
		matrix.m[4]  = 0.0f; matrix.m[5]  = 1.0f; matrix.m[6]  = 0.0f; matrix.m[7]  = 0.0f;
		matrix.m[8]  = 0.0f; matrix.m[9]  = 0.0f; matrix.m[10] = 1.0f; matrix.m[11] = 0.0f;
		matrix.m[12] = _x;   matrix.m[13] = _y;   matrix.m[14] = _z;   matrix.m[15] = 1.0f;
		
		return matrix;
	}
	
	// ---------------------------------------------------
	// Make a CGMatrix4x4 Translation
	// ---------------------------------------------------
	inline CGMatrix4x4 CGMatrix4x4MakeTranslation( const CGVector3D & _translation )
	{		
		return CGMatrix4x4MakeTranslation( _translation.x, _translation.y, _translation.z );
	}
	
	// ---------------------------------------------------
	// Negate a CGMatrix4x4
	// ---------------------------------------------------
	inline void CGMatrix4x4Negate( CGMatrix4x4 & _matrix )
	{
		_matrix.m[0]  = -_matrix.m[0];  _matrix.m[1]  = -_matrix.m[1];  _matrix.m[2]  = -_matrix.m[2];  _matrix.m[3] = -_matrix.m[3];
		_matrix.m[4]  = -_matrix.m[4];  _matrix.m[5]  = -_matrix.m[5];  _matrix.m[6]  = -_matrix.m[6];  _matrix.m[7] = -_matrix.m[7];
		_matrix.m[8]  = -_matrix.m[8];  _matrix.m[9]  = -_matrix.m[9];  _matrix.m[10] = -_matrix.m[10]; _matrix.m[11] = -_matrix.m[11];
		_matrix.m[12] = -_matrix.m[12]; _matrix.m[13] = -_matrix.m[13]; _matrix.m[14] = -_matrix.m[14]; _matrix.m[15] = -_matrix.m[15];
	}
	
	// ---------------------------------------------------
	// Scale an existing CGMatrix4x4
	// ---------------------------------------------------
	inline void CGMatrix4x4Scale( CGMatrix4x4 & _matrix, float _scale )
	{
		_matrix.m[0]  *= _scale; _matrix.m[1]  *= _scale; _matrix.m[2]  *= _scale; _matrix.m[3]  *= _scale;
		_matrix.m[4]  *= _scale; _matrix.m[5]  *= _scale; _matrix.m[6]  *= _scale; _matrix.m[7]  *= _scale;
		_matrix.m[8]  *= _scale; _matrix.m[9]  *= _scale; _matrix.m[10] *= _scale; _matrix.m[11] *= _scale;
		_matrix.m[12] *= _scale; _matrix.m[13] *= _scale; _matrix.m[14] *= _scale; _matrix.m[15] *= _scale;
	}
	
	// ---------------------------------------------------
	// Add 2 CGMatrix4x4's
	// ---------------------------------------------------
	inline CGMatrix4x4 CGMatrix4x4Add( const CGMatrix4x4 & _matrixA, const CGMatrix4x4 & _matrixB )
	{
		return CGMatrix4x4Make( _matrixA.m[0]  + _matrixB.m[0],  _matrixA.m[1]  + _matrixB.m[1],  _matrixA.m[2]  + _matrixB.m[2],  _matrixA.m[3]  + _matrixB.m[3],
							    _matrixA.m[4]  + _matrixB.m[4],  _matrixA.m[5]  + _matrixB.m[5],  _matrixA.m[6]  + _matrixB.m[6],  _matrixA.m[7]  + _matrixB.m[7],
							    _matrixA.m[8]  + _matrixB.m[8],  _matrixA.m[9]  + _matrixB.m[9],  _matrixA.m[10] + _matrixB.m[10], _matrixA.m[11] + _matrixB.m[11],
							    _matrixA.m[12] + _matrixB.m[12], _matrixA.m[13] + _matrixB.m[13], _matrixA.m[14] + _matrixB.m[14], _matrixA.m[15] + _matrixB.m[15] );
	}
	
	// ---------------------------------------------------
	// Sub 2 CGMatrix4x4's
	// ---------------------------------------------------
	inline CGMatrix4x4 CGMatrix4x4Sub( const CGMatrix4x4 & _matrixA, const CGMatrix4x4 & _matrixB )
	{
		return CGMatrix4x4Make( _matrixA.m[0]  - _matrixB.m[0],  _matrixA.m[1]  - _matrixB.m[1],  _matrixA.m[2]  - _matrixB.m[2],  _matrixA.m[3]  - _matrixB.m[3],
							    _matrixA.m[4]  - _matrixB.m[4],  _matrixA.m[5]  - _matrixB.m[5],  _matrixA.m[6]  - _matrixB.m[6],  _matrixA.m[7]  - _matrixB.m[7],
							    _matrixA.m[8]  - _matrixB.m[8],  _matrixA.m[9]  - _matrixB.m[9],  _matrixA.m[10] - _matrixB.m[10], _matrixA.m[11] - _matrixB.m[11],
							    _matrixA.m[12] - _matrixB.m[12], _matrixA.m[13] - _matrixB.m[13], _matrixA.m[14] - _matrixB.m[14], _matrixA.m[15] - _matrixB.m[15] );
	}
	
	// ---------------------------------------------------
	// Multiply 2 CGMatrix4x4's
	// ---------------------------------------------------
	inline CGMatrix4x4 CGMatrix4x4Multiply( const CGMatrix4x4 & _matrixA, const CGMatrix4x4 & _matrixB )
	{
		CGMatrix4x4 mat = CGMatrix4x4Zero;

		mat.m[ 0] = _matrixA.m[ 0]*_matrixB.m[ 0] + _matrixA.m[ 1]*_matrixB.m[ 4] + _matrixA.m[ 2]*_matrixB.m[ 8] + _matrixA.m[ 3]*_matrixB.m[12];
		mat.m[ 1] = _matrixA.m[ 0]*_matrixB.m[ 1] + _matrixA.m[ 1]*_matrixB.m[ 5] + _matrixA.m[ 2]*_matrixB.m[ 9] + _matrixA.m[ 3]*_matrixB.m[13];
		mat.m[ 2] = _matrixA.m[ 0]*_matrixB.m[ 2] + _matrixA.m[ 1]*_matrixB.m[ 6] + _matrixA.m[ 2]*_matrixB.m[10] + _matrixA.m[ 3]*_matrixB.m[14];
		mat.m[ 3] = _matrixA.m[ 0]*_matrixB.m[ 3] + _matrixA.m[ 1]*_matrixB.m[ 7] + _matrixA.m[ 2]*_matrixB.m[11] + _matrixA.m[ 3]*_matrixB.m[15];
		
		mat.m[ 4] = _matrixA.m[ 4]*_matrixB.m[ 0] + _matrixA.m[ 5]*_matrixB.m[ 4] + _matrixA.m[ 6]*_matrixB.m[ 8] + _matrixA.m[ 7]*_matrixB.m[12];
		mat.m[ 5] = _matrixA.m[ 4]*_matrixB.m[ 1] + _matrixA.m[ 5]*_matrixB.m[ 5] + _matrixA.m[ 6]*_matrixB.m[ 9] + _matrixA.m[ 7]*_matrixB.m[13];
		mat.m[ 6] = _matrixA.m[ 4]*_matrixB.m[ 2] + _matrixA.m[ 5]*_matrixB.m[ 6] + _matrixA.m[ 6]*_matrixB.m[10] + _matrixA.m[ 7]*_matrixB.m[14];
		mat.m[ 7] = _matrixA.m[ 4]*_matrixB.m[ 3] + _matrixA.m[ 5]*_matrixB.m[ 7] + _matrixA.m[ 6]*_matrixB.m[11] + _matrixA.m[ 7]*_matrixB.m[15];
		
		mat.m[ 8] = _matrixA.m[ 8]*_matrixB.m[ 0] + _matrixA.m[ 9]*_matrixB.m[ 4] + _matrixA.m[10]*_matrixB.m[ 8] + _matrixA.m[11]*_matrixB.m[12];
		mat.m[ 9] = _matrixA.m[ 8]*_matrixB.m[ 1] + _matrixA.m[ 9]*_matrixB.m[ 5] + _matrixA.m[10]*_matrixB.m[ 9] + _matrixA.m[11]*_matrixB.m[13];
		mat.m[10] = _matrixA.m[ 8]*_matrixB.m[ 2] + _matrixA.m[ 9]*_matrixB.m[ 6] + _matrixA.m[10]*_matrixB.m[10] + _matrixA.m[11]*_matrixB.m[14];
		mat.m[11] = _matrixA.m[ 8]*_matrixB.m[ 3] + _matrixA.m[ 9]*_matrixB.m[ 7] + _matrixA.m[10]*_matrixB.m[11] + _matrixA.m[11]*_matrixB.m[15];
		
		mat.m[12] = _matrixA.m[12]*_matrixB.m[ 0] + _matrixA.m[13]*_matrixB.m[ 4] + _matrixA.m[14]*_matrixB.m[ 8] + _matrixA.m[15]*_matrixB.m[12];
		mat.m[13] = _matrixA.m[12]*_matrixB.m[ 1] + _matrixA.m[13]*_matrixB.m[ 5] + _matrixA.m[14]*_matrixB.m[ 9] + _matrixA.m[15]*_matrixB.m[13];
		mat.m[14] = _matrixA.m[12]*_matrixB.m[ 2] + _matrixA.m[13]*_matrixB.m[ 6] + _matrixA.m[14]*_matrixB.m[10] + _matrixA.m[15]*_matrixB.m[14];
		mat.m[15] = _matrixA.m[12]*_matrixB.m[ 3] + _matrixA.m[13]*_matrixB.m[ 7] + _matrixA.m[14]*_matrixB.m[11] + _matrixA.m[15]*_matrixB.m[15];
		
		return mat;
	}
	
	// ---------------------------------------------------
	// Transform a Vector 3D
	// ---------------------------------------------------
	inline CGVector3D CGMatrix4x4TransformVector( const CGMatrix4x4 & _matrix, const CGVector3D & _vector )
	{
		return CGVector3DMake( ( _matrix.m[0] * _vector.x + _matrix.m[4] * _vector.y + _matrix.m[8] * _vector.z + _matrix.m[12] ),
							   ( _matrix.m[1] * _vector.x + _matrix.m[5] * _vector.y + _matrix.m[9] * _vector.z + _matrix.m[13] ),
							   ( _matrix.m[2] * _vector.x + _matrix.m[6] * _vector.y + _matrix.m[10] * _vector.z + _matrix.m[14] ) );
	}
		
#pragma mark ---------------------------------------------------------
#pragma mark CGMatrix4x4 Functions
#pragma mark ---------------------------------------------------------
	
};

#endif