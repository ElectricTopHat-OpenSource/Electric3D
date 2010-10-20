/*
 *  CGQuaternion.h
 *  Electric3D
 *
 *  Created by Robert McDowell on 28/09/2010.
 *  Copyright 2010 Electric TopHat Ltd. All rights reserved.
 *
 */

#if !defined(__CGQuaternion_h__)
#define __CGQuaternion_h__

#import "CGMathsConstants.h"
#import "CGMathsTypes.h"

namespace CGMaths 
{	
#pragma mark ---------------------------------------------------------
#pragma mark CGQuaternion consts 
#pragma mark ---------------------------------------------------------
	
	const CGQuaternion CGQuaternionZero		= { 0, 0, 0, 0 };
	const CGQuaternion CGQuaternionIdentity = { 0, 0, 0, 1 };
	
#pragma mark ---------------------------------------------------------
#pragma mark End CGQuaternion consts 
#pragma mark ---------------------------------------------------------
	
#pragma mark ---------------------------------------------------------
#pragma mark CGQuaternion Functions
#pragma mark ---------------------------------------------------------

	// ---------------------------------------------------
	// Length Squared of a CGQuaternion
	// ---------------------------------------------------
	inline float CGQuaternionLengthSquared( const CGQuaternion & _quat )
	{
		return (_quat.x * _quat.x) + (_quat.y * _quat.y) + (_quat.z * _quat.z) + (_quat.w * _quat.w);
	}
	
	// ---------------------------------------------------
	// Length of a CGQuaternion 
	// ---------------------------------------------------
	inline float CGQuaternionLength( const CGQuaternion & _quat )
	{
		return sqrt(CGQuaternionLengthSquared(_quat));
	}
	
	// ---------------------------------------------------
	// Normalise a CGQuaternion
	// ---------------------------------------------------
	inline void CGQuaternionNormalise( CGQuaternion & _quat )
	{
		float lenSq = CGQuaternionLengthSquared(_quat);
		if ( lenSq > EPSILON )
		{
			if ( lenSq != 1.0f ) // Maybe add a tollerance ??
			{
				float len = sqrt(lenSq);
				_quat.x /= len;
				_quat.y /= len;
				_quat.z /= len;
				_quat.w /= len;
			}
		}
		else
		{
			// Maybe add a log message
			
			_quat.x = 0.0f;
			_quat.y = 0.0f;
			_quat.z = 0.0f;
			_quat.w = 0.0f;
		}
	}
	
#pragma mark ---------------------------------------------------------
#pragma mark End CGQuaternion Functions
#pragma mark ---------------------------------------------------------
	
#pragma mark ---------------------------------------------------------
#pragma mark CGQuaternion Make Functions
#pragma mark ---------------------------------------------------------
	
	// ---------------------------------------------------
	// Make a CGQuaternion Axis Angle
	// ---------------------------------------------------
	inline CGQuaternion CGQuaternionMake( float _x, float _y, float _z, float _angle )
	{
		float halfAngle = _angle * 0.5f;
		float sin		= sinf(halfAngle);
		CGQuaternion quat; 
		quat.x = _x * sin; 
		quat.y = _y * sin;
		quat.z = _z * sin;
		quat.w = cosf(halfAngle);
		CGQuaternionNormalise( quat );
		return quat;	
	}
	
	// ---------------------------------------------------
	// Make a CGQuaternion Axis Angle
	// ---------------------------------------------------
	inline CGQuaternion CGQuaternionMake( const CGVector3D & _axis, float _angle )
	{
		return CGQuaternionMake( _axis.x, _axis.y, _axis.z, _angle );
	}
	
	// ---------------------------------------------------
	// Make a CGQuaternion
	// ---------------------------------------------------
	inline CGQuaternion CGQuaternionMake( const CGMatrix3x3 & _matrix )
	{
		CGQuaternion quat; 

		float trace = _matrix.m00 + _matrix.m11 + _matrix.m22;
		if( trace > 0 ) 
		{
			float s = 0.5f / sqrtf(trace+ 1.0f);
			quat.w = 0.25f / s;
			quat.x = ( _matrix.m21 - _matrix.m12 ) * s;
			quat.y = ( _matrix.m02 - _matrix.m20 ) * s;
			quat.z = ( _matrix.m10 - _matrix.m01 ) * s;
		}
		else 
		{
			if ( ( _matrix.m00 > _matrix.m11 ) && 
				 ( _matrix.m00 > _matrix.m22 ) )
			{
				float s = 2.0f * sqrtf( 1.0f + _matrix.m00 - _matrix.m11 - _matrix.m22 );
				quat.w = (_matrix.m21 - _matrix.m12 ) / s;
				quat.x = 0.25f * s;
				quat.y = (_matrix.m01 + _matrix.m10 ) / s;
				quat.z = (_matrix.m02 + _matrix.m20 ) / s;
			}
			else if ( _matrix.m11 > _matrix.m22 ) 
			{
				float s = 2.0f * sqrtf( 1.0f + _matrix.m11 - _matrix.m00 - _matrix.m22);
				quat.w = (_matrix.m02 - _matrix.m20 ) / s;
				quat.x = (_matrix.m01 + _matrix.m10 ) / s;
				quat.y = 0.25f * s;
				quat.z = (_matrix.m12 + _matrix.m21 ) / s;
			} 
			else 
			{
				float s = 2.0f * sqrtf( 1.0f + _matrix.m22 - _matrix.m00 - _matrix.m11 );
				quat.w = (_matrix.m10 - _matrix.m01 ) / s;
				quat.x = (_matrix.m02 + _matrix.m20 ) / s;
				quat.y = (_matrix.m12 + _matrix.m21 ) / s;
				quat.z = 0.25f * s;
			}
		}

		return quat;
	}

	// ---------------------------------------------------
	// Make a CGQuaternion
	// ---------------------------------------------------
	inline CGQuaternion CGQuaternionMake( const CGMatrix4x4 & _matrix )
	{
		CGQuaternion quat; 
		
		float trace = _matrix.m00 + _matrix.m11 + _matrix.m22;
		if( trace > 0 ) 
		{
			float s = 0.5f / sqrtf(trace+ 1.0f);
			quat.w = 0.25f / s;
			quat.x = ( _matrix.m21 - _matrix.m12 ) * s;
			quat.y = ( _matrix.m02 - _matrix.m20 ) * s;
			quat.z = ( _matrix.m10 - _matrix.m01 ) * s;
		}
		else 
		{
			if ( ( _matrix.m00 > _matrix.m11 ) && 
				( _matrix.m00 > _matrix.m22 ) )
			{
				float s = 2.0f * sqrtf( 1.0f + _matrix.m00 - _matrix.m11 - _matrix.m22 );
				quat.w = (_matrix.m21 - _matrix.m12 ) / s;
				quat.x = 0.25f * s;
				quat.y = (_matrix.m01 + _matrix.m10 ) / s;
				quat.z = (_matrix.m02 + _matrix.m20 ) / s;
			}
			else if ( _matrix.m11 > _matrix.m22 ) 
			{
				float s = 2.0f * sqrtf( 1.0f + _matrix.m11 - _matrix.m00 - _matrix.m22);
				quat.w = (_matrix.m02 - _matrix.m20 ) / s;
				quat.x = (_matrix.m01 + _matrix.m10 ) / s;
				quat.y = 0.25f * s;
				quat.z = (_matrix.m12 + _matrix.m21 ) / s;
			} 
			else 
			{
				float s = 2.0f * sqrtf( 1.0f + _matrix.m22 - _matrix.m00 - _matrix.m11 );
				quat.w = (_matrix.m10 - _matrix.m01 ) / s;
				quat.x = (_matrix.m02 + _matrix.m20 ) / s;
				quat.y = (_matrix.m12 + _matrix.m21 ) / s;
				quat.z = 0.25f * s;
			}
		}
		
		return quat;	
	}

	// ---------------------------------------------------
	// Scale a Quaternion
	// ---------------------------------------------------
	inline CGQuaternion CGQuaternionMakeScale( const CGQuaternion & _quat, float _scale )
	{
		return CGQuaternionMake( (_quat.x * _scale), 
								 (_quat.y * _scale), 
								 (_quat.z * _scale), 
								 (_quat.w *  _scale) );
	}
	
	// ---------------------------------------------------
	// Add two Quaternion
	// ---------------------------------------------------
	inline CGQuaternion CGQuaternionMakeAdd( const CGQuaternion & _quatA, const CGQuaternion & _quatB )
	{
		return CGQuaternionMake( (_quatA.x + _quatB.x),
								 (_quatA.y + _quatB.y),
								 (_quatA.z + _quatB.z),
								 (_quatA.w + _quatB.w) );
	}
	
	// ---------------------------------------------------
	// Subtract two Quaternion
	// ---------------------------------------------------
	inline CGQuaternion CGQuaternionMakeSub( const CGQuaternion & _quatA, const CGQuaternion & _quatB )
	{
		return CGQuaternionMake( (_quatA.x - _quatB.x),
								 (_quatA.y - _quatB.y),
								 (_quatA.z - _quatB.z),
								 (_quatA.w - _quatB.w) );
	}
	
	// ---------------------------------------------------
	// Multiply two Quaternion
	// ---------------------------------------------------
	inline CGQuaternion CGQuaternionMakeMultiply( const CGQuaternion & _quatA, const CGQuaternion & _quatB )
	{
		return CGQuaternionMake( (_quatB.w * _quatA.x) + (_quatB.x * _quatA.w) + (_quatB.y * _quatA.z) - (_quatB.z * _quatA.y),
								 (_quatB.w * _quatA.y) + (_quatB.y * _quatA.w) + (_quatB.z * _quatA.x) - (_quatB.x * _quatA.z),
								 (_quatB.w * _quatA.z) + (_quatB.z * _quatA.w) + (_quatB.x * _quatA.y) - (_quatB.y * _quatA.x),
								 (_quatB.w * _quatA.w) - (_quatB.x * _quatA.x) - (_quatB.y * _quatA.y) - (_quatB.z * _quatA.z) );
	}
	
	// ---------------------------------------------------
	// get a Normalise CGQuaternion
	// ---------------------------------------------------
	inline CGQuaternion CGQuaternionMakeNormalised( const CGQuaternion & _quat )
	{
		CGQuaternion normalised = _quat;
		CGQuaternionNormalise( normalised );
		return normalised;
	}
	
#pragma mark ---------------------------------------------------------
#pragma mark End CGQuaternion Functions
#pragma mark ---------------------------------------------------------
};

#endif