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

namespace CGMaths 
{
	
#pragma mark ---------------------------------------------------------
#pragma mark CGQuaternion typedef
#pragma mark ---------------------------------------------------------
	
	typedef struct 
	{ 
		float x;
		float y;
		float z;
		float w;
		
	} CGQuaternion;
	
#pragma mark ---------------------------------------------------------
#pragma mark End CGQuaternion typedef
#pragma mark ---------------------------------------------------------
	
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
	// Make a CGQuaternion
	// ---------------------------------------------------
	inline CGQuaternion CGQuaternionMake( float _x, float _y, float _z, float _w )
	{
		CGQuaternion quat; 
		quat.x = _x; 
		quat.y = _y;
		quat.z = _z;
		quat.w = _w;
		return quat;	
	}
	
	// ---------------------------------------------------
	// Scale a Quaternion
	// ---------------------------------------------------
	inline CGQuaternion CGQuaternionScale( const CGQuaternion & _quat, float _scale )
	{
		return CGQuaternionMake( (_quat.x * _scale), (_quat.y * _scale), (_quat.z * _scale), (_quat.w *  _scale) );
	}
	
	// ---------------------------------------------------
	// Add two Quaternion
	// ---------------------------------------------------
	inline CGQuaternion CGQuaternionAdd( const CGQuaternion & _quatA, const CGQuaternion & _quatB )
	{
		return CGQuaternionMake( (_quatA.x + _quatB.x),
								 (_quatA.y + _quatB.y),
								 (_quatA.z + _quatB.z),
								 (_quatA.w + _quatB.w) );
	}
	
	// ---------------------------------------------------
	// Subtract two Quaternion
	// ---------------------------------------------------
	inline CGQuaternion CGQuaternionSub( const CGQuaternion & _quatA, const CGQuaternion & _quatB )
	{
		return CGQuaternionMake( (_quatA.x - _quatB.x),
								 (_quatA.y - _quatB.y),
								 (_quatA.z - _quatB.z),
								 (_quatA.w - _quatB.w) );
	}
	
	// ---------------------------------------------------
	// Multiply two Quaternion
	// ---------------------------------------------------
	inline CGQuaternion CGQuaternionMultiply( const CGQuaternion & _quatA, const CGQuaternion & _quatB )
	{
		return CGQuaternionMake( (_quatB.w * _quatA.x) + (_quatB.x * _quatA.w) + (_quatB.y * _quatA.z) - (_quatB.z * _quatA.y),
								 (_quatB.w * _quatA.y) + (_quatB.y * _quatA.w) + (_quatB.z * _quatA.x) - (_quatB.x * _quatA.z),
								 (_quatB.w * _quatA.z) + (_quatB.z * _quatA.w) + (_quatB.x * _quatA.y) - (_quatB.y * _quatA.x),
								 (_quatB.w * _quatA.w) - (_quatB.x * _quatA.x) - (_quatB.y * _quatA.y) - (_quatB.z * _quatA.z) );
	}
	
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
	
	// ---------------------------------------------------
	// get a Normalise CGQuaternion
	// ---------------------------------------------------
	inline CGQuaternion CGQuaternionNormalised( const CGQuaternion & _quat )
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