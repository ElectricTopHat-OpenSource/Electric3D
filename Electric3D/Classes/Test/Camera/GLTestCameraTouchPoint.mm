//
//  GLTestCameraTouchPoint.m
//  Electric3D
//
//  Created by Robert McDowell on 12/10/2010.
//  Copyright 2010 Electric TopHat Ltd. All rights reserved.
//

#import "GLTestCameraTouchPoint.h"

#import "GLTextureFactory.h"
#import "GLTexture.h"

#import "GLMeshFactory.h"
#import "GLMesh.h"

#import "GLCamera.h"
#import "GLScene.h"
#import "GLModels.h"

@interface GLTestCameraTouchPoint (PrivateMethods)

- (void) initialization;
- (void) teardown;

@end

@implementation GLTestCameraTouchPoint

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

// ------------------------------------------
// Touches Began
// ------------------------------------------
- (void) touchesBegan:(NSSet *)_touches withEvent:(UIEvent *)_event
{
	[super touchesBegan:_touches withEvent:_event];

	if ( model )
	{
		model->setPosition( CGMaths::CGVector3DMake( 0, 0, 0 ) );
	}
}

// ------------------------------------------
// Touches Moved
// ------------------------------------------
- (void) touchesMoved:(NSSet *)_touches withEvent:(UIEvent *)_event
{
	[super touchesMoved:_touches withEvent:_event];

	NSSet *		currentTouches		= [_event allTouches];
	CGPoint screen_point			= [[currentTouches anyObject] locationInView:self];
	
	CGRect rect = [self frame];
	
	static float z = 10.0f;
	CGMaths::CGVector3D worldPoint	= [self screenToWorld:CGMaths::CGVector3DMake( screen_point.x, rect.size.height - screen_point.y, z ) ];
	CGMaths::CGVector3D screenPoint = [self worldToScreen:worldPoint ];
	
	if ( z < 50.0f )
	{
		z += 0.1f;
	}
	
	if ( model )
	{
		model->setPosition( worldPoint );
	}
}

// ------------------------------------------
// Touches Ended
// ------------------------------------------
- (void) touchesEnded:(NSSet *)_touches withEvent:(UIEvent *)_event
{
	[super touchesEnded:_touches withEvent:_event];

}

// ------------------------------------------
// Touches Cancelled
// ------------------------------------------
- (void)touchesCancelled:(NSSet *)_touches withEvent:(UIEvent *)_event
{
	[super touchesCancelled:_touches withEvent:_event];

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
	scene = new GLObjects::GLScene( @"Test" );
	
	mesh	= [self meshes]->load( @"vertex_cube", @"POD" );
	
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
	
	CGMaths::CGVector3D eye		= CGMaths::CGVector3DMake( 10.0f, 0.0f, 10.0f );
	CGMaths::CGVector3D target  = CGMaths::CGVector3DMake( 0.0f, 0.0f, 0.0f );
	
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
