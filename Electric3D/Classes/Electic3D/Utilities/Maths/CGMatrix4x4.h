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
		float m[4][4];
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
		matrix.m[0][0] = _m00; matrix.m[0][1] = _m01; matrix.m[0][2] = _m02; matrix.m[0][3] = _m03;
		matrix.m[1][0] = _m10; matrix.m[1][1] = _m11; matrix.m[1][2] = _m12; matrix.m[1][3] = _m13;
		matrix.m[2][0] = _m20; matrix.m[2][1] = _m21; matrix.m[2][2] = _m22; matrix.m[2][3] = _m23;
		matrix.m[3][0] = _m30; matrix.m[3][1] = _m31; matrix.m[3][2] = _m32; matrix.m[3][3] = _m33;
		return matrix;
	}
	
	// ---------------------------------------------------
	// Make a CGMatrix4x4
	// ---------------------------------------------------
	inline CGMatrix4x4 CGMatrix4x4Make( const CGVector4D & _r0, const CGVector4D & _r1, const CGVector4D & _r2, const CGVector4D & _r3 )
	{
		CGMatrix4x4 matrix;
		matrix.m[0][0] = _r0.x; matrix.m[0][1] = _r0.y; matrix.m[0][2] = _r0.z; matrix.m[0][3] = _r0.w;
		matrix.m[1][0] = _r1.x; matrix.m[1][1] = _r1.y; matrix.m[1][2] = _r1.z; matrix.m[1][3] = _r1.w;
		matrix.m[2][0] = _r2.x; matrix.m[2][1] = _r2.y; matrix.m[2][2] = _r2.z; matrix.m[2][3] = _r2.w;
		matrix.m[3][0] = _r3.x; matrix.m[3][1] = _r3.y; matrix.m[3][2] = _r3.z; matrix.m[3][3] = _r3.w;
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
	// Make a CGMatrix4x4 ( Radians
	// ---------------------------------------------------
	inline CGMatrix4x4 CGMatrix4x4Make( const CGVector3D & _axis, float _angle )
	{
		CGMatrix4x4 matrix;

		CGVector3D v = CGVector3DNormalised(_axis);
		
        const float c  = cos(_angle);
        const float s  = sin(_angle);
		const float c1 = (1-c);
		
        matrix.m[0][0] = v.x * v.x * c1 + c;
        matrix.m[0][1] = v.y * v.x * c1 + v.z * s;
        matrix.m[0][2] = v.z * v.x * c1 - v.y * s;
        matrix.m[0][3] = 0;
		
        matrix.m[1][0] = v.x * v.y * c1 - v.z * s;
        matrix.m[1][1] = v.y * v.y * c1 + c;
        matrix.m[1][2] = v.z * v.y * c1 + v.x * s;
        matrix.m[1][3] = 0;
		
        matrix.m[2][0] = v.x * v.z * c1 + v.y * s;
        matrix.m[2][1] = v.y * v.z * c1 - v.x * s;
        matrix.m[2][2] = v.z * v.z * c1 + c;
        matrix.m[2][3] = 0;
		
        matrix.m[3][0] = 0;
        matrix.m[3][1] = 0;
        matrix.m[3][2] = 0;
        matrix.m[3][3] = 1;
		
		return matrix;
	}
	
	// ---------------------------------------------------
	// Negate a CGMatrix4x4
	// ---------------------------------------------------
	inline void CGMatrix4x4Negate( CGMatrix4x4 & _matrix )
	{
		_matrix.m[0][0] = -_matrix.m[0][0]; _matrix.m[0][1] = -_matrix.m[0][1]; _matrix.m[0][2] = -_matrix.m[0][2]; _matrix.m[0][3] = -_matrix.m[0][3];
		_matrix.m[1][0] = -_matrix.m[1][0]; _matrix.m[1][1] = -_matrix.m[1][1]; _matrix.m[1][2] = -_matrix.m[1][2]; _matrix.m[1][3] = -_matrix.m[1][3];
		_matrix.m[2][0] = -_matrix.m[2][0]; _matrix.m[2][1] = -_matrix.m[2][1]; _matrix.m[2][2] = -_matrix.m[2][2]; _matrix.m[2][3] = -_matrix.m[2][3];
		_matrix.m[3][0] = -_matrix.m[3][0]; _matrix.m[3][1] = -_matrix.m[3][1]; _matrix.m[3][2] = -_matrix.m[3][2]; _matrix.m[3][3] = -_matrix.m[3][3];
	}
	
	// ---------------------------------------------------
	// Scale an existing CGMatrix4x4
	// ---------------------------------------------------
	inline void CGMatrix4x4Scale( CGMatrix4x4 & _matrix, float _scale )
	{
		_matrix.m[0][0] *= _scale; _matrix.m[0][1] *= _scale; _matrix.m[0][2] *= _scale; _matrix.m[0][3] *= _scale;
		_matrix.m[1][0] *= _scale; _matrix.m[1][1] *= _scale; _matrix.m[1][2] *= _scale; _matrix.m[1][3] *= _scale;
		_matrix.m[2][0] *= _scale; _matrix.m[2][1] *= _scale; _matrix.m[2][2] *= _scale; _matrix.m[2][3] *= _scale;
		_matrix.m[3][0] *= _scale; _matrix.m[3][1] *= _scale; _matrix.m[3][2] *= _scale; _matrix.m[3][3] *= _scale;
	}
	
	// ---------------------------------------------------
	// Add 2 CGMatrix4x4's
	// ---------------------------------------------------
	inline CGMatrix4x4 CGMatrix4x4Add( const CGMatrix4x4 & _matrixA, const CGMatrix4x4 & _matrixB )
	{
		return CGMatrix4x4Make( _matrixA.m[0][0] + _matrixB.m[0][0], _matrixA.m[0][1] + _matrixB.m[0][1], _matrixA.m[0][2] + _matrixB.m[0][2], _matrixA.m[0][3] + _matrixB.m[0][3],
							    _matrixA.m[1][0] + _matrixB.m[1][0], _matrixA.m[1][1] + _matrixB.m[1][1], _matrixA.m[1][2] + _matrixB.m[1][2], _matrixA.m[1][3] + _matrixB.m[1][3],
							    _matrixA.m[2][0] + _matrixB.m[2][0], _matrixA.m[2][1] + _matrixB.m[2][1], _matrixA.m[2][2] + _matrixB.m[2][2], _matrixA.m[2][3] + _matrixB.m[2][3],
							    _matrixA.m[3][0] + _matrixB.m[3][0], _matrixA.m[3][1] + _matrixB.m[3][1], _matrixA.m[3][2] + _matrixB.m[3][2], _matrixA.m[3][3] + _matrixB.m[3][3] );
	}
	
	// ---------------------------------------------------
	// Sub 2 CGMatrix4x4's
	// ---------------------------------------------------
	inline CGMatrix4x4 CGMatrix4x4Sub( const CGMatrix4x4 & _matrixA, const CGMatrix4x4 & _matrixB )
	{
		return CGMatrix4x4Make( _matrixA.m[0][0] - _matrixB.m[0][0], _matrixA.m[0][1] - _matrixB.m[0][1], _matrixA.m[0][2] - _matrixB.m[0][2], _matrixA.m[0][3] - _matrixB.m[0][3],
							    _matrixA.m[1][0] - _matrixB.m[1][0], _matrixA.m[1][1] - _matrixB.m[1][1], _matrixA.m[1][2] - _matrixB.m[1][2], _matrixA.m[1][3] - _matrixB.m[1][3],
							    _matrixA.m[2][0] - _matrixB.m[2][0], _matrixA.m[2][1] - _matrixB.m[2][1], _matrixA.m[2][2] - _matrixB.m[2][2], _matrixA.m[2][3] - _matrixB.m[2][3],
							    _matrixA.m[3][0] - _matrixB.m[3][0], _matrixA.m[3][1] - _matrixB.m[3][1], _matrixA.m[3][2] - _matrixB.m[3][2], _matrixA.m[3][3] - _matrixB.m[3][3] );
	}
	
	// ---------------------------------------------------
	// Multiply 2 CGMatrix4x4's
	// ---------------------------------------------------
	inline CGMatrix4x4 CGMatrix4x4Mult( const CGMatrix4x4 & _matrixA, const CGMatrix4x4 & _matrixB )
	{
		CGMatrix4x4 mat = CGMatrix4x4Zero;
		
		int i, j, k;
		for( i = 0; i < 4; i++ )
		{
			for( j = 0; j < 4; j++ )
			{
				for( k = 0; k < 4; k++ )
				{
					mat.m[i][j] += _matrixA.m[i][k] * _matrixB.m[k][j];
				}
			}
		}
		return mat;
	}
	
	// ---------------------------------------------------
	// Transform a Vector 3D
	// ---------------------------------------------------
	inline CGVector3D CGMatrix4x4TransformVector( const CGMatrix4x4 & _matrix, const CGVector3D & _vector )
	{
		return CGVector3DMake( ( _matrix.m[0][0] * _vector.x + _matrix.m[1][0] * _vector.y + _matrix.m[2][0] * _vector.z + _matrix.m[3][0] ),
							   ( _matrix.m[0][1] * _vector.x + _matrix.m[1][1] * _vector.y + _matrix.m[2][1] * _vector.z + _matrix.m[3][1] ),
							   ( _matrix.m[0][2] * _vector.x + _matrix.m[1][2] * _vector.y + _matrix.m[2][2] * _vector.z + _matrix.m[3][2] ) );
	}
		
#pragma mark ---------------------------------------------------------
#pragma mark CGMatrix4x4 Functions
#pragma mark ---------------------------------------------------------
	
};

#endif