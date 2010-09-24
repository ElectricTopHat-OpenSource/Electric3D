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

#import "GTVertexSubTypes.h"

#define GLInterleavedVert3D_color 0

typedef struct
{
	_GLVert2D	vert;
	_GLColor	color;
	_GLUV		uv;
	
} GLInterleavedVert2D;

typedef struct
{
	_GLVert3D	vert;
	_GLNormal	normal;
	
} GLInterleavedVertNormal3D;

typedef struct
{
	_GLVert3D	vert;
	_GLNormal	normal;
#if GLInterleavedVert3D_color
	_GLColor		color;
#endif
	_GLUV		uv;
	
} GLInterleavedVert3D;

#endif