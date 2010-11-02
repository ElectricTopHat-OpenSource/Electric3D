/*
 *  GLVertexTypes.h
 *  Electric3D
 *
 *  Created by Robert McDowell on 24/09/2010.
 *  Copyright 2010 Electric TopHat Ltd. All rights reserved.
 *
 */

#if !defined(__GLVertexTypes_h__)
#define __GLVertexTypes_h__

#import "GLVertexComponents.h"

#define GLInterleavedVert3D_color 1

typedef union
{
	int value;
	struct
	{
		int hasVertArray   : 1;
		int	hasNormalArray : 1;
		int hasColorArray  : 1;
		int hasUVArray	   : 1;
		
		int pad	: 28; 
	};
} _GLDataState;

typedef struct
{
	_GLDataState	state;
	unsigned int	numVerts;
	unsigned int	step;
	
	_GLVert3D *		verts;
	_GLNormal *		normals;
	_GLColor *		colors;
	_GLUV *			uvs;
	_GLIndice *		indices;
	
} GLInterleavedData;

typedef struct
{
	_GLVert3D	vert;
	_GLNormal	normal;
#if GLInterleavedVert3D_color
	_GLColor	color;
#endif
	_GLUV		uv;
	
} GLInterleavedVert3D;

typedef _GLIndice GLVertIndice;

#endif