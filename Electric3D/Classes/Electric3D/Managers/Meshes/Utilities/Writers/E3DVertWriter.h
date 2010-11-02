//
//  E3DVertWriter.h
//  Electric3D
//
//  Created by Robert McDowell on 27/09/2010.
//  Copyright 2010 Electric TopHat Ltd. All rights reserved.
//

#if !defined(__E3DVertWriter_h__)
#define __E3DVertWriter_h__

#import "GLVertexTypes.h"

namespace E3D
{
	BOOL writeToHeader( NSString * _filePath, NSString * _meshName, const GLInterleavedVert3D * _verts, NSUInteger _numverts );
};

#endif