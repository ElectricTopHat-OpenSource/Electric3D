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
	BOOL convertFrameToVerts( const PODMesh * _model, GLInterleavedVert3D * _verts );
};

#endif
