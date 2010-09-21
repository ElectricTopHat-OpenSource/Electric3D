/*
 *  CGVector4D.h
 *  Electric3D
 *
 *  Created by Robert McDowell on 21/09/2010.
 *  Copyright 2010 Electric TopHat Ltd. All rights reserved.
 *
 */

#if !defined(__CGVector4D_h__)
#define __CGVector4D_h__

#import "CGMathsConstants.h"
#import "CGVector3D.h"

namespace CGMaths 
{
	
#pragma mark ---------------------------------------------------------
#pragma mark Vector4D typedef
#pragma mark ---------------------------------------------------------
	
	typedef struct 
	{ 
		float x;
		float y;
		float z;
		float w;
		
	} CGVector4D;
	
#pragma mark ---------------------------------------------------------
#pragma mark End Vector4D typedef
#pragma mark ---------------------------------------------------------
	
#pragma mark ---------------------------------------------------------
#pragma mark CGVector4D consts 
#pragma mark ---------------------------------------------------------
	
	const CGVector4D CGVector4DZero = { 0, 0, 0, 0 };
	
#pragma mark ---------------------------------------------------------
#pragma mark End CGVector4D consts 
#pragma mark ---------------------------------------------------------
	
#pragma mark ---------------------------------------------------------
#pragma mark CGVector4D Functions
#pragma mark ---------------------------------------------------------
	
	// ---------------------------------------------------
	// Make a CGVector4D
	// ---------------------------------------------------
	inline CGVector4D CGVector4DMake( float _x, float _y, float _z, float _w )
	{
		CGVector4D vector; 
		vector.x = _x; 
		vector.y = _y;
		vector.z = _z;
		vector.w = _w;
		return vector;
	}
	
	// ---------------------------------------------------
	// Make a CGVector4D
	// ---------------------------------------------------
	inline CGVector4D CGVector4DMake( const CGVector3D & _vector )
	{
		return CGVector4DMake( _vector.x, _vector.y, _vector.z, 0.0f );
	}
	
	// ---------------------------------------------------
	// Add 2 CGVectro4D's
	// ---------------------------------------------------
	inline CGVector4D CGVector3DAdd( const CGVector4D & _vectorA, const CGVector4D & _vectorB )
	{
		return CGVector4DMake( _vectorA.x + _vectorB.x, _vectorA.y + _vectorB.y, _vectorA.z + _vectorB.z, _vectorA.w + _vectorB.w );
	}
	
	// ---------------------------------------------------
	// Sub 2 CGVectro4D's
	// ---------------------------------------------------
	inline CGVector4D CGVector4DSub( const CGVector4D & _vectorA, const CGVector4D & _vectorB )
	{
		return CGVector4DMake( _vectorA.x - _vectorB.x, _vectorA.y - _vectorB.y, _vectorA.z - _vectorB.z, _vectorA.w - _vectorB.w );
	}
	
	// ---------------------------------------------------
	// Multiply 2 CGVectro4D's
	// ---------------------------------------------------
	inline CGVector4D CGVector4DMult( const CGVector4D & _vectorA, const CGVector4D & _vectorB )
	{
		return CGVector4DMake( _vectorA.x * _vectorB.x, _vectorA.y * _vectorB.y, _vectorA.z * _vectorB.z, _vectorA.w * _vectorB.w );
	}
	
	// ---------------------------------------------------
	// Divide 2 CGVectro4D's
	// ---------------------------------------------------
	inline CGVector4D CGVector4DDiv( const CGVector4D & _vectorA, const CGVector4D & _vectorB )
	{
		return CGVector4DMake( _vectorA.x / _vectorB.x, _vectorA.y / _vectorB.y, _vectorA.z / _vectorB.z, _vectorA.w / _vectorB.w );
	}
	
	// ---------------------------------------------------
	// Negate a CGVectro4D
	// ---------------------------------------------------
	inline CGVector4D CGVector3DNegate( const CGVector4D & _vector )
	{
		return CGVector4DMake( -_vector.x, -_vector.y, -_vector.z, -_vector.w );
	}
	
	// ---------------------------------------------------
	// CGVectro4D minimum values of x,y,z,w independently
	// ---------------------------------------------------
	inline CGVector4D CGVector3DMin( const CGVector4D & _vectorA, const CGVector4D & _vectorB )
	{
		return CGVector4DMake( ( ( _vectorA.x < _vectorB.x ) ? _vectorA.x : _vectorB.x ),
							   ( ( _vectorA.y < _vectorB.y ) ? _vectorA.y : _vectorB.y ),
							   ( ( _vectorA.z < _vectorB.z ) ? _vectorA.z : _vectorB.z ),
							   ( ( _vectorA.w < _vectorB.w ) ? _vectorA.w : _vectorB.w ) );
	}
	
	// ---------------------------------------------------
	// CGVectro4D maximum values of x,y,z,w independently
	// ---------------------------------------------------
	inline CGVector4D CGVector4DMax( const CGVector4D & _vectorA, const CGVector4D & _vectorB )
	{
		return CGVector4DMake( ( ( _vectorA.x > _vectorB.x ) ? _vectorA.x : _vectorB.x ),
							   ( ( _vectorA.y > _vectorB.y ) ? _vectorA.y : _vectorB.y ),
							   ( ( _vectorA.z > _vectorB.z ) ? _vectorA.z : _vectorB.z ), 
							   ( ( _vectorA.w > _vectorB.w ) ? _vectorA.w : _vectorB.w ) );
	}
	
#pragma mark ---------------------------------------------------------
#pragma mark CGVector4D Functions
#pragma mark ---------------------------------------------------------
	
};

#endif