/*
 *  CGMathsTypes.h
 *  Electric3D
 *
 *  Created by Robert McDowell on 20/10/2010.
 *  Copyright 2010 Electric TopHat Ltd. All rights reserved.
 *
 */

#if !defined(__CGMathsTypes_h__)
#define __CGMathsTypes_h__

namespace CGMaths 
{
#pragma mark ---------------------------------------------------------
#pragma mark CGVector2D typedef
#pragma mark ---------------------------------------------------------
	
	typedef union 
	{
		float v[2];
		struct 
		{
			float x;
			float y;
		};
	} CGVector2D;
	
#pragma mark ---------------------------------------------------------
#pragma mark End CGVector2D typedef
#pragma mark ---------------------------------------------------------
	
#pragma mark ---------------------------------------------------------
#pragma mark Vector3D typedef
#pragma mark ---------------------------------------------------------
	
	typedef union 
	{ 
		float v[3];
		struct 
		{
			float x;
			float y;
			float z;
		};
	} CGVector3D;
	
#pragma mark ---------------------------------------------------------
#pragma mark End Vector3D typedef
#pragma mark ---------------------------------------------------------
	
#pragma mark ---------------------------------------------------------
#pragma mark Vector4D typedef
#pragma mark ---------------------------------------------------------
	
	typedef union 
	{ 
		float v[4];
		struct 
		{
			float x;
			float y;
			float z;
			float w;
		};
	} CGVector4D;
	
#pragma mark ---------------------------------------------------------
#pragma mark End Vector4D typedef
#pragma mark ---------------------------------------------------------
	
#pragma mark ---------------------------------------------------------
#pragma mark CGMatrix3x3 typedef
#pragma mark ---------------------------------------------------------
	
	typedef union 
	{ 
		float m[9];
		struct 
		{
			float m00, m01, m02;
			float m10, m11, m12;
			float m20, m21, m22;
		};
	} CGMatrix3x3;
	
#pragma mark ---------------------------------------------------------
#pragma mark End CGMatrix3x3 typedef
#pragma mark ---------------------------------------------------------
	
#pragma mark ---------------------------------------------------------
#pragma mark CGMatrix4x4 typedef
#pragma mark ---------------------------------------------------------
	
	typedef union 
	{ 
		float m[16];
		struct 
		{
			float m00, m01, m02, m03;
			float m10, m11, m12, m13; 
			float m20, m21, m22, m23; 
			float m30, m31, m32, m33; 
		};
	} CGMatrix4x4;
	
#pragma mark ---------------------------------------------------------
#pragma mark End CGMatrix4x4 typedef
#pragma mark ---------------------------------------------------------
	
#pragma mark ---------------------------------------------------------
#pragma mark CGQuaternion typedef
#pragma mark ---------------------------------------------------------
	
	typedef union 
	{ 
		float q[4];
		struct 
		{
			float x;
			float y;
			float z;
			float w;
		};
	} CGQuaternion;
	
#pragma mark ---------------------------------------------------------
#pragma mark End CGQuaternion typedef
#pragma mark ---------------------------------------------------------
	
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
#pragma mark CGAABB typedef
#pragma mark ---------------------------------------------------------
	
	typedef struct 
	{ 
		CGMatrix4x4 transform;
		CGVector3D	extents;
	} CGOOBB;
	
#pragma mark ---------------------------------------------------------
#pragma mark End CGAABB typedef
#pragma mark ---------------------------------------------------------
	
#pragma mark ---------------------------------------------------------
#pragma mark CGSphere typedef
#pragma mark ---------------------------------------------------------
	
	typedef struct 
	{ 
		CGVector3D center;
		float	   radius;
	} CGSphere;
	
#pragma mark ---------------------------------------------------------
#pragma mark End CGSphere typedef
#pragma mark ---------------------------------------------------------
	
#pragma mark ---------------------------------------------------------
#pragma mark CGPlane typedef
#pragma mark ---------------------------------------------------------
	
	typedef struct 
	{ 
		float	   d;		// point on plane
		CGVector3D normal;	// normal
	} CGPlane;
	
#pragma mark ---------------------------------------------------------
#pragma mark End CGPlane typedef
#pragma mark ---------------------------------------------------------
	
};

#endif