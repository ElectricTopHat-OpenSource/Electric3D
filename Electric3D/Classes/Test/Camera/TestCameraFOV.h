//
//  TestCameraFOV.h
//  Electric3D
//
//  Created by Robert McDowell on 29/09/2010.
//  Copyright 2010 Electric TopHat Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "GLView.h"
#import "CGMaths.h"

namespace E3D { class E3DManagers; };
namespace E3D { class E3DScene; };

@interface TestCameraFOV : GLView 
{
@private
	E3D::E3DManagers *		managers;
	E3D::E3DScene *			scene;
	NSInteger				state;
}

- (BOOL) canRotate;
- (void) update:(id)_sender;

@end
