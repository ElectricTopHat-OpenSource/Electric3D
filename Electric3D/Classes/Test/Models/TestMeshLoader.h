//
//  TestMeshLoader.h
//  Electric3D
//
//  Created by Robert McDowell on 19/10/2010.
//  Copyright 2010 Electric TopHat Ltd. All rights reserved.
//

#import <Foundation/Foundation.h>

namespace GLMeshes { class GLMeshFactory; };

@interface TestMeshLoader : UIView
{
@private
	UITextView *					display;
	
	NSInteger						state;
	
	GLMeshes::GLMeshFactory *		factory;
}

- (BOOL) canRotate;

- (void) update:(id)_sender;

@end
