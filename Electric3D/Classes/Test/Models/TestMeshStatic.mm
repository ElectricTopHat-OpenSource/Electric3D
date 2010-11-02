//
//  TestMeshStatic.m
//  Electric3D
//
//  Created by Robert McDowell on 19/10/2010.
//  Copyright 2010 Electric TopHat Ltd. All rights reserved.
//

#import "TestMeshStatic.h"

#import "Electric3D.h"

@interface TestMeshStatic (PrivateMethods)

- (void) initialization;
- (void) teardown;

@end

@implementation TestMeshStatic


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
	int i;
	for ( i=0; i<scene->numchildren(); i++ )
	{
		E3D::E3DSceneNode * node = scene->child( i );
		if ( ( node->type() == E3D::eE3DSceneNodeType_ModelStatic ) ||
			 ( node->type() == E3D::eE3DSceneNodeType_ModelMorph ) )
		{
			E3D::E3DModel * model = (E3D::E3DModel*)node;
			
			CGMaths::CGMatrix4x4 mat = model->transform();
			CGMaths::CGMatrix4x4 rot = CGMaths::CGMatrix4x4MakeRotation( CGMaths::CGVector3DMake( 0.0f, 1.0f, 0.0f ), 1.0f * CGMaths::degreesToRadians );
			//CGMaths::CGMatrix4x4 rot2 = CGMaths::CGMatrix4x4MakeRotation( CGMaths::CGVector3DMake( 1.0f, 0.0f, 0.0f ), 10.0f * CGMaths::degreesToRadians );
			//CGMaths::CGMatrix4x4 rot = CGMaths::CGMatrix4x4Multiply( rot1, rot2 );
			
			CGMaths::CGMatrix4x4 newMat = CGMaths::CGMatrix4x4MakeMultiply( mat, rot );
			
			//CGMaths::CGMatrix4x4SetTranslation( newMat, 0, 0, 10 );
			
			model->setTransform( newMat );
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
	managers	= new E3D::E3DManagers();
	scene		= new E3D::E3DScene( @"Test Scene" );
	
	//const E3D::E3DMesh * mesh	= managers->meshes()->load( @"MD2StaticMeshTest", @"md2" );
	//const E3D::E3DMesh * mesh	= managers->meshes()->load( @"E3D_cube", @"md2" );
	const E3D::E3DMesh * mesh	= managers->meshes()->load( @"vertex_cube", @"POD" );
	//const E3D::E3DMesh * mesh	= managers->meshes()->load( @"vertex_cube_indexed", @"POD" );
	//const E3D::E3DMesh * mesh	= managers->meshes()->load( @"box", @"3ds" );
	
	if ( mesh )
	{
		E3D::E3DSceneNode * model = new E3D::E3DModelStatic( @"Test Model", mesh, nil );
		scene->addChild( model );
	}
	
	CGMaths::CGVector3D eye		= CGMaths::CGVector3DMake( 10.0f, 0.0f, 0.0f );
	CGMaths::CGVector3D target  = CGMaths::CGVector3DMake( 0.0f, 0.0f, 0.0f );
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
