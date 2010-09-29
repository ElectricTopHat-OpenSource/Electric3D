//
//  GLTestCameraGeneral.m
//  Electric3D
//
//  Created by Robert McDowell on 29/09/2010.
//  Copyright 2010 Electric TopHat Ltd. All rights reserved.
//

#import "GLTestCameraGeneral.h"

#import "GLTextureFactory.h"
#import "GLTexture.h"

#import "GLMeshFactory.h"
#import "GLMesh.h"

#import "GLCamera.h"
#import "GLScene.h"
#import "GLModels.h"


@interface GLTestCameraGeneral (PrivateMethods)

- (void) initialization;
- (void) teardown;

@end

@implementation GLTestCameraGeneral

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
	CGMaths::CGVector3D moveto = lookat->postion();
	if ( CGMaths::CGVector3DEqual( moveto, target, 1.0f ) )
	{
		if ( lookat == objects[0] )
		{
			lookat = objects[2];
		}
		else if ( lookat == objects[2] )
		{
			lookat = objects[1];
		}
		else if ( lookat == objects[1] )
		{
			lookat = objects[3];
		}
		else if ( lookat == objects[3] )
		{
			lookat = objects[0];
		}
	}
	else 
	{
		target.x = target.x + ( ( moveto.x - target.x ) * 0.01f );
		target.y = target.y + ( ( moveto.y - target.y ) * 0.01f );
		target.z = target.z + ( ( moveto.z - target.z ) * 0.01f );
	}

	if ( eye.y < 50.0f )
	{
		eye.y += 0.01f;
	}
	
	[self camera]->setTransform( eye, target );
	
	
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
	
	modelA->setMesh( meshA ); 
	modelB->setMesh( meshB );
	modelC->setMesh( meshC );
	modelD->setMesh( meshD );
	
	CGMaths::CGMatrix4x4SetTranslation( modelA->transform(),   0, 0,  5 );
	CGMaths::CGMatrix4x4SetTranslation( modelB->transform(),   0, 0, -5 );
	CGMaths::CGMatrix4x4SetTranslation( modelC->transform(),  5, 0,   0 );
	CGMaths::CGMatrix4x4SetTranslation( modelD->transform(), -5, 0,   0 );
	
	scene->add( modelA );
	scene->add( modelB );
	scene->add( modelC );
	scene->add( modelD );
	
	objects.push_back( modelA );
	objects.push_back( modelB );
	objects.push_back( modelC );
	objects.push_back( modelD );
	
	[self addScene:scene];
	
	eye		= CGMaths::CGVector3DMake( 0.0f, 0.0f, 0.0f );
	target  = CGMaths::CGVector3DMake( 0.0f, 0.0f, 5.0f );
	lookat	= modelA;
	
	[self camera]->setTransform( eye, target );
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
