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

namespace PVRPOD
{
	BOOL convertToVerts( const PODMesh * _model, GLInterleavedVert3D * _verts );
	BOOL convertToIndices( const PODMesh * _model, GLVertIndice * _indices ); 
};

#endif
