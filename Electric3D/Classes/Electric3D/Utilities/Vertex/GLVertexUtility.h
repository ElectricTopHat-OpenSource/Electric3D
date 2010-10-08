/*
 *  GLVertexUtility.h
 *  Electric3D
 *
 *  Created by Robert McDowell on 06/10/2010.
 *  Copyright 2010 Electric TopHat Ltd. All rights reserved.
 *
 */

#if !defined(__GLVertexUtility_h__)
#define __GLVertexUtility_h__

#import "CGMaths.h"
#import "GLVertexTypes.h"

inline CGMaths::CGAABB calculateAABB( const  GLInterleavedVert3D * _verts, NSUInteger _numverts )
{
	CGMaths::CGAABB aabb = CGMaths::CGAABBInvalid;
	int i;
	for ( i=0; i<_numverts; i++ )
	{
		const GLInterleavedVert3D * vert = &_verts[i]; 
		CGMaths::CGAABBAddPoint( aabb, vert->vert.x, vert->vert.y, vert->vert.z );
	}
	return aabb;
}

inline CGMaths::CGAABB calculateAABB( const  GLInterleavedVertNormal3D * _verts, NSUInteger _numverts )
{
	CGMaths::CGAABB aabb = CGMaths::CGAABBInvalid;
	int i;
	for ( i=0; i<_numverts; i++ )
	{
		const GLInterleavedVertNormal3D * vert = &_verts[i]; 
		CGMaths::CGAABBAddPoint( aabb, vert->vert.x, vert->vert.y, vert->vert.z );
	}
	return aabb;
}


#endif