/*
 *  GTVertexSubTypes.h
 *  Electric3D
 *
 *  Created by Robert McDowell on 24/09/2010.
 *  Copyright 2010 Electric TopHat Ltd. All rights reserved.
 *
 */

#if !defined(__GTVertexSubTypes_h__)
#define __GTVertexSubTypes_h__

// --------------------------------
// GL Vert 2D
// --------------------------------
typedef struct {
	float x;
	float y;
} _GLVert2D;
// --------------------------------

// --------------------------------
// GL Vert 3D
// --------------------------------
typedef struct {
	float x;
	float y;
	float z;
} _GLVert3D;
// --------------------------------

// --------------------------------
// GL Normal 
// --------------------------------
typedef struct {
	float x;
	float y;
	float z;
} _GLNormal;
// --------------------------------

// --------------------------------
// GL UV Cordinates
// --------------------------------
typedef struct {
	float x;
	float y;
} _GLUV;
// --------------------------------

// --------------------------------
// GL Color
// --------------------------------
typedef struct {
	unsigned char red;
	unsigned char green;
	unsigned char blue;
	unsigned char alpha;	
} _GLColor;
// --------------------------------

#endif
