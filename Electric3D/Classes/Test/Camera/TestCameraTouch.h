//
//  TestCameraTouch.h
//  Electric3D
//
//  Created by Robert McDowell on 12/10/2010.
//  Copyright 2010 Electric TopHat Ltd. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "GLView.h"

namespace E3D { class E3DManagers; };
namespace E3D { class E3DScene; };

@interface TestCameraTouch : GLView 
{
@private
	E3D::E3DManagers *		managers;
	E3D::E3DScene *			scene;
	float					depth;
}

- (BOOL) canRotate;
- (void) update:(id)_sender;

@end
