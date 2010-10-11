//
//  GLTestPODMd2Meshes.h
//  Electric3D
//
//  Created by Robert McDowell on 10/10/2010.
//  Copyright 2010 Electric TopHat Ltd. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "GLView.h"

namespace GLTextures { class GLTexture; };
namespace GLMeshes { class GLMesh; };
namespace GLObjects { class GLModel; };
namespace GLObjects { class GLScene; };

@interface GLTestPODMd2Meshes : GLView
{
@private
	GLObjects::GLModel	*			modelPOD;
	GLObjects::GLModel	*			modelmd2;
	GLObjects::GLScene *			scene;
}

- (BOOL) canRotate;
- (void) update:(id)_sender;

@end
