//
//  GLTestGeneral.h
//  Electric3D
//
//  Created by Robert McDowell on 22/09/2010.
//  Copyright 2010 Electric TopHat Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GLView.h"

namespace GLTextures { class GLTexture; };
namespace GLMeshes { class GLMesh; };
namespace GLObjects { class GLModel; };
namespace GLObjects { class GLScene; };

@interface GLTestGeneral : GLView
{
@private
	const GLTextures::GLTexture	*	texture0;
	const GLMeshes::GLMesh *		mesh0;
	GLObjects::GLModel	*			model0;
	
	const GLTextures::GLTexture	*	texture1;
	const GLMeshes::GLMesh *		mesh1;
	GLObjects::GLModel	*			model1;
	
	GLObjects::GLScene *			scene;
}

- (BOOL) canRotate;

- (void) update:(id)_sender;

@end
