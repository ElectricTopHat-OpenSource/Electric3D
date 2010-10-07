//
//  GLTestStaticMesh.m
//  Electric3D
//
//  Created by Robert McDowell on 28/09/2010.
//  Copyright 2010 Electric TopHat Ltd. All rights reserved.
//

#import "GLTestStaticMesh.h"

#import "GLTextureFactory.h"
#import "GLTexture.h"

#import "GLMeshFactory.h"
#import "GLMesh.h"

#import "GLModels.h"

#import "GLCamera.h"
#import "GLScene.h"

@interface GLTestStaticMesh (PrivateMethods)

- (void) initialization;
- (void) teardown;

@end

@implementation GLTestStaticMesh


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
- (void) update:(id)_sender
{	
	if ( model )
	{
		CGMaths::CGMatrix4x4 mat = model->transform();
		CGMaths::CGMatrix4x4 rot = CGMaths::CGMatrix4x4MakeRotation( CGMaths::CGVector3DMake( 0.0f, 1.0f, 0.0f ), 1.0f * CGMaths::degreesToRadians );
		//CGMaths::CGMatrix4x4 rot2 = CGMaths::CGMatrix4x4MakeRotation( CGMaths::CGVector3DMake( 1.0f, 0.0f, 0.0f ), 10.0f * CGMaths::degreesToRadians );
		//CGMaths::CGMatrix4x4 rot = CGMaths::CGMatrix4x4Multiply( rot1, rot2 );
		
		CGMaths::CGMatrix4x4 newMat = CGMaths::CGMatrix4x4Multiply( mat, rot );
		
		//CGMaths::CGMatrix4x4SetTranslation( newMat, 0, 0, 10 );
		
		model->setTransform( newMat );
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
	
	texture = nil; 
	//mesh	= [self meshes]->load( @"MD2StaticMeshTest", @"md2" );
	//mesh	= [self meshes]->load( @"E3D_cube", @"md2" );
	mesh	= [self meshes]->load( @"vertex_cube", @"POD" );
	//mesh	= [self meshes]->load( @"vertex_cube_indexed", @"POD" );
	//mesh	= [self meshes]->load( @"box", @"3ds" );
	
	if ( mesh )
	{
		model = new GLObjects::GLModelStatic( @"TestObj" );
		model->setMesh( mesh );
		model->setTexture( texture );
		
		scene->add( model );
	}
	
	[self addScene:scene];
	
	CGMaths::CGVector3D eye		= CGMaths::CGVector3DMake( 10.0f, 0.0f, 0.0f );
	CGMaths::CGVector3D target  = CGMaths::CGVector3DMake( 0.0f, 0.0f, 0.0f );
	
	[self camera]->setTransform( eye, target );
}

// ------------------------------------------
// Teardown
// ------------------------------------------
- (void) teardown
{
	[self removeScene:scene];
	
	if ( model )
	{
		scene->remove( model );
	
		[self textures]->release( model->texture() );
		[self meshes]->release( model->mesh() );
	}

	delete( model );
	delete( scene );
}

#pragma mark ---------------------------------------------------------
#pragma mark === End Private Functions  ===
#pragma mark ---------------------------------------------------------


@end
