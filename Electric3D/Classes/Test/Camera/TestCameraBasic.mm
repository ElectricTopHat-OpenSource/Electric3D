//
//  TestCameraBasic.m
//  Electric3D
//
//  Created by Robert McDowell on 29/09/2010.
//  Copyright 2010 Electric TopHat Ltd. All rights reserved.
//

#import "TestCameraBasic.h"
#import "Electric3D.h"

@interface TestCameraBasic (PrivateMethods)

- (void) initialization;
- (void) teardown;

@end

@implementation TestCameraBasic

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
	if ( index < scene->numchildren() )
	{
		CGMaths::CGVector3D moveto = scene->child(index)->position();
		if ( CGMaths::CGVector3DAreEqual( moveto, target, 1.0f ) )
		{
			index++;
			if ( index >= scene->numchildren() )
			{
				index = 0;
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
		
		scene->camera()->setTransform( eye, target );
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
	managers	= new E3D::E3DManagers();
	scene		= new E3D::E3DScene( @"Test Scene" );
	
	const E3D::E3DMesh * meshA = managers->meshes()->load( @"E3D_cube", @"md2" );
	const E3D::E3DMesh * meshB = managers->meshes()->load( @"E3D_cylinder", @"md2" );
	const E3D::E3DMesh * meshC = managers->meshes()->load( @"E3D_sphere", @"md2" );
	const E3D::E3DMesh * meshD = managers->meshes()->load( @"E3D_cone", @"md2" );
	
	E3D::E3DSceneNode * modelA = new E3D::E3DModelStatic( @"Cube", meshA );
	E3D::E3DSceneNode * modelB = new E3D::E3DModelStatic( @"Cylinder", meshB );
	E3D::E3DSceneNode * modelC = new E3D::E3DModelStatic( @"Sphere", meshC );
	E3D::E3DSceneNode * modelD = new E3D::E3DModelStatic( @"Cone", meshD );
	
	CGMaths::CGMatrix4x4SetTranslation( modelA->transform(),   0, 0,  5 );
	CGMaths::CGMatrix4x4SetTranslation( modelB->transform(),   0, 0, -5 );
	CGMaths::CGMatrix4x4SetTranslation( modelC->transform(),  5, 0,   0 );
	CGMaths::CGMatrix4x4SetTranslation( modelD->transform(), -5, 0,   0 );
	
	scene->addChild( modelA );
	scene->addChild( modelB );
	scene->addChild( modelC );
	scene->addChild( modelD );
	
	eye		= CGMaths::CGVector3DMake( 0.0f, 0.0f, 0.0f );
	target  = CGMaths::CGVector3DMake( 0.0f, 0.0f, 5.0f );
	index	= 0;
	
	scene->camera()->setTransform( eye, target );
	scene->camera()->setViewport( [self bounds] );
	
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
				( node->type() == E3D::eE3DSceneNodeType_ModelMorph ) )
			{
				E3D::E3DModel * model = (E3D::E3DModel*)node;
				
				managers->textures()->release( model->texture() );
				managers->meshes()->release( model->mesh() );
			}
			
			scene->removeChild( node );
			SAFE_DELETE(node);
		}
	}
	
	SAFE_DELETE( scene );
	SAFE_DELETE( managers );
}

#pragma mark ---------------------------------------------------------
#pragma mark === End Private Functions  ===
#pragma mark ---------------------------------------------------------

@end
