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
#import "CGMathsTypes.h"

namespace CGMaths 
{
	
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
	// Are equal
	// ---------------------------------------------------
	inline BOOL CGMatrix4x4AreEqual( const CGMatrix4x4 & _matrixA, const CGMatrix4x4 & _matrixB )
	{
		return memcmp( &_matrixA.m[0], &_matrixB.m[0], sizeof(CGMatrix4x4) ) == 0;
	}
	
	// ---------------------------------------------------
	// Are equal
	// ---------------------------------------------------
	inline BOOL CGMatrix4x4IsIdentity( const CGMatrix4x4 & _matrix )
	{
		return CGMatrix4x4AreEqual( _matrix, CGMatrix4x4Identity );
	}
	
	// ---------------------------------------------------
	// Make a CGMatrix4x4 Rotation ( Radians )
	// ---------------------------------------------------
	inline void CGMatrix4x4SetRotation( CGMatrix4x4 & _matrix, float _x, float _y, float _z, float _angle )
	{		
        const float c  = cos(_angle);
        const float s  = sin(_angle);
		const float c1 = (1-c);
		
        _matrix.m[0]  = _x * _x * c1 + c;
        _matrix.m[1]  = _y * _x * c1 + _z * s;
        _matrix.m[2]  = _z * _x * c1 - _y * s;
        _matrix.m[3]  = 0;
		
        _matrix.m[4]  = _x * _y * c1 - _z * s;
        _matrix.m[5]  = _y * _y * c1 + c;
        _matrix.m[6]  = _z * _y * c1 + _x * s;
        _matrix.m[7]  = 0;
		
        _matrix.m[8]  = _x * _z * c1 + _y * s;
        _matrix.m[9]  = _y * _z * c1 - _x * s;
        _matrix.m[10] = _z * _z * c1 + c;
        _matrix.m[11] = 0;
	}
	
	
	// ---------------------------------------------------
	// Set a CGMatrix4x4 Rotation ( Radians )
	// ---------------------------------------------------
	inline void CGMatrix4x4SetRotation( CGMatrix4x4 & _matrix, const CGVector3D & _axis, float _angle )
	{
		CGMatrix4x4SetRotation( _matrix, _axis.x, _axis.y, _axis.z, _angle );
	}
	
	// ---------------------------------------------------
	// Set a CGMatrix4x4 Rotation
	// ---------------------------------------------------
	inline void CGMatrix4x4SetRotation( CGMatrix4x4 & _matrix, const CGQuaternion & _quat )
	{
		_matrix.m[0]  = 1.0f - 2.0f * _quat.y * _quat.y - 2.0f * _quat.z * _quat.z;
		_matrix.m[1]  = 2.0f * _quat.x * _quat.y + 2.0f * _quat.z * _quat.w;
		_matrix.m[2]  = 2.0f * _quat.x * _quat.z - 2.0f * _quat.y * _quat.w;
		_matrix.m[3]  = 0.0f;
		
		_matrix.m[4]  = 2.0f * _quat.x * _quat.y - 2.0f * _quat.z* _quat.w;
		_matrix.m[5]  = 1.0f - 2.0f * _quat.x* _quat.x - 2.0f * _quat.z * _quat.z;
		_matrix.m[6]  = 2.0f * _quat.z* _quat.y + 2.0f * _quat.x * _quat.w;
		_matrix.m[7]  = 0.0f;
		
		_matrix.m[8]  = 2.0f * _quat.x * _quat.z + 2.0f * _quat.y * _quat.w;
		_matrix.m[9]  = 2.0f * _quat.z * _quat.y - 2.0f * _quat.x * _quat.w;
		_matrix.m[10] = 1.0f - 2.0f * _quat.x * _quat.x - 2.0f * _quat.y * _quat.y;
		_matrix.m[11] = 0.0f;
	}
	
	// ---------------------------------------------------
	// Set a CGMatrix4x4 Rotation from a 3x3 matrix
	// ---------------------------------------------------
	inline void CGMatrix4x4SetRotation( CGMatrix4x4 & _matrix, const CGMatrix3x3 & _rotation )
	{
		_matrix.m00 = _rotation.m00; _matrix.m01 = _rotation.m01; _matrix.m02 = _rotation.m02;
		_matrix.m10 = _rotation.m10; _matrix.m11 = _rotation.m11; _matrix.m12 = _rotation.m12;
		_matrix.m20 = _rotation.m20; _matrix.m21 = _rotation.m21; _matrix.m22 = _rotation.m22;
	}
	
	// ---------------------------------------------------
	// Make a CGMatrix4x4 Scale
	// ---------------------------------------------------
	inline void CGMatrix4x4SetScale( CGMatrix4x4 & _matrix, float _x, float _y, float _z )
	{		
		_matrix.m[0]  = _x;
		_matrix.m[5]  = _y;
		_matrix.m[10] = _z;
		_matrix.m[15] = 1.0f;
	}
	
	// ---------------------------------------------------
	// Make a CGMatrix4x4 Scale
	// ---------------------------------------------------
	inline void CGMatrix4x4SetScale( CGMatrix4x4 & _matrix, const CGVector3D & _scale )
	{		
		CGMatrix4x4SetScale( _matrix, _scale.x, _scale.y, _scale.z );
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
	// Invert an existing CGMatrix4x4
	// ---------------------------------------------------
	inline BOOL CGMatrix4x4Invert( CGMatrix4x4 & _m )
	{
		CGMatrix4x4 inv;
		
		inv.m[0]  =  _m.m[5]*_m.m[10]*_m.m[15]-_m.m[5]*_m.m[11]*_m.m[14]-_m.m[9]*_m.m[6]*_m.m[15] 
					+_m.m[9]*_m.m[7]*_m.m[14]+_m.m[13]*_m.m[6]*_m.m[11]-_m.m[13]*_m.m[7]*_m.m[10];
		inv.m[4]  = -_m.m[4]*_m.m[10]*_m.m[15]+_m.m[4]*_m.m[11]*_m.m[14]+_m.m[8]*_m.m[6]*_m.m[15] 
					-_m.m[8]*_m.m[7]*_m.m[14]-_m.m[12]*_m.m[6]*_m.m[11]+_m.m[12]*_m.m[7]*_m.m[10];
		inv.m[8]  =  _m.m[4]*_m.m[9]*_m.m[15]-_m.m[4]*_m.m[11]*_m.m[13]-_m.m[8]*_m.m[5]*_m.m[15]
					+_m.m[8]*_m.m[7]*_m.m[13]+_m.m[12]*_m.m[5]*_m.m[11]-_m.m[12]*_m.m[7]*_m.m[9];
		inv.m[12] = -_m.m[4]*_m.m[9]*_m.m[14]+_m.m[4]*_m.m[10]*_m.m[13]+_m.m[8]*_m.m[5]*_m.m[14] 
					-_m.m[8]*_m.m[6]*_m.m[13]-_m.m[12]*_m.m[5]*_m.m[10]+_m.m[12]*_m.m[6]*_m.m[9];
		
		float det = _m.m[0]*inv.m[0] + _m.m[1]*inv.m[4] + _m.m[2]*inv.m[8] + _m.m[3]*inv.m[12];
		if (det != 0.0f)
		{
			inv.m[1]  = -_m.m[1]*_m.m[10]*_m.m[15]+_m.m[1]*_m.m[11]*_m.m[14]+_m.m[9]*_m.m[2]*_m.m[15]
						-_m.m[9]*_m.m[3]*_m.m[14]-_m.m[13]*_m.m[2]*_m.m[11]+_m.m[13]*_m.m[3]*_m.m[10];
			inv.m[5]  =  _m.m[0]*_m.m[10]*_m.m[15]-_m.m[0]*_m.m[11]*_m.m[14]-_m.m[8]*_m.m[2]*_m.m[15]
						+_m.m[8]*_m.m[3]*_m.m[14]+_m.m[12]*_m.m[2]*_m.m[11]-_m.m[12]*_m.m[3]*_m.m[10];
			inv.m[9]  = -_m.m[0]*_m.m[9]*_m.m[15]+_m.m[0]*_m.m[11]*_m.m[13]+_m.m[8]*_m.m[1]*_m.m[15]
						-_m.m[8]*_m.m[3]*_m.m[13]-_m.m[12]*_m.m[1]*_m.m[11]+_m.m[12]*_m.m[3]*_m.m[9];
			inv.m[13] =  _m.m[0]*_m.m[9]*_m.m[14]-_m.m[0]*_m.m[10]*_m.m[13]-_m.m[8]*_m.m[1]*_m.m[14]
						+_m.m[8]*_m.m[2]*_m.m[13]+_m.m[12]*_m.m[1]*_m.m[10]-_m.m[12]*_m.m[2]*_m.m[9];
			inv.m[2]  =  _m.m[1]*_m.m[6]*_m.m[15]-_m.m[1]*_m.m[7]*_m.m[14]-_m.m[5]*_m.m[2]*_m.m[15]
						+_m.m[5]*_m.m[3]*_m.m[14]+_m.m[13]*_m.m[2]*_m.m[7]-_m.m[13]*_m.m[3]*_m.m[6];
			inv.m[6]  = -_m.m[0]*_m.m[6]*_m.m[15]+_m.m[0]*_m.m[7]*_m.m[14]+_m.m[4]*_m.m[2]*_m.m[15]
						-_m.m[4]*_m.m[3]*_m.m[14]-_m.m[12]*_m.m[2]*_m.m[7]+_m.m[12]*_m.m[3]*_m.m[6];
			inv.m[10] =  _m.m[0]*_m.m[5]*_m.m[15]-_m.m[0]*_m.m[7]*_m.m[13]-_m.m[4]*_m.m[1]*_m.m[15]
						+_m.m[4]*_m.m[3]*_m.m[13]+_m.m[12]*_m.m[1]*_m.m[7]-_m.m[12]*_m.m[3]*_m.m[5];
			inv.m[14] = -_m.m[0]*_m.m[5]*_m.m[14]+_m.m[0]*_m.m[6]*_m.m[13]+_m.m[4]*_m.m[1]*_m.m[14]
						-_m.m[4]*_m.m[2]*_m.m[13]-_m.m[12]*_m.m[1]*_m.m[6]+_m.m[12]*_m.m[2]*_m.m[5];
			inv.m[3]  = -_m.m[1]*_m.m[6]*_m.m[11]+_m.m[1]*_m.m[7]*_m.m[10]+_m.m[5]*_m.m[2]*_m.m[11]
						-_m.m[5]*_m.m[3]*_m.m[10]-_m.m[9]*_m.m[2]*_m.m[7]+_m.m[9]*_m.m[3]*_m.m[6];
			inv.m[7]  =  _m.m[0]*_m.m[6]*_m.m[11]-_m.m[0]*_m.m[7]*_m.m[10]-_m.m[4]*_m.m[2]*_m.m[11]
						+_m.m[4]*_m.m[3]*_m.m[10]+_m.m[8]*_m.m[2]*_m.m[7]-_m.m[8]*_m.m[3]*_m.m[6];
			inv.m[11] = -_m.m[0]*_m.m[5]*_m.m[11]+_m.m[0]*_m.m[7]*_m.m[9]+_m.m[4]*_m.m[1]*_m.m[11]
						-_m.m[4]*_m.m[3]*_m.m[9]-_m.m[8]*_m.m[1]*_m.m[7]+_m.m[8]*_m.m[3]*_m.m[5];
			inv.m[15] =  _m.m[0]*_m.m[5]*_m.m[10]-_m.m[0]*_m.m[6]*_m.m[9]-_m.m[4]*_m.m[1]*_m.m[10]
						+_m.m[4]*_m.m[2]*_m.m[9]+_m.m[8]*_m.m[1]*_m.m[6]-_m.m[8]*_m.m[2]*_m.m[5];
			
			det = 1.0 / det;
			int i;
			for (i = 0; i < 16; i++)
			{
				_m.m[i] = inv.m[i] * det;
			}
			return TRUE;
		}
		return FALSE;
	}	
	// ---------------------------------------------------
	// Make the Matrix Orthogonale 
	// ---------------------------------------------------
	inline void CGMatrix4x4Othogonalize( CGMatrix4x4 & _matrix )
	{
		CGMaths::CGVector3D at		= { _matrix.m[2], _matrix.m[6], _matrix.m[10] };
		CGMaths::CGVector3D up		= { _matrix.m[1], _matrix.m[5], _matrix.m[9] };
		CGMaths::CGVector3D right;
		
		CGMaths::CGVector3DNormalise( at );
		right = CGMaths::CGVector3DMakeCrossProduct( at, up );
		CGMaths::CGVector3DNormalise( right );
		up = CGMaths::CGVector3DMakeCrossProduct( right, at );
		
		_matrix.m[2] = at.x;	_matrix.m[6] = at.y;	_matrix.m[10] = at.z;
		_matrix.m[1] = up.x;	_matrix.m[5] = up.y;	_matrix.m[ 9] = up.z;
		_matrix.m[0] = right.x; _matrix.m[4] = right.y; _matrix.m[ 8] = right.z;	
	}
	
	// ---------------------------------------------------
	// Translate an existing CGMatrix4x4
	// ---------------------------------------------------
	inline void CGMatrix4x4Translate( CGMatrix4x4 & _matrix, float _x, float _y, float _z )
	{
		_matrix.m[12] *= _x;   
		_matrix.m[13] *= _y;   
		_matrix.m[14] *= _z;
	}
	
	// ---------------------------------------------------
	// Translate an existing CGMatrix4x4
	// ---------------------------------------------------
	inline void CGMatrix4x4Translate( CGMatrix4x4 & _matrix, const CGVector3D & _translation )
	{
		CGMatrix4x4Translate( _matrix, _translation.x, _translation.y, _translation.z );
	}
	
	// ---------------------------------------------------
	// Transform a Vector 3D
	// ---------------------------------------------------
	inline CGVector3D CGMatrix4x4TransformVector( const CGMatrix4x4 & _matrix, float _x, float _y, float _z )
	{
		return CGVector3DMake( ( _matrix.m[0] * _x + _matrix.m[4] * _y + _matrix.m[8] * _z + _matrix.m[12] ),
							   ( _matrix.m[1] * _x + _matrix.m[5] * _y + _matrix.m[9] * _z + _matrix.m[13] ),
							   ( _matrix.m[2] * _x + _matrix.m[6] * _y + _matrix.m[10] * _z + _matrix.m[14] ) );
	}
	
	// ---------------------------------------------------
	// Transform a Vector 3D
	// ---------------------------------------------------
	inline CGVector3D CGMatrix4x4TransformVector( const CGMatrix4x4 & _matrix, const CGVector3D & _vector )
	{
		return CGMatrix4x4TransformVector( _matrix, _vector.x, _vector.y, _vector.z );
	}
	
	// ---------------------------------------------------
	// Transform a Vector 4D
	// ---------------------------------------------------
	inline CGVector4D CGMatrix4x4TransformVector( const CGMatrix4x4 & _matrix, float _x, float _y, float _z, float _w )
	{
		return CGVector4DMake( ( _matrix.m[0] * _x + _matrix.m[4] * _y + _matrix.m[8] *  _z + _matrix.m[12] * _w ),
							   ( _matrix.m[1] * _x + _matrix.m[5] * _y + _matrix.m[9] *  _z + _matrix.m[13] * _w ),
							   ( _matrix.m[2] * _x + _matrix.m[6] * _y + _matrix.m[10] * _z + _matrix.m[14] * _w ),
							   ( _matrix.m[3] * _x + _matrix.m[7] * _y + _matrix.m[11] * _z + _matrix.m[15] * _w ) );
	}
	
	// ---------------------------------------------------
	// Transform a Vector 4D
	// ---------------------------------------------------
	inline CGVector4D CGMatrix4x4TransformVector( const CGMatrix4x4 & _matrix, const CGVector4D & _vector )
	{
		return CGMatrix4x4TransformVector( _matrix, _vector.x, _vector.y, _vector.z, _vector.w );
	}
	
	// ---------------------------------------------------
	// Get the matrix translation value
	// ---------------------------------------------------
	inline CGVector3D CGMatrix4x4GetTranslation( const CGMatrix4x4 & _matrix )
	{
		return CGVector3DMake( _matrix.m[12], _matrix.m[13], _matrix.m[14] );
	}
	
	// ---------------------------------------------------
	// Get the matrix Pos value
	// ---------------------------------------------------
	inline CGVector3D CGMatrix4x4GetPos( const CGMatrix4x4 & _matrix )
	{
		return CGMatrix4x4GetTranslation( _matrix );
	}
	
	// ---------------------------------------------------
	// Get the matrix at value
	// ---------------------------------------------------
	inline CGVector3D CGMatrix4x4GetAt( const CGMatrix4x4 & _matrix )
	{
		return CGVector3DMake( _matrix.m[2], _matrix.m[6], _matrix.m[10] );
	}
	
	// ---------------------------------------------------
	// Get the matrix up value
	// ---------------------------------------------------
	inline CGVector3D CGMatrix4x4GetUp( const CGMatrix4x4 & _matrix )
	{
		return CGVector3DMake( _matrix.m[1], _matrix.m[5], _matrix.m[9] );
	}
	
	// ---------------------------------------------------
	// Get the matrix right value
	// ---------------------------------------------------
	inline CGVector3D CGMatrix4x4GetRight( const CGMatrix4x4 & _matrix )
	{
		return CGVector3DMake( _matrix.m[0], _matrix.m[4], _matrix.m[8] );
	}
	
	// ---------------------------------------------------
	// Set the Translate an existing CGMatrix4x4
	// ---------------------------------------------------
	inline void CGMatrix4x4SetTranslation( CGMatrix4x4 & _matrix, float _x, float _y, float _z )
	{
		_matrix.m[12] = _x; _matrix.m[13] = _y; _matrix.m[14] = _z;
	}
	
	// ---------------------------------------------------
	// Set the matrix translation value
	// ---------------------------------------------------
	inline void CGMatrix4x4SetTranslation( CGMatrix4x4 & _matrix, const CGVector3D & _translation )
	{
		CGMatrix4x4SetTranslation( _matrix, _translation.x, _translation.y, _translation.z );
	}
	
	// ---------------------------------------------------
	// Set the at of an existing CGMatrix4x4
	// ---------------------------------------------------
	inline void CGMatrix4x4SetAt( CGMatrix4x4 & _matrix, float _x, float _y, float _z )
	{
		_matrix.m[2] = _x; _matrix.m[6] = _y; _matrix.m[10] = _z;
	}
	
	// ---------------------------------------------------
	// Set the matrix at value
	// ---------------------------------------------------
	inline void CGMatrix4x4SetAt( CGMatrix4x4 & _matrix, const CGVector3D & _at )
	{
		CGMatrix4x4SetAt( _matrix, _at.x, _at.y, _at.z );
	}
	
	// ---------------------------------------------------
	// Set the matrix up value
	// ---------------------------------------------------
	inline void CGMatrix4x4SetUp( CGMatrix4x4 & _matrix, float _x, float _y, float _z )
	{
		_matrix.m[1] = _x;
		_matrix.m[5] = _y; 
		_matrix.m[9] = _z;
	}
	
	// ---------------------------------------------------
	// Set the matrix up value
	// ---------------------------------------------------
	inline void CGMatrix4x4SetUp( CGMatrix4x4 & _matrix, const CGVector3D & _up )
	{
		CGMatrix4x4SetUp( _matrix, _up.x, _up.y, _up.z );
	}
	
	// ---------------------------------------------------
	// Set the matrix right value
	// ---------------------------------------------------
	inline void CGMatrix4x4SetRight( CGMatrix4x4 & _matrix, float _x, float _y, float _z )
	{
		_matrix.m[0] = _x;
		_matrix.m[4] = _y; 
		_matrix.m[8] = _z;
	}
	
	// ---------------------------------------------------
	// Set the matrix right value
	// ---------------------------------------------------
	inline void CGMatrix4x4SetRight( CGMatrix4x4 & _matrix, const CGVector3D & _right )
	{
		CGMatrix4x4SetRight( _matrix, _right.x, _right.y, _right.z );
	}
	
	// ---------------------------------------------------
	// Set the matrix to look at a point from a point
	// ---------------------------------------------------
	inline void CGMatrix4x4SetTransform( CGMatrix4x4 & _matrix, const CGVector3D & _eye, const CGVector3D & _lookat, const CGVector3D & _up = CGVector3DYAxis )
	{
		CGMaths::CGVector3D at = CGMaths::CGVector3DMakeSub( _lookat, _eye );
		CGMaths::CGVector3DNormalise( at );
		
		CGMaths::CGVector3D right = CGMaths::CGVector3DMakeCrossProduct( at, _up );
		CGMaths::CGVector3DNormalise( right );
		
		CGMaths::CGVector3D up = CGMaths::CGVector3DMakeCrossProduct( right, at );
		//CGMaths::CGVector3DNormalise( up ); //  not required as the at and right are normalized
		
		// set the camera rotation
		_matrix.m[0]  = right.x;	_matrix.m[1]  = up.x;	_matrix.m[2]  = at.x;	_matrix.m[3]  = 0.0f;
		_matrix.m[4]  = right.y;	_matrix.m[5]  = up.y;	_matrix.m[6]  = at.y;	_matrix.m[7]  = 0.0f;
		_matrix.m[8]  = right.z;	_matrix.m[9]  = up.z;	_matrix.m[10] = at.z;	_matrix.m[11] = 0.0f;
		
		// Set the translation
		_matrix.m[12] = _eye.x;		_matrix.m[13] = _eye.y; _matrix.m[14] = _eye.z; _matrix.m[15] = 1.0f;
	}
	
	// ---------------------------------------------------
	// Set the matrix with a rotation and translation
	// ---------------------------------------------------
	inline void CGMatrix4x4SetTransform( CGMatrix4x4 & _matrix, const CGQuaternion & _rotation, const CGVector3D & _translation )
	{
		CGMaths::CGMatrix4x4SetRotation( _matrix, _rotation );
		CGMaths::CGMatrix4x4SetTranslation( _matrix, _translation );
	}
	
#pragma mark ---------------------------------------------------------
#pragma mark CGMatrix4x4 Functions
#pragma mark ---------------------------------------------------------
	
#pragma mark ---------------------------------------------------------
#pragma mark CGMatrix4x4 Make Functions
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
		matrix.m00  = _m00; matrix.m01  = _m01; matrix.m02  = _m02; matrix.m03  = _m03;
		matrix.m10  = _m10; matrix.m11  = _m11; matrix.m12  = _m12; matrix.m13  = _m13;
		matrix.m20  = _m20; matrix.m21  = _m21; matrix.m22  = _m22; matrix.m23  = _m23;
		matrix.m30  = _m30; matrix.m31  = _m31; matrix.m32  = _m32; matrix.m33  = _m33;
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
	inline CGMatrix4x4 CGMatrix4x4Make( const CGMatrix3x3 & _matrix )
	{
		CGMatrix4x4 matrix;
		matrix.m00 = _matrix.m00; matrix.m01 = _matrix.m01; matrix.m02 = _matrix.m02; matrix.m03 = 0.0f;
		matrix.m10 = _matrix.m10; matrix.m11 = _matrix.m11; matrix.m12 = _matrix.m12; matrix.m13 = 0.0f;
		matrix.m20 = _matrix.m20; matrix.m21 = _matrix.m21; matrix.m22 = _matrix.m22; matrix.m23 = 0.0f;
		matrix.m30 = 0.0f;		  matrix.m31 = 0.0f;		matrix.m32 = 0.0f;		  matrix.m33 = 1.0f;
		return matrix;
	}
	
	// ---------------------------------------------------
	// Make a CGMatrix4x4
	// ---------------------------------------------------	
	inline CGMatrix4x4 CGMatrix4x4Make( const CGQuaternion & _quat )
	{
		CGMatrix4x4 matrix;
		
		CGMatrix4x4SetRotation(matrix, _quat);
		
		// set the translation to the identity
		matrix.m[12] = 0.0f; 
		matrix.m[13] = 0.0f; 
		matrix.m[14] = 0.0f; 
		matrix.m[15] = 1.0f;
		
		return matrix;
	}
		
	// ---------------------------------------------------
	// Make a CGMatrix4x4 Rotation ( Radians )
	// ---------------------------------------------------
	inline CGMatrix4x4 CGMatrix4x4MakeRotation( float _x, float _y, float _z, float _angle )
	{
		CGMatrix4x4 matrix;
		
		// set the matrix rotation 
		CGMatrix4x4SetRotation( matrix, _x, _y, _z, _angle );
		
		// set the translation
        matrix.m[12] = 0.0f;
        matrix.m[13] = 0.0f;
        matrix.m[14] = 0.0f;
        matrix.m[15] = 1.0f;
		
		return matrix;
	}
	
	// ---------------------------------------------------
	// Make a CGMatrix4x4 Rotation ( Radians )
	// ---------------------------------------------------
	inline CGMatrix4x4 CGMatrix4x4MakeRotation( const CGVector3D & _axis, float _angle )
	{
		CGVector3D v = CGVector3DMakeNormalised(_axis);
		CGMatrix4x4 matrix;
		
		// set the matrix rotation 
		CGMatrix4x4SetRotation( matrix, v.x, v.y, v.z, _angle );
		
		// set the translation
		matrix.m[12] = 0.0f;
        matrix.m[13] = 0.0f;
        matrix.m[14] = 0.0f;
        matrix.m[15] = 1.0f;
		
		return matrix;
	}
	
	// ---------------------------------------------------
	// Make a CGMatrix4x4 Rotation
	// ---------------------------------------------------
	inline CGMatrix4x4 CGMatrix4x4MakeRotation( const CGQuaternion & _quat )
	{
		CGMatrix4x4 matrix;
		
		// set the matrix rotation
		CGMatrix4x4SetRotation( matrix, _quat );
		
		// set the translation
		matrix.m[12] = 0.0f;
        matrix.m[13] = 0.0f;
        matrix.m[14] = 0.0f;
        matrix.m[15] = 1.0f;
		
		return matrix;
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
	// Add 2 CGMatrix4x4's
	// ---------------------------------------------------
	inline CGMatrix4x4 CGMatrix4x4MakeAdd( const CGMatrix4x4 & _matrixA, const CGMatrix4x4 & _matrixB )
	{
		return CGMatrix4x4Make( _matrixA.m[0]  + _matrixB.m[0],  _matrixA.m[1]  + _matrixB.m[1],  _matrixA.m[2]  + _matrixB.m[2],  _matrixA.m[3]  + _matrixB.m[3],
							    _matrixA.m[4]  + _matrixB.m[4],  _matrixA.m[5]  + _matrixB.m[5],  _matrixA.m[6]  + _matrixB.m[6],  _matrixA.m[7]  + _matrixB.m[7],
							    _matrixA.m[8]  + _matrixB.m[8],  _matrixA.m[9]  + _matrixB.m[9],  _matrixA.m[10] + _matrixB.m[10], _matrixA.m[11] + _matrixB.m[11],
							    _matrixA.m[12] + _matrixB.m[12], _matrixA.m[13] + _matrixB.m[13], _matrixA.m[14] + _matrixB.m[14], _matrixA.m[15] + _matrixB.m[15] );
	}
	
	// ---------------------------------------------------
	// Sub 2 CGMatrix4x4's
	// ---------------------------------------------------
	inline CGMatrix4x4 CGMatrix4x4MakeSub( const CGMatrix4x4 & _matrixA, const CGMatrix4x4 & _matrixB )
	{
		return CGMatrix4x4Make( _matrixA.m[0]  - _matrixB.m[0],  _matrixA.m[1]  - _matrixB.m[1],  _matrixA.m[2]  - _matrixB.m[2],  _matrixA.m[3]  - _matrixB.m[3],
							    _matrixA.m[4]  - _matrixB.m[4],  _matrixA.m[5]  - _matrixB.m[5],  _matrixA.m[6]  - _matrixB.m[6],  _matrixA.m[7]  - _matrixB.m[7],
							    _matrixA.m[8]  - _matrixB.m[8],  _matrixA.m[9]  - _matrixB.m[9],  _matrixA.m[10] - _matrixB.m[10], _matrixA.m[11] - _matrixB.m[11],
							    _matrixA.m[12] - _matrixB.m[12], _matrixA.m[13] - _matrixB.m[13], _matrixA.m[14] - _matrixB.m[14], _matrixA.m[15] - _matrixB.m[15] );
	}
	
	// ---------------------------------------------------
	// Multiply 2 CGMatrix4x4's
	// ---------------------------------------------------
	inline CGMatrix4x4 CGMatrix4x4MakeMultiply( const CGMatrix4x4 & _matrixA, const CGMatrix4x4 & _matrixB )
	{
		CGMatrix4x4 mat;

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
	
#pragma mark ---------------------------------------------------------
#pragma mark CGMatrix4x4 Functions
#pragma mark ---------------------------------------------------------
	
};

#endif