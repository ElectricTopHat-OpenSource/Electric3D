//
//  TestCameraBasic.h
//  Electric3D
//
//  Created by Robert McDowell on 29/09/2010.
//  Copyright 2010 Electric TopHat Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "GLView.h"
#import "CGMaths.h"

namespace E3D { class E3DScene; };

@interface TestCameraBasic : GLView 
{
@private
	E3D::E3DScene *				scene;
	NSInteger					index;
	
	CGMaths::CGVector3D			eye;
	CGMaths::CGVector3D			target;
}

- (BOOL) canRotate;
- (void) update:(id)_sender;

@end
