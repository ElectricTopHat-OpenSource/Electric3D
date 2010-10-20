//
//  TestCameraFOV.m
//  Electric3D
//
//  Created by Robert McDowell on 29/09/2010.
//  Copyright 2010 Electric TopHat Ltd. All rights reserved.
//

#import "TestCameraFOV.h"
#import "Electric3D.h"

@interface TestCameraFOV (PrivateMethods)

- (void) initialization;
- (void) teardown;

@end

@implementation TestCameraFOV

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
	float fov = scene->camera()->fov();
	if ( state == 0 )
	{
		fov += 0.1f;
		if ( fov > 90.0f )
		{
			state = 1;
		}
	}
	else if ( state == 1 )
	{
		fov -= 0.1f;
		if ( fov < 10.0f )
		{
			state = 0;
		}
	}
	scene->camera()->setFov( fov );
	
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
	scene = new E3D::E3DScene( @"Test Scene" );
	
	const GLMeshes::GLMesh * meshA = [[self renderer] factories]->meshes()->load( @"E3D_cube", @"md2" );
	const GLMeshes::GLMesh * meshB = [[self renderer] factories]->meshes()->load( @"E3D_cylinder", @"md2" );
	const GLMeshes::GLMesh * meshC = [[self renderer] factories]->meshes()->load( @"E3D_sphere", @"md2" );
	const GLMeshes::GLMesh * meshD = [[self renderer] factories]->meshes()->load( @"E3D_cone", @"md2" );
	const GLMeshes::GLMesh * meshE = [[self renderer] factories]->meshes()->load( @"E3D_cube", @"md2" );
	
	E3D::E3DSceneNode * modelA = new E3D::E3DModelStatic( @"Cube", meshA );
	E3D::E3DSceneNode * modelB = new E3D::E3DModelStatic( @"Cylinder", meshB );
	E3D::E3DSceneNode * modelC = new E3D::E3DModelStatic( @"Sphere", meshC );
	E3D::E3DSceneNode * modelD = new E3D::E3DModelStatic( @"Cone", meshD );
	E3D::E3DSceneNode * modelE = new E3D::E3DModelStatic( @"Cone", meshE );
	
	CGMaths::CGMatrix4x4SetTranslation( modelA->transform(),   -2,  0,  5 );
	CGMaths::CGMatrix4x4SetTranslation( modelB->transform(),   -1,  0,  5 );
	CGMaths::CGMatrix4x4SetTranslation( modelC->transform(),     0, 0,  5 );
	CGMaths::CGMatrix4x4SetTranslation( modelD->transform(),    1,  0,  5 );
	CGMaths::CGMatrix4x4SetTranslation( modelE->transform(),    2,  0,  5 );
	
	scene->addChild( modelA );
	scene->addChild( modelB );
	scene->addChild( modelC );
	scene->addChild( modelD );
	scene->addChild( modelE );
	
	CGMaths::CGVector3D eye		= CGMaths::CGVector3DMake( 0.0f, 0.0f, 0.0f );
	CGMaths::CGVector3D target  = CGMaths::CGVector3DMake( 0.0f, 0.0f, 5.0f );
	
	scene->camera()->setFov( 45.0f );
	scene->camera()->setTransform( eye, target );
	scene->camera()->setViewport( [self bounds] );
	state = 0;
	
	[[self renderer] addScene:scene];
}

// ------------------------------------------
// Teardown
// ------------------------------------------
- (void) teardown
{
	[[self renderer] removeScene:scene];
	
	if ( scene )
	{
		while (scene->numchildren() > 0) 
		{
			E3D::E3DSceneNode * node = scene->child( 0 );
			if ( ( node->type() == E3D::eE3DSceneNodeType_ModelStatic ) ||
				( node->type() == E3D::eE3DSceneNodeType_ModelVertexAnimated ) )
			{
				E3D::E3DModel * model = (E3D::E3DModel*)node;
				
				[[self renderer] factories]->textures()->release( model->texture() );
				[[self renderer] factories]->meshes()->release( model->mesh() );
			}
			
			scene->removeChild( node );
			SAFE_DELETE(node);
		}
	}
	
	SAFE_DELETE( scene );
}

#pragma mark ---------------------------------------------------------
#pragma mark === End Private Functions  ===
#pragma mark ---------------------------------------------------------

@end
