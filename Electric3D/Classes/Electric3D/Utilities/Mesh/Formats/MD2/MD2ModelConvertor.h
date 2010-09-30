//
//  MD2ModelConvertor.h
//  Electric3D
//
//  Created by Robert McDowell on 23/09/2010.
//  Copyright 2010 Electric TopHat Ltd. All rights reserved.
//

#if !defined(__MD2ModelConvertor_h__)
#define __MD2ModelConvertor_h__

#import "GLVertexTypes.h"

namespace MD2 { class MD2Model; }

namespace MD2
{	
	BOOL convertFrameToVerts( const MD2Model * _model, unsigned int _frame, GLInterleavedVert3D * _verts );
	BOOL convertFrameUVToVertsUV( const MD2Model * _model, unsigned int _frame, GLInterleavedVert3D * _verts );
	BOOL convertFrameToVerts( const MD2Model * _model, unsigned int _frame, GLInterleavedVertNormal3D * _verts );
	
};

#endif