//
//  TestMeshAnimated.h
//  Electric3D
//
//  Created by Robert McDowell on 19/10/2010.
//  Copyright 2010 Electric TopHat Ltd. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "GLView.h"

@class DeltaTimer;

namespace E3D { class E3DScene; };

@interface TestMeshAnimated : GLView 
{
@private
	DeltaTimer *			deltaTimer;
	E3D::E3DScene *			scene;
}

- (BOOL) canRotate;
- (void) update:(id)_sender;

@end
