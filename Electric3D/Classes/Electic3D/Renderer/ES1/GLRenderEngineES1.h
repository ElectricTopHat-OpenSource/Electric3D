//
//  GLRenderEngineES1.h
//  Electric3D
//
//  Created by Robert McDowell on 22/09/2010.
//  Copyright 2010 Electric TopHat Ltd. All rights reserved.
//

#import <OpenGLES/ES1/gl.h>
#import <OpenGLES/ES1/glext.h>
#import "IRenderEngine.h"

class GLRenderEngineES1 : public IRenderEngine
{
#pragma mark ---------------------------------------------------------
#pragma mark Constructor / Destructor
#pragma mark ---------------------------------------------------------
public: // Functions
	
	GLRenderEngineES1();
	~GLRenderEngineES1();
	
#pragma mark ---------------------------------------------------------
#pragma mark End Constructor / Destructor
#pragma mark ---------------------------------------------------------

#pragma mark ---------------------------------------------------------
#pragma mark Public Functions
#pragma mark ---------------------------------------------------------
public: // Functions
	
	void createRenderBuffer();
	void createFrameBuffer();
	void createDepthBuffer();
	
	void destroyRenderBuffer();
	void destroyFrameBuffer();
	void destroyDepthBuffer();
	
	void setClearColor( float _red=1.0f, float _green=1.0f, float _blue=1.0f );
	
	void initialize();
	void teardown();
	
	void Update( float _timeStep );
	void Render();
	void OnRotate( eDeviceOrientation _newOrientation );

#pragma mark ---------------------------------------------------------
#pragma mark End Public Functions
#pragma mark ---------------------------------------------------------

#pragma mark ---------------------------------------------------------
#pragma mark Private Functions
#pragma mark ---------------------------------------------------------
private: // Data


#pragma mark ---------------------------------------------------------
#pragma mark End Private Functions
#pragma mark ---------------------------------------------------------
	
#pragma mark ---------------------------------------------------------
#pragma mark Private Data
#pragma mark ---------------------------------------------------------
private: // Data
	
	// The pixel dimensions of the backbuffer
    GLint m_width;
    GLint m_height;
	
	// OpenGL names for the renderbuffer and 
	// framebuffers used to render to this view
    GLuint m_renderbuffer;
	GLuint m_framebuffer;
    
    // OpenGL name for the depth buffer that 
	// is attached to viewFramebuffer, if it 
	// exists (0 if it does not exist)
    GLuint m_depthbuffer;

	// how should the view be cleared
	GLbitfield m_clearValue;
	
#pragma mark ---------------------------------------------------------
#pragma mark End Private Data
#pragma mark ---------------------------------------------------------
};
