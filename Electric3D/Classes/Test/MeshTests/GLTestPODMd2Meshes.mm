//
//  GLTestPODMd2Meshes.m
//  Electric3D
//
//  Created by Robert McDowell on 10/10/2010.
//  Copyright 2010 Electric TopHat Ltd. All rights reserved.
//

#import "GLTestPODMd2Meshes.h"

#import "GLTextureFactory.h"
#import "GLTexture.h"

#import "GLMeshFactory.h"
#import "GLMesh.h"

#import "GLCamera.h"
#import "GLScene.h"
#import "GLModels.h"

@interface GLTestPODMd2Meshes (PrivateMethods)

- (void) initialization;
- (void) teardown;

@end

@implementation GLTestPODMd2Meshes

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
	if ( scene )
	{
		CGMaths::CGMatrix4x4 mat = scene->transform();
		CGMaths::CGMatrix4x4 rot = CGMaths::CGMatrix4x4MakeRotation( CGMaths::CGVector3DMake( 0.0f, 1.0f, 0.0f ), 0.1f * CGMaths::degreesToRadians );
		//CGMaths::CGMatrix4x4 rot2 = CGMaths::CGMatrix4x4MakeRotation( CGMaths::CGVector3DMake( 1.0f, 0.0f, 0.0f ), 10.0f * CGMaths::degreesToRadians );
		//CGMaths::CGMatrix4x4 rot = CGMaths::CGMatrix4x4Multiply( rot1, rot2 );
		
		CGMaths::CGMatrix4x4 newMat = CGMaths::CGMatrix4x4MakeMultiply( mat, rot );
		
		//CGMaths::CGMatrix4x4SetTranslation( newMat, 0, 0, 10 );
		
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

	const GLTextures::GLTexture * texture; 
	const GLMeshes::GLMesh *		mesh;
	
	texture = [self textures]->load( @"BERTCUBE", @"png" ); 
	mesh	= [self meshes]->load( @"BERTCUBE", @"POD" );
	
	CGMaths::CGAABB aabb = CGMaths::CGAABBUnit;
	if ( mesh )
	{
		aabb = mesh->aabb();
		
		modelPOD = new GLObjects::GLModelStatic( @"TestObj" );
		modelPOD->setMesh( mesh );
		modelPOD->setTexture( texture );
		
		scene->add( modelPOD );
	}
	
	texture = [self textures]->load( @"BERTCUBE", @"png" ); 
	mesh	= [self meshes]->load( @"BERTCUBE", @"md2" );
	
	if ( mesh )
	{
		aabb = mesh->aabb();
		
		modelmd2 = new GLObjects::GLModelStatic( @"TestObj" );
		modelmd2->setMesh( mesh );
		modelmd2->setTexture( texture );
		
		scene->add( modelmd2 );
	}
	
	[self addScene:scene];
	
	CGMaths::CGVector3D meshcenter	= CGAABBGetCenter( aabb );
	CGMaths::CGVector3D meshvolume  = CGAABBGetVolume( aabb );
	CGMaths::CGVector3D eye			= CGMaths::CGVector3DMakeAdd( meshcenter, CGMaths::CGVector3DMake( 0.0f, 10.0f, meshvolume.z+10.0f ) );
	CGMaths::CGVector3D target		= meshcenter;//CGMaths::CGVector3DMake( 0.0f, 0.0f, 0.0f );
	
	[self camera]->setTransform( eye, target );
}

// ------------------------------------------
// Teardown
// ------------------------------------------
- (void) teardown
{
	[self removeScene:scene];
	
	if ( scene )
	{
		scene->remove( modelPOD );
		scene->remove( modelmd2 );
		
		if ( modelPOD )
		{
			[self textures]->release( modelPOD->texture() );
			[self meshes]->release( modelPOD->mesh() );
		}
		
		if ( modelmd2 )
		{
			[self textures]->release( modelmd2->texture() );
			[self meshes]->release( modelmd2->mesh() );
		}
	}
	
	delete( modelPOD );
	delete( modelmd2 );
	delete( scene );
}

#pragma mark ---------------------------------------------------------
#pragma mark === End Private Functions  ===
#pragma mark ---------------------------------------------------------

@end
