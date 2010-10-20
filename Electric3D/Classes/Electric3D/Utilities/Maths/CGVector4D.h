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
#import "CGMathsTypes.h"

namespace CGMaths 
{
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
	// Are equal
	// ---------------------------------------------------
	inline BOOL CGVector4DAreEqual( const CGVector4D & _vectorA, const CGVector4D & _vectorB, float _tolerance = EPSILON )
	{
		return ( ( fabsf(_vectorA.x - _vectorB.x) < _tolerance ) &&
				 ( fabsf(_vectorA.y - _vectorB.y) < _tolerance ) &&
				 ( fabsf(_vectorA.z - _vectorB.z) < _tolerance ) &&
				 ( fabsf(_vectorA.w - _vectorB.w) < _tolerance ) );
	}
	
#pragma mark ---------------------------------------------------------
#pragma mark End CGVector4D Functions
#pragma mark ---------------------------------------------------------
	
#pragma mark ---------------------------------------------------------
#pragma mark CGVector4D Make Functions
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
	inline CGVector4D CGVector3DMakeAdd( const CGVector4D & _vectorA, const CGVector4D & _vectorB )
	{
		return CGVector4DMake( _vectorA.x + _vectorB.x, _vectorA.y + _vectorB.y, _vectorA.z + _vectorB.z, _vectorA.w + _vectorB.w );
	}
	
	// ---------------------------------------------------
	// Add 2 CGVectro4D's
	// ---------------------------------------------------
	inline CGVector4D CGVector3DMakeAdd( const CGVector4D & _vectorA, const CGVector4D & _vectorB, float _scaleB )
	{
		return CGVector4DMake( _vectorA.x + ( _vectorB.x * _scaleB), 
							   _vectorA.y + ( _vectorB.y * _scaleB), 
							   _vectorA.z + ( _vectorB.z * _scaleB), 
							   _vectorA.w + ( _vectorB.w * _scaleB) );
	}
	
	// ---------------------------------------------------
	// Sub 2 CGVectro4D's
	// ---------------------------------------------------
	inline CGVector4D CGVector4DMakeSub( const CGVector4D & _vectorA, const CGVector4D & _vectorB )
	{
		return CGVector4DMake( _vectorA.x - _vectorB.x, _vectorA.y - _vectorB.y, _vectorA.z - _vectorB.z, _vectorA.w - _vectorB.w );
	}
	
	// ---------------------------------------------------
	// Multiply 2 CGVectro4D's
	// ---------------------------------------------------
	inline CGVector4D CGVector4DMakeMultiply( const CGVector4D & _vectorA, const CGVector4D & _vectorB )
	{
		return CGVector4DMake( _vectorA.x * _vectorB.x, _vectorA.y * _vectorB.y, _vectorA.z * _vectorB.z, _vectorA.w * _vectorB.w );
	}
	
	// ---------------------------------------------------
	// Divide 2 CGVectro4D's
	// ---------------------------------------------------
	inline CGVector4D CGVector4DMakeDivide( const CGVector4D & _vectorA, const CGVector4D & _vectorB )
	{
		return CGVector4DMake( _vectorA.x / _vectorB.x, _vectorA.y / _vectorB.y, _vectorA.z / _vectorB.z, _vectorA.w / _vectorB.w );
	}
	
	// ---------------------------------------------------
	// Negate a CGVectro4D
	// ---------------------------------------------------
	inline CGVector4D CGVector3DMakeNegate( const CGVector4D & _vector )
	{
		return CGVector4DMake( -_vector.x, -_vector.y, -_vector.z, -_vector.w );
	}
	
	// ---------------------------------------------------
	// CGVectro4D minimum values of x,y,z,w independently
	// ---------------------------------------------------
	inline CGVector4D CGVector3DMakeMin( const CGVector4D & _vectorA, const CGVector4D & _vectorB )
	{
		return CGVector4DMake( ( ( _vectorA.x < _vectorB.x ) ? _vectorA.x : _vectorB.x ),
							   ( ( _vectorA.y < _vectorB.y ) ? _vectorA.y : _vectorB.y ),
							   ( ( _vectorA.z < _vectorB.z ) ? _vectorA.z : _vectorB.z ),
							   ( ( _vectorA.w < _vectorB.w ) ? _vectorA.w : _vectorB.w ) );
	}
	
	// ---------------------------------------------------
	// CGVectro4D maximum values of x,y,z,w independently
	// ---------------------------------------------------
	inline CGVector4D CGVector4DMakeMax( const CGVector4D & _vectorA, const CGVector4D & _vectorB )
	{
		return CGVector4DMake( ( ( _vectorA.x > _vectorB.x ) ? _vectorA.x : _vectorB.x ),
							   ( ( _vectorA.y > _vectorB.y ) ? _vectorA.y : _vectorB.y ),
							   ( ( _vectorA.z > _vectorB.z ) ? _vectorA.z : _vectorB.z ), 
							   ( ( _vectorA.w > _vectorB.w ) ? _vectorA.w : _vectorB.w ) );
	}
	
#pragma mark ---------------------------------------------------------
#pragma mark End CGVector4D Make Functions
#pragma mark ---------------------------------------------------------
	
};

#endif