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

#import "GLCamera.h"
#import "GLScene.h"
#import "GLModels.h"

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
- (void) update:(id)_sender
{
	NSTimeInterval newTime = [[NSDate date] timeIntervalSinceReferenceDate];
	NSTimeInterval delta   = ( newTime - lastTime );
	lastTime = newTime;
	
	if ( model->subtype() == GLObjects::eGLModelType_VertexAnimation )
	{
		GLObjects::GLModelVertexAnimation * animatedModel = (GLObjects::GLModelVertexAnimation*)model;
		
		float addValue = 1.0f * delta;
		float value = animatedModel->blendValue();
		if ( value+addValue > 1.0f )
		{
			NSUInteger max		= animatedModel->numFrames();
			NSUInteger current	= animatedModel->startFrame() + 1;
			
			if ( current + 1 < max )
			{
				animatedModel->setStartFrame( current );
				animatedModel->setTargetFrame( current + 1 );
			}
			else
			{
				animatedModel->setStartFrame( 0 );
				animatedModel->setTargetFrame( 1 );
			}
			
			animatedModel->setBlendValue( addValue - value );
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

		model->setColor( GLColors::GLColor( 0, 0, 0, 1.0 ) );
		
		scene->add( model );	
	}
	
	[self addScene:scene];
	
	CGMaths::CGVector3D eye		= CGMaths::CGVector3DMake( 0.0f, 0.0f, 70.0f );
	CGMaths::CGVector3D target  = CGMaths::CGVector3DMake( 0.0f, 0.0f, 0.0f );
	
	[self camera]->setTransform( eye, target );
	
	lastTime = [[NSDate date] timeIntervalSinceReferenceDate];
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
