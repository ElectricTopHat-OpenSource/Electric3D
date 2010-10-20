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

#import "GLCamera.h"
#import "GLScene.h"
#import "GLModels.h"

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
- (void) update:(id)_sender
{
	if ( model0->subtype() == GLObjects::eGLModelType_VertexAnimation )
	{
		GLObjects::GLModelVertexAnimation * animatedModel = (GLObjects::GLModelVertexAnimation*)model0;
		
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
	
	if ( model1 )
	{
		CGMaths::CGMatrix4x4 mat = model1->transform();
		CGMaths::CGMatrix4x4 rot1 = CGMaths::CGMatrix4x4MakeRotation( CGMaths::CGVector3DMake( 0.0f, 1.0f, 0.0f ), 5.0f * CGMaths::degreesToRadians );
		CGMaths::CGMatrix4x4 rot2 = CGMaths::CGMatrix4x4MakeRotation( CGMaths::CGVector3DMake( 1.0f, 0.0f, 0.0f ), 10.0f * CGMaths::degreesToRadians );
		CGMaths::CGMatrix4x4 rot = CGMaths::CGMatrix4x4MakeMultiply( rot1, rot2 );
		
		CGMaths::CGMatrix4x4 newMat = CGMaths::CGMatrix4x4MakeMultiply( mat, rot );
		
		CGMaths::CGMatrix4x4SetTranslation( newMat, 0, 0, 10 );
		
		model1->setTransform( newMat );
	}
	
	if ( scene )
	{
		CGMaths::CGMatrix4x4 mat = scene->transform();
		CGMaths::CGMatrix4x4 rot1 = CGMaths::CGMatrix4x4MakeRotation( CGMaths::CGVector3DMake( 0.0f, 1.0f, 0.0f ), -5.0f * CGMaths::degreesToRadians );
		CGMaths::CGMatrix4x4 rot2 = CGMaths::CGMatrix4x4MakeRotation( CGMaths::CGVector3DMake( 0.0f, 0.0f, 1.0f ), -5.0f * CGMaths::degreesToRadians );
		CGMaths::CGMatrix4x4 rot = CGMaths::CGMatrix4x4MakeMultiply( rot1, rot2 );
		
		CGMaths::CGMatrix4x4 newMat = CGMaths::CGMatrix4x4MakeMultiply( mat, rot );
		
		scene->setTransform( newMat );
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
	
	//mesh = [self meshes]->load( @"MD2StaticMeshTest", @"md2" );
	//mesh = [self meshes]->load( @"E3D_cube", @"md2" );
	//mesh = [self meshes]->load( @"E3D_cylinder", @"md2" );
	//mesh = [self meshes]->load( @"E3D_sphere", @"md2" );
	//mesh = [self meshes]->load( @"E3D_cone", @"md2" );
	
	texture0 = [self textures]->load( @"MD2Test", @"png" );
	mesh0	= [self meshes]->load( @"MD2AnimatedMeshTest", @"md2" );
	if ( mesh0 )
	{
		model0 = new GLObjects::GLModelVertexAnimation( @"AnimatedTestObj" );
		model0->setMesh( mesh0 );
		model0->setTexture( texture0 );
		scene->add( model0 );
	}
	
	texture1	= nil;
	mesh1		= [self meshes]->load( @"E3D_cube", @"md2" );
	if ( mesh1 )
	{
		model1 = new GLObjects::GLModelStatic( @"StaticTestObj" );
		model1->setMesh( mesh1 );
		model1->setTexture( texture1 );
		scene->add( model1 );
	}
	
	[self addScene:scene];
	
	CGMaths::CGVector3D eye		= CGMaths::CGVector3DMake( 70.0f, 0.0f, 0.0f );
	CGMaths::CGVector3D target  = CGMaths::CGVector3DMake( 0.0f, 0.0f, 0.0f );
	
	[self camera]->setTransform( eye, target );
}

// ------------------------------------------
// Teardown
// ------------------------------------------
- (void) teardown
{
	[self removeScene:scene];
	
	scene->remove( model0 );
	scene->remove( model1 );
	
	[self textures]->release( model0->texture() );
	[self meshes]->release( model0->mesh() );
	
	[self textures]->release( model1->texture() );
	[self meshes]->release( model1->mesh() );
	
	delete( model0 );
	delete( model1 );
	delete( scene );
}

#pragma mark ---------------------------------------------------------
#pragma mark === End Private Functions  ===
#pragma mark ---------------------------------------------------------

@end
