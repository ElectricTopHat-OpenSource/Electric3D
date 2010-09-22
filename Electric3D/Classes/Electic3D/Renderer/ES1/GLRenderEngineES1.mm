//
//  GLRenderEngineES1.m
//  Electric3D
//
//  Created by Robert McDowell on 22/09/2010.
//  Copyright 2010 Electric TopHat Ltd. All rights reserved.
//

#import "GLRenderEngineES1.h"
#import "glu.h"

#pragma mark ---------------------------------------------------------
#pragma mark Constructor / Destructor
#pragma mark ---------------------------------------------------------

// --------------------------------------------------
// Constructor
// --------------------------------------------------
GLRenderEngineES1::GLRenderEngineES1()
: m_renderbuffer ( 0 )
, m_framebuffer  ( 0 )
, m_depthbuffer  ( 0 )
, m_width		 ( 320 )
, m_height		 ( 480 )
, m_clearValue   ( GL_COLOR_BUFFER_BIT )
{
}

// --------------------------------------------------
// Destructor
// --------------------------------------------------
GLRenderEngineES1::~GLRenderEngineES1()
{
}

#pragma mark ---------------------------------------------------------
#pragma mark End Constructor / Destructor
#pragma mark ---------------------------------------------------------

#pragma mark ---------------------------------------------------------
#pragma mark Public Functions
#pragma mark ---------------------------------------------------------

// ----------------------------------------------
// Create the Render Buffer
// ----------------------------------------------
void GLRenderEngineES1::createRenderBuffer()
{
	if ( m_renderbuffer == 0 )
	{
		glGenRenderbuffersOES(1, &m_renderbuffer);
		glBindRenderbufferOES(GL_RENDERBUFFER_OES, m_renderbuffer);
	}
}

// ----------------------------------------------
// Create the Frame Buffer
// ----------------------------------------------
void GLRenderEngineES1::createFrameBuffer()
{
	if ( ( m_renderbuffer ) && ( m_framebuffer == 0 ) )
	{
		glGenFramebuffersOES(1, &m_framebuffer);
		glBindFramebufferOES(GL_FRAMEBUFFER_OES, m_framebuffer);
		glFramebufferRenderbufferOES(GL_FRAMEBUFFER_OES, GL_COLOR_ATTACHMENT0_OES, GL_RENDERBUFFER_OES, m_renderbuffer);
	}
	
	glGetRenderbufferParameterivOES(GL_RENDERBUFFER_OES, GL_RENDERBUFFER_WIDTH_OES, &m_width);
	glGetRenderbufferParameterivOES(GL_RENDERBUFFER_OES, GL_RENDERBUFFER_HEIGHT_OES, &m_height);
}

void GLRenderEngineES1::createDepthBuffer()
{
	if ( ( m_renderbuffer ) && ( m_framebuffer ) && ( m_depthbuffer == 0 ) )
	{
		glGenRenderbuffersOES(1, &m_depthbuffer);
        glBindRenderbufferOES(GL_RENDERBUFFER_OES, m_depthbuffer);
        glRenderbufferStorageOES(GL_RENDERBUFFER_OES, GL_DEPTH_COMPONENT16_OES, m_width, m_height);
        glFramebufferRenderbufferOES(GL_FRAMEBUFFER_OES, GL_DEPTH_ATTACHMENT_OES, GL_RENDERBUFFER_OES, m_depthbuffer);
		
		m_clearValue |= GL_DEPTH_BUFFER_BIT;
	}
}

void GLRenderEngineES1::destroyRenderBuffer()
{
	if( m_renderbuffer ) 
	{
        glDeleteRenderbuffersOES(1, &m_renderbuffer);
		m_renderbuffer = 0;
    }
}

void GLRenderEngineES1::destroyFrameBuffer()
{
	if( m_framebuffer )
	{
		glDeleteFramebuffersOES(1, &m_framebuffer);
		m_framebuffer = 0;
	}
}

void GLRenderEngineES1::destroyDepthBuffer()
{
	if( m_depthbuffer ) 
	{
        glDeleteRenderbuffersOES(1, &m_depthbuffer);
		m_depthbuffer = 0;
    }
}

// --------------------------------------------------
// Initialize
// --------------------------------------------------
void GLRenderEngineES1::initialize()
{	
	glClearColor(0.5f, 0.5f, 0.5f, 1.0f);
	
    glViewport(0, 0, m_width, m_height);
	
	glEnable(GL_LIGHTING);
	glEnable(GL_LIGHT0);
	
	glShadeModel(GL_SMOOTH);
	
	glEnable(GL_DEPTH_TEST);
	//glDisable(GL_DEPTH_TEST);
	
	glEnable(GL_TEXTURE_2D);
	
	float lightAmbient[] = { 0.6f, 0.6f, 0.6f, 1.0f };
	float lightDiffuse[] = { 0.6f, 0.6f, 0.6f, 1.0f };
	glLightfv(GL_LIGHT0, GL_AMBIENT, lightAmbient);
	glLightfv(GL_LIGHT0, GL_DIFFUSE, lightDiffuse);
	
	float matAmbient[] = { 0.6f, 0.6f, 0.6f, 1.0f };
	float matDiffuse[] = { 0.6f, 0.6f, 0.6f, 1.0f };
	glMaterialfv(GL_FRONT_AND_BACK, GL_AMBIENT, matAmbient);
	glMaterialfv(GL_FRONT_AND_BACK, GL_DIFFUSE, matDiffuse);
	
    
    glMatrixMode(GL_PROJECTION);	
    glLoadIdentity();
	
	float aspect = (float)m_width / (float)m_height;
	gluPerspective(70, aspect, 1, 1000);
	
    glMatrixMode(GL_MODELVIEW);	
    glLoadIdentity();
}

// --------------------------------------------------
// Teardown
// --------------------------------------------------
void GLRenderEngineES1::teardown()
{
	
}

// --------------------------------------------------
// set the Clear Color
// --------------------------------------------------
void GLRenderEngineES1::setClearColor( float _red, float _green, float _blue )
{
	glClearColor(_red, _green, _blue, 1.0f);
}

// --------------------------------------------------
//
// --------------------------------------------------
void GLRenderEngineES1::Update( float _timeStep )
{
}

// --------------------------------------------------
// Render the Scene
// --------------------------------------------------
void GLRenderEngineES1::Render()
{
	glClear(GL_COLOR_BUFFER_BIT|GL_DEPTH_BUFFER_BIT);
	
}

// --------------------------------------------------
// On Rotate
// --------------------------------------------------
void GLRenderEngineES1::OnRotate( eDeviceOrientation _newOrientation )
{
}

#pragma mark ---------------------------------------------------------
#pragma mark End Public Functions
#pragma mark ---------------------------------------------------------


#pragma mark ---------------------------------------------------------
#pragma mark Private Functions
#pragma mark ---------------------------------------------------------


#pragma mark ---------------------------------------------------------
#pragma mark End Private Functions
#pragma mark ---------------------------------------------------------