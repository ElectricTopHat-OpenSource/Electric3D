//
//  GLES1RenderEngine.h
//  Electric3D
//
//  Created by Robert McDowell on 22/09/2010.
//  Copyright 2010 Electric TopHat Ltd. All rights reserved.
//

#if !defined(__GLES1RenderEngine_h__)
#define __GLES1RenderEngine_h__

#import <OpenGLES/ES1/gl.h>
#import <OpenGLES/ES1/glext.h>

#import "IRenderEngine.h"
#import "GLES1Renderer.h"

namespace GLObjects { class GLScene; };

namespace GLRenderers 
{
	class GLES1RenderEngine : public IRenderEngine
	{
#pragma mark ---------------------------------------------------------
#pragma mark Constructor / Destructor
#pragma mark ---------------------------------------------------------
	public: // Functions
		
		GLES1RenderEngine();
		virtual ~GLES1RenderEngine();
		
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
		
		void rebindBuffers();
		
		void setClearColor( float _red=1.0f, float _green=1.0f, float _blue=1.0f );
		
		void initialize();
		void teardown();
		
		void update( float _timeStep );
		void render();
		void onRotate( eDeviceOrientation _newOrientation );
		
		BOOL contains( GLObjects::GLScene * _scene );
		void add( GLObjects::GLScene * _scene );
		void remove( GLObjects::GLScene * _scene );
		
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
		
		// Renderer Pipelines
		GLES1Renderer		m_Renderer;
		
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
};

#endif
