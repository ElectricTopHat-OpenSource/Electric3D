//
//  GLTestCameraGeneral.h
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

@interface GLTestCameraGeneral : GLView 
{
@private
	std::vector<GLObjects::GLModel*>	objects;
	GLObjects::GLScene *				scene;
	
	CGMaths::CGVector3D					eye;
	CGMaths::CGVector3D					target;
	GLObjects::GLModel *				lookat;
}

- (BOOL) canRotate;
- (void) update:(id)_sender;

@end
