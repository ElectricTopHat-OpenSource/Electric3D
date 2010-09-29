//
//  GLTestColorSceneModel.h
//  Electric3D
//
//  Created by Robert McDowell on 29/09/2010.
//  Copyright 2010 Electric TopHat Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "GLView.h"
#import "CGMaths.h"
#import <vector>

namespace GLObjects { class GLModel; };
namespace GLObjects { class GLScene; };


@interface GLTestColorSceneModel : GLView 
{
@private
	std::vector<GLObjects::GLModel*>	objects;
	GLObjects::GLScene *				scene;
	
	float		alphacolor;
	NSInteger	alphastate;
	
	float		scenecolor;
	NSInteger	scenestate;
}

- (BOOL) canRotate;
- (void) update:(id)_sender;

@end
