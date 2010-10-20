//
//  TestMeshAnimated.m
//  Electric3D
//
//  Created by Robert McDowell on 19/10/2010.
//  Copyright 2010 Electric TopHat Ltd. All rights reserved.
//

#import "TestMeshAnimated.h"

#import "Electric3D.h"

@interface TestMeshAnimated (PrivateMethods)

- (void) initialization;
- (void) teardown;

@end

@implementation TestMeshAnimated


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
	NSTimeInterval delta = [deltaTimer update];
	
	int i;
	for ( i=0; i<scene->numchildren(); i++ )
	{
		E3D::E3DSceneNode * node = scene->child( i );
		if ( node->type() == E3D::eE3DSceneNodeType_ModelVertexAnimated )
		{
			E3D::E3DModelVertexAnimated * model = (E3D::E3DModelVertexAnimated*)node;
			
			float addValue = 2.0f * delta;
			float value = model->blendValue();
			if ( value+addValue > 1.0f )
			{
				NSUInteger max		= model->numFrames();
				NSUInteger current	= model->startFrame() + 1;
				
				if ( current + 1 < max )
				{
					model->setStartFrame( current );
					model->setTargetFrame( current + 1 );
				}
				else
				{
					model->setStartFrame( 0 );
					model->setTargetFrame( 1 );
				}
				
				model->setBlendValue( addValue - value );
			}
			else
			{
				model->setBlendValue( value+addValue );
			}
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
	scene = new E3D::E3DScene( @"Test Scene" );
	
	const GLTextures::GLTexture * texture	= [[self renderer] factories]->textures()->load( @"MD2Test", @"png" );
	const GLMeshes::GLMesh * mesh			= [[self renderer] factories]->meshes()->load( @"MD2AnimatedMeshTest", @"md2" );
	
	if ( mesh && ( mesh->type() == GLMeshes::eGLMeshType_VertexAnimation ) )
	{
		E3D::E3DSceneNode * model = new E3D::E3DModelVertexAnimated( @"Test Model", (GLMeshes::GLMeshVertexAnimation*)mesh, texture );
		scene->addChild( model );
	}
	
	CGMaths::CGVector3D eye		= CGMaths::CGVector3DMake( 0.0f, 0.0f, 70.0f );
	CGMaths::CGVector3D target  = CGMaths::CGVector3DMake( 0.0f, 0.0f, 0.0f );
	scene->camera()->setTransform( eye, target );
	scene->camera()->setViewport( [self bounds] );
	
	[[self renderer] addScene:scene];
	
	deltaTimer = [[DeltaTimer alloc] init];
}

// ------------------------------------------
// Teardown
// ------------------------------------------
- (void) teardown
{
	[deltaTimer release];
	
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
