//
//  GLTestGeneral.m
//  Electric3D
//
//  Created by Robert McDowell on 22/09/2010.
//  Copyright 2010 Electric TopHat Ltd. All rights reserved.
//

#import "GLTestGeneral.h"

#import "GLTextureFactory.h"
#import "GLTexture.h"

#import "GLMeshFactory.h"
#import "GLMesh.h"

#import "GLModel.h"

#import "GLScene.h"

@interface GLTestGeneral (PrivateMethods)

- (void) initialization;
- (void) teardown;

@end

@implementation GLTestGeneral

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
	//mesh = [self meshes]->load( @"MD2StaticMeshTest", @"md2" );
	//mesh = [self meshes]->load( @"E3D_cube", @"md2" );
	
	//texture = [self textures]->load( @"MD2Test", @"png" );
	//mesh = [self meshes]->load( @"MD2AnimatedMeshTest", @"md2" );
	
	texture = [self textures]->load( @"SL_bert", @"png" );
	mesh	= [self meshes]->load( @"SL_bert", @"md2" );
	if ( mesh )
	{
		model = new GLObjects::GLModel( @"TestObj" );
		model->setMesh( mesh );
		model->setTexture( texture );
		
		scene = new GLObjects::GLScene( @"Test" );
		scene->add( model );
		
		[self addScene:scene];
	}
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
	
}

#pragma mark ---------------------------------------------------------
#pragma mark === End Private Functions  ===
#pragma mark ---------------------------------------------------------

@end
