//
//  GLTestMeshFactory.h
//  Electric3D
//
//  Created by Robert McDowell on 23/09/2010.
//  Copyright 2010 Electric TopHat Ltd. All rights reserved.
//

#import <Foundation/Foundation.h>

namespace GLMeshes { class GLMeshFactory; };
namespace GLMeshes { class GLMesh; };

@interface GLTestMeshFactory_container : NSObject
{
@public
	NSString *					bundleMesh;
	NSString *					localfileMesh;
	
	const GLMeshes::GLMesh *	meshA;
	const GLMeshes::GLMesh *	meshB;
	BOOL						deleted;
	BOOL						complete;
} 
@end

@interface GLTestMeshFactory : UIView 
{
@private
	UITextView *					display;
	
	GLTestMeshFactory_container *	md2animated;
	GLTestMeshFactory_container *	md2static;
	
	GLMeshes::GLMeshFactory *		factory;
}

- (BOOL) canRotate;

- (void) update:(id)_sender;

@end
