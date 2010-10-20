//
//  GLTestPodMesh.m
//  Electric3D
//
//  Created by Robert McDowell on 07/10/2010.
//  Copyright 2010 Electric TopHat Ltd. All rights reserved.
//

#import "GLTestPodMesh.h"

#import "GLTextureFactory.h"
#import "GLTexture.h"

#import "GLMeshFactory.h"
#import "GLMesh.h"

#import "GLCamera.h"
#import "GLScene.h"
#import "GLModels.h"

@interface GLTestPodMesh (PrivateMethods)

- (void) initialization;
- (void) teardown;

@end

@implementation GLTestPodMesh

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
		CGMaths::CGMatrix4x4 rot = CGMaths::CGMatrix4x4MakeRotation( CGMaths::CGVector3DMake( 0.0f, 1.0f, 0.0f ), 0.0f * CGMaths::degreesToRadians );
		//CGMaths::CGMatrix4x4 rot2 = CGMaths::CGMatrix4x4MakeRotation( CGMaths::CGVector3DMake( 1.0f, 0.0f, 0.0f ), 10.0f * CGMaths::degreesToRadians );
		//CGMaths::CGMatrix4x4 rot = CGMaths::CGMatrix4x4Multiply( rot1, rot2 );
		
		CGMaths::CGMatrix4x4 newMat = CGMaths::CGMatrix4x4MakeMultiply( mat, rot );
		
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
	
	//texture = [self textures]->load( @"SL_HL_clock", @"png" ); 
	//mesh	= [self meshes]->load( @"SL_HL_clock_RGBA", @"POD" );
	//mesh	= [self meshes]->load( @"SL_HL_clock_ARGB", @"POD" );
	
	//texture = [self textures]->load( @"SL_ghosts", @"png" ); 
	//mesh	= [self meshes]->load( @"SL_ghosts", @"POD" );
	
	//texture = [self textures]->load( @"SL_EX_house", @"png" ); 
	//mesh	= [self meshes]->load( @"SL_EX_house", @"POD" );
	
	texture = [self textures]->load( @"SL_EX_house", @"png" ); 
	mesh	= [self meshes]->load( @"SL_EX_house", @"POD" );
	
	//texture = [self textures]->load( @"SL_EX_gravestones", @"png" ); 
	//mesh	= [self meshes]->load( @"SL_EX_gravestones", @"md2" );
	
	CGMaths::CGAABB aabb = CGMaths::CGAABBUnit;
	if ( mesh )
	{
		aabb = mesh->aabb();
		
		model = new GLObjects::GLModelStatic( @"TestObj" );
		model->setMesh( mesh );
		model->setTexture( texture );
		
		scene->add( model );
	}
	
	[self addScene:scene];
	
	CGMaths::CGVector3D meshcenter	= CGAABBGetCenter( aabb );
	CGMaths::CGVector3D meshvolume  = CGAABBGetVolume( aabb );
	CGMaths::CGVector3D eye			= CGMaths::CGVector3DMakeAdd( meshcenter, CGMaths::CGVector3DMake( 0.0f, 0.0f, meshvolume.z+0.0f ) );
	CGMaths::CGVector3D target		= CGMaths::CGVector3DMake( 0.0f, 0.0f, 0.0f );
	
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
