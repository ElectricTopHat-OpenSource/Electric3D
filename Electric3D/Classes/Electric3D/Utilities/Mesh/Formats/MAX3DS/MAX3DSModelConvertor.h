//
//  MAX3DSModelConvertor.h
//  Electric3D
//
//  Created by Robert McDowell on 04/10/2010.
//  Copyright 2010 Electric TopHat Ltd. All rights reserved.
//

#if !defined(__MAX3DSModelConvertor_h__)
#define __MAX3DSModelConvertor_h__

#import "GLVertexTypes.h"
#import "MAX3DSTypes.h"

namespace MAX3DS 
{
	BOOL convertToVerts( const MAX3DS_OBJECT * _model, GLInterleavedVert3D * _verts );
	BOOL convertToIndices( const MAX3DS_OBJECT * _model, GLVertIndice * _indices );
	
};

#endif
