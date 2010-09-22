//
//  GLRenderer.m
//  Electric3D
//
//  Created by Robert McDowell on 22/09/2010.
//  Copyright 2010 Electric TopHat Ltd. All rights reserved.
//

#import "GLRenderer.h"
#import <OpenGLES/EAGL.h>
#import <OpenGLES/EAGLDrawable.h>
#import <QuartzCore/QuartzCore.h>
#import "GLRenderEngineES1.h"

#import <OpenGLES/ES2/gl.h> // for GL_RENDERBUFFER only

@implementation GLRenderer

#pragma mark ---------------------------------------------------------
#pragma mark === Constructor / Destructor Functions  ===
#pragma mark ---------------------------------------------------------

// ------------------------------------------
// Initialization
// ------------------------------------------
- (id) initWithLayer:(CAEAGLLayer*)_layer withClearColor:(UIColor*)_clearColor;
{
	if ( self = [super init] )
	{
		// --------------------------------------
		// Setup the layer
		// --------------------------------------
		m_layer = [_layer retain];
		m_layer.opaque = YES;
		m_layer.drawableProperties = [NSDictionary dictionaryWithObjectsAndKeys:
									  [NSNumber numberWithBool:NO], 
									  kEAGLDrawablePropertyRetainedBacking, 
									  kEAGLColorFormatRGB565, 
									  kEAGLDrawablePropertyColorFormat, 
									  nil];
		// --------------------------------------
		
		// --------------------------------------
		// Create the EAGL context
		// --------------------------------------
		m_context = [[EAGLContext alloc] initWithAPI:kEAGLRenderingAPIOpenGLES1];
		
		if ( !m_context || ![EAGLContext setCurrentContext:m_context] )
		{
			[self release];
			return nil;
		}
		// --------------------------------------
	
		// --------------------------------------
		// Create the Render
		// --------------------------------------
		m_renderer = new GLRenderEngineES1();
		// --------------------------------------
		
		// --------------------------------------
		// Create the Render Buffer
		// --------------------------------------
		m_renderer->createRenderBuffer();
		// --------------------------------------
		
		// --------------------------------------
		// Bind the render Buffer
		// --------------------------------------
		[m_context renderbufferStorage:GL_RENDERBUFFER 
						  fromDrawable:m_layer];
		// --------------------------------------
		
		// --------------------------------------
		// Create the Frame and depth Buffers
		// --------------------------------------
		m_renderer->createFrameBuffer();
		m_renderer->createDepthBuffer();
		// --------------------------------------
		
		// --------------------------------------
		// Initialize the renders state
		// --------------------------------------
		m_renderer->initialize();
		// --------------------------------------
	}
	
	return self;
}

// ------------------------------------------
// dealloc
// ------------------------------------------
- (void) dealloc
{
	// --------------------------------------
	// Teardown the render and destroy it
	// --------------------------------------
	if ( m_renderer )
	{
		m_renderer->teardown();
		m_renderer->destroyDepthBuffer();
		m_renderer->destroyFrameBuffer();
		m_renderer->destroyRenderBuffer();
		
		SAFE_DELETE( m_renderer );
	}
	// --------------------------------------
	
	// --------------------------------------
	// Remove the Context
	// --------------------------------------
	if ([EAGLContext currentContext] == m_context) 
	{
        [EAGLContext setCurrentContext:nil];
    }
	SAFE_RELEASE( m_context );
	// --------------------------------------
	
	[super dealloc];
}

#pragma mark ---------------------------------------------------------
#pragma mark === End Constructor / Destructor Functions  ===
#pragma mark ---------------------------------------------------------

#pragma mark ---------------------------------------------------------
#pragma mark === Public Functions  ===
#pragma mark ---------------------------------------------------------

// ------------------------------------------
// rebind the context
// ------------------------------------------
- (void) rebindContext
{
}

// ------------------------------------------
// render and presetn the buffer
// ------------------------------------------
- (void) render:(id)_sender
{
	m_renderer->Render();
	[m_context presentRenderbuffer:GL_RENDERBUFFER_OES];
}

#pragma mark ---------------------------------------------------------
#pragma mark === End Public Functions  ===
#pragma mark ---------------------------------------------------------

@end
