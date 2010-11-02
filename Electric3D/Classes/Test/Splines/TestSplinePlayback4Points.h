//
//  TestSplinePlayback4Points.h
//  Electric3D
//
//  Created by Robert McDowell on 20/10/2010.
//  Copyright 2010 Electric TopHat Ltd. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GLView.h"

namespace E3D { class E3DManagers; };
namespace E3D { class E3DScene; };
namespace E3D { class E3DSpline; };

@interface TestSplinePlayback4Points : GLView 
{
@private
	E3D::E3DManagers *		managers;
	E3D::E3DScene *			scene;
	
	float					value;
	const E3D::E3DSpline *	spline;
}

- (BOOL) canRotate;
- (void) update:(id)_sender;

@end
