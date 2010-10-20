/*
 *  GLVertexComponents.h
 *  Electric3D
 *
 *  Created by Robert McDowell on 24/09/2010.
 *  Copyright 2010 Electric TopHat Ltd. All rights reserved.
 *
 */

#if !defined(__GLVertexComponents_h__)
#define __GLVertexComponents_h__

typedef unsigned short _GLIndice;

// --------------------------------
// GL Vert 2D
// --------------------------------
typedef struct {
	float v[2];
	struct 
	{
		float x;
		float y;
	};
} _GLVert2D;
// --------------------------------

// --------------------------------
// GL Vert 3D
// --------------------------------
typedef union {
	float v[3];
	struct 
	{
		float x;
		float y;
		float z;
	};
} _GLVert3D;
// --------------------------------

// --------------------------------
// GL Normal 
// --------------------------------
typedef union {
	float v[3];
	struct 
	{
		float x;
		float y;
		float z;
	};
} _GLNormal;
// --------------------------------

// --------------------------------
// GL UV Cordinates
// --------------------------------
typedef union {
	float v[2];
	struct 
	{
		float x;
		float y;
	};
} _GLUV;
// --------------------------------

// --------------------------------
// GL GLColor
// --------------------------------
typedef union {
	int value;
	struct 
	{
		unsigned char red;
		unsigned char green;
		unsigned char blue;
		unsigned char alpha;
	};
} _GLColor;
// --------------------------------

#endif
