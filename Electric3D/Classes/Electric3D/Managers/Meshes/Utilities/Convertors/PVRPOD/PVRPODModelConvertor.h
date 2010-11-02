//
//  PVRPODModelConvertor.h
//  Electric3D
//
//  Created by Robert McDowell on 04/10/2010.
//  Copyright 2010 Electric TopHat Ltd. All rights reserved.
//

#if !defined(__PVRPODModelConvertor_h__)
#define __PVRPODModelConvertor_h__

#import "GLVertexTypes.h"
#import "PVRPODTypes.h"
#import "CGMaths.h"

namespace PVRPOD
{
	CGMaths::CGMatrix4x4 getNodeTransform( const PODNode * _node, unsigned int animFrame = 0, const PODNode * _nodelist = nil );
	
	BOOL convertToVerts( const PODMesh * _model, GLInterleavedVert3D * _verts, const CGMaths::CGMatrix4x4 & _transform = CGMaths::CGMatrix4x4Identity );
	BOOL convertToIndices( const PODMesh * _model, GLVertIndice * _indices, unsigned int _offset = 0 );
};

#endif
