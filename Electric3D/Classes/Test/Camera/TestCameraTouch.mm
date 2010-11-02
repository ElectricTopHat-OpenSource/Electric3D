//
//  TestCameraTouch.m
//  Electric3D
//
//  Created by Robert McDowell on 12/10/2010.
//  Copyright 2010 Electric TopHat Ltd. All rights reserved.
//

#import "TestCameraTouch.h"
#import "Electric3D.h"

@interface TestCameraTouch (PrivateMethods)

- (void) initialization;
- (void) teardown;

@end

@implementation TestCameraTouch

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
	[self drawView:nil];
}

#pragma mark ---------------------------------------------------------
#pragma mark === End Public Functions  ===
#pragma mark ---------------------------------------------------------

#pragma mark ---------------------------------------------------------
#pragma mark === UIResponder Functions  ===
#pragma mark ---------------------------------------------------------

- (void) moveObjectsToPoint:(CGPoint)_point
{
	CGRect rect = [self frame];
	
	CGMaths::CGVector3D worldPoint	= scene->camera()->screenToWorld( CGMaths::CGVector3DMake( _point.x, rect.size.height - _point.y, depth ) );
	
	if ( depth < 50.0f )
	{
		depth += 0.1f;
	}
	
	int i;
	for ( i=0; i<scene->numchildren(); i++ )
	{
		E3D::E3DSceneNode * node = scene->child( i );
		node->setPosition( worldPoint );
	}
}

// ------------------------------------------
// Touches Began
// ------------------------------------------
- (void) touchesBegan:(NSSet *)_touches withEvent:(UIEvent *)_event
{
	[super touchesBegan:_touches withEvent:_event];
	[self moveObjectsToPoint:[[_touches anyObject] locationInView:self]];
}

// ------------------------------------------
// Touches Moved
// ------------------------------------------
- (void) touchesMoved:(NSSet *)_touches withEvent:(UIEvent *)_event
{
	[super touchesMoved:_touches withEvent:_event];
	[self moveObjectsToPoint:[[_touches anyObject] locationInView:self]];
}

#pragma mark ---------------------------------------------------------
#pragma mark === End UIResponder Functions  ===
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
	
	const E3D::E3DMesh * mesh = managers->meshes()->load( @"E3D_cube", @"md2" );
	E3D::E3DSceneNode * model = new E3D::E3DModelStatic( @"Cube", mesh );
	
	scene->addChild( model );
		
	CGMaths::CGVector3D eye		= CGMaths::CGVector3DMake( 10.0f, 0.0f, 10.0f );
	CGMaths::CGVector3D target  = CGMaths::CGVector3DMake( 0.0f, 0.0f, 0.0f );
	
	scene->camera()->setFov( 45.0f );
	scene->camera()->setTransform( eye, target );
	scene->camera()->setViewport( [self bounds] );
	
	depth = 10.0f;
	
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
