//
//  GLMeshWriteHeader.h
//  Electric3D
//
//  Created by Robert McDowell on 27/09/2010.
//  Copyright 2010 Electric TopHat Ltd. All rights reserved.
//

#if !defined(__GLMeshWriter_h__)
#define __GLMeshWriter_h__

#import "GLVertexTypes.h"

namespace GLMeshWriter
{
	BOOL writeToHeader( NSString * _filePath, NSString * _meshName, const GLInterleavedVert3D * _verts, NSUInteger _numverts );
};

#endif