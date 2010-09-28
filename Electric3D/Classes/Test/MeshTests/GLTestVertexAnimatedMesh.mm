//
//  GLTestVertexAnimatedMesh.m
//  Electric3D
//
//  Created by Robert McDowell on 28/09/2010.
//  Copyright 2010 Electric TopHat Ltd. All rights reserved.
//

#import "GLTestVertexAnimatedMesh.h"

#import "GLTextureFactory.h"
#import "GLTexture.h"

#import "GLMeshFactory.h"
#import "GLMesh.h"

#import "GLModels.h"

#import "GLScene.h"

@interface GLTestVertexAnimatedMesh (PrivateMethods)

- (void) initialization;
- (void) teardown;

@end

@implementation GLTestVertexAnimatedMesh

#pragma mark ---------------------------------------------------------
#pragma mark === Constructor / Destructor Functions  ===
#pragma mark ---------------------------------------------------------

// ------------------------------------------
// intialisation via nib
// ------------------------------------------
- (id)initWithCoder:(NSCoder*)coder 
{
	if ((self = [super initWithCoder:coder])) 
	{
		// Initialization code
		[self initialization];
	}
	return self;
}

// ------------------------------------------
// intialisation using the frame
// ------------------------------------------
- (id)initWithFrame:(CGRect)frame 
{
    if (self = [super initWithFrame:frame]) 
	{
        // Initialization code
		[self initialization];
    }
    return self;
}

// ------------------------------------------
// dealloc
// ------------------------------------------
- (void)dealloc 
{	
	[self teardown];
	
    [super dealloc];
}

#pragma mark ---------------------------------------------------------
#pragma mark === End Constructor / Destructor Functions  ===
#pragma mark ---------------------------------------------------------

#pragma mark ---------------------------------------------------------
#pragma mark === Public Functions  ===
#pragma mark ---------------------------------------------------------

// ------------------------------------------
// canRotate
// ------------------------------------------
- (BOOL) canRotate
{
	return FALSE;
}

// ------------------------------------------
// update Function
// ------------------------------------------
- (void) update
{
	if ( model->subtype() == GLObjects::eGLModelType_VertexAnimation )
	{
		GLObjects::GLModelVertexAnimation * animatedModel = (GLObjects::GLModelVertexAnimation*)model;
		
		float addValue = 0.2f;
		float value = animatedModel->blendValue();
		if ( value+addValue > 1.0f )
		{
			NSUInteger max		= animatedModel->numFrames();
			NSUInteger current	= animatedModel->startFrame() + 1;
			
			if ( current < max )
			{
				animatedModel->setStartFrame( current );
				animatedModel->setTargetFrame( current + 1 );
			}
			else 
			{
				animatedModel->setStartFrame( 0 );
				animatedModel->setTargetFrame( 1 );
			}
			
			animatedModel->setBlendValue( 0.0f );
		}
		else
		{
			animatedModel->setBlendValue( value+addValue );
		}
	}
	
	[self drawView:nil];
}

#pragma mark ---------------------------------------------------------
#pragma mark === End Public Functions  ===
#pragma mark ---------------------------------------------------------

#pragma mark ---------------------------------------------------------
#pragma mark === Private Functions  ===
#pragma mark ---------------------------------------------------------

// ------------------------------------------
// Initialization
// ------------------------------------------
- (void) initialization
{	
	scene = new GLObjects::GLScene( @"Test" );
	
	texture		= [self textures]->load( @"MD2Test", @"png" );
	mesh		= [self meshes]->load( @"MD2AnimatedMeshTest", @"md2" );

	if ( mesh )
	{
		model = new GLObjects::GLModelVertexAnimation( @"TestObj" );
		model->setMesh( mesh );
		model->setTexture( texture );

		scene->add( model );	
	}
	
	[self addScene:scene];
}

// ------------------------------------------
// Teardown
// ------------------------------------------
- (void) teardown
{
	[self removeScene:scene];
	
	scene->remove( model );
	
	[self textures]->release( model->texture() );
	[self meshes]->release( model->mesh() );

	delete( model );
	delete( scene );
}

#pragma mark ---------------------------------------------------------
#pragma mark === End Private Functions  ===
#pragma mark ---------------------------------------------------------

@end
