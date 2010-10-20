//
//  GLView.m
//  Electric3D
//
//  Created by Robert McDowell on 22/09/2010.
//  Copyright 2010 Electric TopHat Ltd. All rights reserved.
//

#import "GLView.h"
#import "GLRenderer.h"
#import <OpenGLES/EAGL.h>
#import <OpenGLES/EAGLDrawable.h>
#import <QuartzCore/QuartzCore.h>

@implementation GLView

#pragma mark ---------------------------------------------------------
#pragma mark === Class Redifintion  ===
#pragma mark ---------------------------------------------------------

// ------------------------------------------
// You must implement this method
// ------------------------------------------
+ (Class)layerClass 
{
    return [CAEAGLLayer class];
}

#pragma mark ---------------------------------------------------------
#pragma mark === End Class Redifintion  ===
#pragma mark ---------------------------------------------------------

#pragma mark ---------------------------------------------------------
#pragma mark === Properties  ===
#pragma mark ---------------------------------------------------------

@synthesize renderer = m_renderer;

#pragma mark ---------------------------------------------------------
#pragma mark === End Properties  ===
#pragma mark ---------------------------------------------------------

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
		CAEAGLLayer * eaglLayer = (CAEAGLLayer*)super.layer;
		m_renderer = [[GLRenderer alloc] initWithLayer:eaglLayer withClearColor:nil];
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
		CAEAGLLayer * eaglLayer = (CAEAGLLayer*)super.layer;
		m_renderer = [[GLRenderer alloc] initWithLayer:eaglLayer withClearColor:nil];
    }
    return self;
}

// ------------------------------------------
// dealloc
// ------------------------------------------
- (void) dealloc
{
	SAFE_RELEASE( m_renderer );
	
	[super dealloc];
}

#pragma mark ---------------------------------------------------------
#pragma mark === End Constructor / Destructor Functions  ===
#pragma mark ---------------------------------------------------------

#pragma mark ---------------------------------------------------------
#pragma mark === UIView Functions  ===
#pragma mark ---------------------------------------------------------

// ------------------------------------------
// layout subview
// ------------------------------------------
- (void)layoutSubviews 
{
    [m_renderer rebindContext];
}

// ------------------------------------------
// set the Background color
// ------------------------------------------
- (void) setBackgroundColor:(UIColor *)_color
{
	[super setBackgroundColor:_color];
	[m_renderer setClearColor:_color];
}

#pragma mark ---------------------------------------------------------
#pragma mark === End UIView Functions  ===
#pragma mark ---------------------------------------------------------

#pragma mark ---------------------------------------------------------
#pragma mark === Public Functions  ===
#pragma mark ---------------------------------------------------------

// ------------------------------------------
// Draw the View
// ------------------------------------------
- (void) drawView:(id)_sender
{
	[m_renderer render:_sender];
}

// ------------------------------------------
// did View Rotate
// ------------------------------------------
- (void) didRotate:(NSNotification*)_notification
{
}

#pragma mark ---------------------------------------------------------
#pragma mark === End Public Functions  ===
#pragma mark ---------------------------------------------------------

@end
