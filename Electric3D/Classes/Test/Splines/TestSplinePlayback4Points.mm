//
//  TestSplinePlayback4Points.m
//  Electric3D
//
//  Created by Robert McDowell on 20/10/2010.
//  Copyright 2010 Electric TopHat Ltd. All rights reserved.
//

#import "TestSplinePlayback4Points.h"
#import "Electric3D.h"

@interface TestSplinePlayback4Points (PrivateMethods)

- (void) initialization;
- (void) teardown;

@end

@implementation TestSplinePlayback4Points


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
	if ( spline )
	{
		CGMaths::CGVector3D worldPoint = spline->interpolate( value );
		
		value += 0.001f;
		if ( value > 1.0f )
		{
			value = 0.0f;
		}
		
		if ( scene->numchildren() )
		{
			E3D::E3DSceneNode * node = scene->child( 0 );
			node->setPosition( worldPoint );
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
	
	spline = managers->splines()->load( @"SPLINE_4Points", @"3ds" );
	value  = 0.0f;
	
	if ( spline )
	{
		{
			const E3D::E3DMesh * mesh	= managers->meshes()->load( @"vertex_cube", @"POD" );
			E3D::E3DSceneNode * model = new E3D::E3DModelStatic( @"Test Model", mesh, nil );
			scene->addChild( model );
		}
		
		{
			const E3D::E3DMesh * mesh	= managers->meshes()->load( @"SL_EX_house", @"POD" );
			E3D::E3DSceneNode * model = new E3D::E3DModelStatic( @"Test Scene", mesh, nil );
			scene->addChild( model );
		}
		
		CGMaths::CGAABB aabb = spline->aabb();
		
		CGMaths::CGVector3D eye		= CGMaths::CGVector3DMake( 0.0f, 100.0f, 200.0f );
		CGMaths::CGVector3D target  = CGMaths::CGAABBGetCenter( aabb ); // CGMaths::CGVector3DMake(  0.0f, 0.0f, 0.0f );
		scene->camera()->setTransform( eye, target );
		scene->camera()->setViewport( [self bounds] );
		scene->camera()->setFov( 45.0f );
	}
	
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
