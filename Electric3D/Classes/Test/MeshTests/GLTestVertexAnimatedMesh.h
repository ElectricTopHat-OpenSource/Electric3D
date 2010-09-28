//
//  GLTestVertexAnimatedMesh.h
//  Electric3D
//
//  Created by Robert McDowell on 28/09/2010.
//  Copyright 2010 Electric TopHat Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "GLView.h"

namespace GLTextures { class GLTexture; };
namespace GLMeshes { class GLMesh; };
namespace GLObjects { class GLModel; };
namespace GLObjects { class GLScene; };

@interface GLTestVertexAnimatedMesh : GLView 
{
@private
	const GLTextures::GLTexture	*	texture;
	const GLMeshes::GLMesh *		mesh;
	GLObjects::GLModel	*			model;
	GLObjects::GLScene *			scene;
}

- (BOOL) canRotate;
- (void) update;

@end
