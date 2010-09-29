/*
 *  CGAABB.h
 *  Electric3D
 *
 *  Created by Robert McDowell on 24/09/2010.
 *  Copyright 2010 Electric TopHat Ltd. All rights reserved.
 *
 */

#if !defined(__CGAABB_h__)
#define __CGAABB_h__

#import "CGMathsConstants.h"
#import "CGVector3D.h"

namespace CGMaths 
{
	
#pragma mark ---------------------------------------------------------
#pragma mark CGAABB typedef
#pragma mark ---------------------------------------------------------
	
	typedef struct 
	{ 
		CGVector3D min;
		CGVector3D max;
	} CGAABB;
	
#pragma mark ---------------------------------------------------------
#pragma mark End CGAABB typedef
#pragma mark ---------------------------------------------------------

#pragma mark ---------------------------------------------------------
#pragma mark CGAABB consts 
#pragma mark ---------------------------------------------------------
	
	const CGAABB CGAABBZero = {  0.0f,  0.0f,  0.0f, 0.0f, 0.0f, 0.0f };
	const CGAABB CGAABBUnit = { -0.5f, -0.5f, -0.5f, 0.5f, 0.5f, 0.5f };
	
#pragma mark ---------------------------------------------------------
#pragma mark End CGAABB consts 
#pragma mark ---------------------------------------------------------
	
#pragma mark ---------------------------------------------------------
#pragma mark CGAABB Functions
#pragma mark ---------------------------------------------------------
	
	// ---------------------------------------------------
	// Make a CGAABB
	// ---------------------------------------------------
	inline CGAABB CGAABBMake( float _xA, float _yA, float _zA,float _xB, float _yB, float _zB )
	{
		CGAABB aabb; 
		if ( _xA < _xB )
		{
			aabb.min.x = _xA;
			aabb.max.x = _xB;
		}
		else 
		{
			aabb.min.x = _xB;
			aabb.max.x = _xA;
		}
		if ( _yA < _yB )
		{
			aabb.min.y = _yA;
			aabb.max.y = _yB;
		}
		else 
		{
			aabb.min.y = _yB;
			aabb.max.y = _yA;
		}
		if ( _zA < _zB )
		{
			aabb.min.z = _zA;
			aabb.max.z = _zB;
		}
		else 
		{
			aabb.min.z = _zB;
			aabb.max.z = _zA;
		}
		return aabb;
	}
	
	// ---------------------------------------------------
	// Make a CGAABB
	// ---------------------------------------------------
	inline CGAABB CGAABBMake( const CGVector3D & _min, const CGVector3D & _max )
	{
		return CGAABBMake( _min.x, _min.y, _min.z, _max.x, _max.y, _max.z );
	}
	
	// ---------------------------------------------------
	// Add a point to an existing AABB
	// ---------------------------------------------------
	inline void CGAABBAddPoint( CGAABB & _aabb, const CGVector3D & _point )
	{
		_aabb.min.x = ( _aabb.min.x > _point.x ) ? _point.x : _aabb.min.x;
		_aabb.min.y = ( _aabb.min.y > _point.y ) ? _point.y : _aabb.min.y;
		_aabb.min.z = ( _aabb.min.z > _point.z ) ? _point.z : _aabb.min.z;
		_aabb.max.x = ( _aabb.max.x < _point.x ) ? _point.x : _aabb.max.x;
		_aabb.max.y = ( _aabb.max.y < _point.y ) ? _point.y : _aabb.max.y;
		_aabb.max.z = ( _aabb.max.z < _point.z ) ? _point.z : _aabb.max.z;
	}
	
	// ---------------------------------------------------
	// Is point inside or on the AABB
	// ---------------------------------------------------
	inline BOOL CGAABBInsideOrOn( const CGAABB & _aabbA, const CGAABB & _aabbB )
	{
		return (_aabbA.min.x >= _aabbB.min.x && _aabbA.min.y >= _aabbB.min.y && _aabbA.min.z >= _aabbB.min.z &&
				_aabbA.max.x <= _aabbB.max.x && _aabbA.max.y <= _aabbB.max.y && _aabbA.max.z <= _aabbB.max.z);
	}
	
	// ---------------------------------------------------
	// Is point inside or on the AABB
	// ---------------------------------------------------
	inline BOOL CGAABBInsideOrOn( const CGAABB & _aabb, const CGVector3D & _point )
	{
		return ( ( _point.x >= _aabb.min.x && _point.x <= _aabb.max.x ) &&
				 ( _point.y >= _aabb.min.y && _point.y <= _aabb.max.y ) &&
				 ( _point.z >= _aabb.min.z && _point.z <= _aabb.max.z ) );
	}
	
	// ---------------------------------------------------
	// Is point inside the AABB
	// ---------------------------------------------------
	inline BOOL CGAABBInside( const CGAABB & _aabbA, const CGAABB & _aabbB )
	{
		return (_aabbA.min.x > _aabbB.min.x && _aabbA.min.y > _aabbB.min.y && _aabbA.min.z > _aabbB.min.z &&
				_aabbA.max.x < _aabbB.max.x && _aabbA.max.y < _aabbB.max.y && _aabbA.max.z < _aabbB.max.z);
	}
	
	// ---------------------------------------------------
	// Is point inside the AABB
	// ---------------------------------------------------
	inline BOOL CGAABBInside( const CGAABB & _aabb, const CGVector3D & _point )
	{
		return ( ( _point.x > _aabb.min.x && _point.x < _aabb.max.x ) &&
				 ( _point.y > _aabb.min.y && _point.y < _aabb.max.y ) &&
				 ( _point.z > _aabb.min.z && _point.z < _aabb.max.z ) );
	}		
	
#pragma mark ---------------------------------------------------------
#pragma mark End CGAABB Functions
#pragma mark ---------------------------------------------------------

};

#endif
