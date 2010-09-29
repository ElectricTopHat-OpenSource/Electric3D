//
//  GLTestCameraPerspective.m
//  Electric3D
//
//  Created by Robert McDowell on 29/09/2010.
//  Copyright 2010 Electric TopHat Ltd. All rights reserved.
//

#import "GLTestCameraPerspective.h"

#import "GLTextureFactory.h"
#import "GLTexture.h"

#import "GLMeshFactory.h"
#import "GLMesh.h"

#import "GLCameras.h"
#import "GLScene.h"
#import "GLModels.h"


@interface GLTestCameraPerspective (PrivateMethods)

- (void) initialization;
- (void) teardown;

@end

@implementation GLTestCameraPerspective

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
	if ( state == 0 )
	{
		fov += 0.01f;
		if ( fov > 90.0f )
		{
			state = 1;
		}
	}
	else if ( state == 1 )
	{
		fov -= 0.01f;
		if ( fov < 20.0f )
		{
			state = 0;
		}
	}
	[self perspective]->setFov( fov );
	
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
	scene = new GLObjects::GLScene( @"Test Scene" );
	
	//mesh = [self meshes]->load( @"MD2StaticMeshTest", @"md2" );
	const GLMeshes::GLMesh * meshA = [self meshes]->load( @"E3D_cube", @"md2" );
	const GLMeshes::GLMesh * meshB = [self meshes]->load( @"E3D_cylinder", @"md2" );
	const GLMeshes::GLMesh * meshC = [self meshes]->load( @"E3D_sphere", @"md2" );
	const GLMeshes::GLMesh * meshD = [self meshes]->load( @"E3D_cone", @"md2" );
	
	GLObjects::GLModel * modelA = new GLObjects::GLModelStatic( @"Cube" );
	GLObjects::GLModel * modelB = new GLObjects::GLModelStatic( @"Cylinder" );
	GLObjects::GLModel * modelC = new GLObjects::GLModelStatic( @"Sphere" );
	GLObjects::GLModel * modelD = new GLObjects::GLModelStatic( @"Cone" );
	GLObjects::GLModel * modelE = new GLObjects::GLModelStatic( @"Cube" );
	
	modelA->setMesh( meshA ); 
	modelB->setMesh( meshB );
	modelC->setMesh( meshC );
	modelD->setMesh( meshD );
	modelE->setMesh( meshA );
	
	CGMaths::CGMatrix4x4SetTranslation( modelA->transform(),   -2,  0,  5 );
	CGMaths::CGMatrix4x4SetTranslation( modelB->transform(),   -1,  0,  5 );
	CGMaths::CGMatrix4x4SetTranslation( modelC->transform(),     0, 0,  5 );
	CGMaths::CGMatrix4x4SetTranslation( modelD->transform(),    1,  0,  5 );
	CGMaths::CGMatrix4x4SetTranslation( modelE->transform(),    2,  0,  5 );
	
	scene->add( modelA );
	scene->add( modelB );
	scene->add( modelC );
	scene->add( modelD );
	scene->add( modelE );
	
	objects.push_back( modelA );
	objects.push_back( modelB );
	objects.push_back( modelC );
	objects.push_back( modelD );
	objects.push_back( modelE );
	
	[self addScene:scene];
	
	CGMaths::CGVector3D eye		= CGMaths::CGVector3DMake( 0.0f, 0.0f, 0.0f );
	CGMaths::CGVector3D target  = CGMaths::CGVector3DMake( 0.0f, 0.0f, 5.0f );
	
	[self camera]->setTransform( eye, target );
	
	fov   = [self perspective]->fov();
	state = 0;
}

// ------------------------------------------
// Teardown
// ------------------------------------------
- (void) teardown
{
	[self removeScene:scene];
	
	for ( int i=0; i<objects.size(); i++ )
	{
		GLObjects::GLModel * model = objects[i];
		scene->remove( model );
		
		[self textures]->release( model->texture() );
		[self meshes]->release( model->mesh() );
		
		delete( model );
	}
	objects.clear();
	
	delete( scene );
}

#pragma mark ---------------------------------------------------------
#pragma mark === End Private Functions  ===
#pragma mark ---------------------------------------------------------

@end
