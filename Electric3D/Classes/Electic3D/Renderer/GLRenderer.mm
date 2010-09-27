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

#import "GLES1RenderEngine.h"

#import <OpenGLES/ES2/gl.h> // for GL_RENDERBUFFER only

#import "GLMeshFactory.h"
#import "GLTextureFactory.h"
#import "GLSpriteFactory.h"

@implementation GLRenderer

#pragma mark ---------------------------------------------------------
#pragma mark === Properties  ===
#pragma mark ---------------------------------------------------------

@synthesize meshes			= m_meshFactory;
@synthesize textures		= m_textureFactory;
@synthesize sprites			= m_spriteFactory;

#pragma mark ---------------------------------------------------------
#pragma mark === End Properties  ===
#pragma mark ---------------------------------------------------------

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
		m_renderer = new GLRenderers::GLES1RenderEngine();
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
		
		// --------------------------------------
		// Create the container objects
		// --------------------------------------
		m_meshFactory		= new GLMeshes::GLMeshFactory();
		m_textureFactory	= new GLTextures::GLTextureFactory();
		m_spriteFactory		= new GLSprites::GLSpriteFactory( m_textureFactory );
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
	// Teardown the container classes
	// --------------------------------------
	if ( m_spriteFactory )
	{
		SAFE_DELETE( m_spriteFactory );
	}
	if ( m_textureFactory )
	{
		SAFE_DELETE( m_textureFactory );
	}
	if ( m_meshFactory )
	{
		SAFE_DELETE( m_meshFactory );
	}
	// --------------------------------------
	
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
	
	// --------------------------------------
	// Release the layer
	// --------------------------------------
	SAFE_RELEASE( m_layer );
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
	[EAGLContext setCurrentContext:m_context];
	m_renderer->rebindBuffers();
	[self render:nil];
}

// ------------------------------------------
// render and presetn the buffer
// ------------------------------------------
- (void) render:(id)_sender
{
	[EAGLContext setCurrentContext:m_context];
	
	m_renderer->render();
	
	[m_context presentRenderbuffer:GL_RENDERBUFFER_OES];
}

// ------------------------------------------
// does the render contain the scene
// ------------------------------------------
- (BOOL) containsScene:(GLObjects::GLScene*)_scene
{
	return m_renderer->contains( _scene );
}

// ------------------------------------------
// add the Scene to the render
// ------------------------------------------
- (void) addScene:(GLObjects::GLScene*)_scene
{
	m_renderer->add( _scene );
}

// ------------------------------------------
// remove the Scene from the render
// ------------------------------------------
- (void) removeScene:(GLObjects::GLScene*)_scene
{
	m_renderer->remove( _scene );
}

#pragma mark ---------------------------------------------------------
#pragma mark === End Public Functions  ===
#pragma mark ---------------------------------------------------------

@end
