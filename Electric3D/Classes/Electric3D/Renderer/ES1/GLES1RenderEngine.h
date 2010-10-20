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
#import <vector>

#import "IRenderEngine.h"
#import "GLColors.h"
#import "GLVertexTypes.h"

namespace E3D		{ class E3DScene; };
namespace E3D		{ class E3DSceneNode; };
namespace GLTextures	{ class GLTexture; };

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
		
		void setClearColor( float _red, float _green, float _blue );
		
		void initialize();
		void teardown();
		
		void update( float _timeStep );
		void render();
		void onRotate( eDeviceOrientation _newOrientation );
				
		BOOL contains( E3D::E3DScene * _scene );
		void add( E3D::E3DScene * _scene );
		void remove( E3D::E3DScene * _scene );
		
#pragma mark ---------------------------------------------------------
#pragma mark End Public Functions
#pragma mark ---------------------------------------------------------
		
#pragma mark ---------------------------------------------------------
#pragma mark Private Functions
#pragma mark ---------------------------------------------------------
	private: // Data
		
		inline void renderScene( E3D::E3DScene * _scene );
		inline void renderNode( E3D::E3DSceneNode * _node, const GLColors::GLColor & _color );
		
		inline void bindColor( const GLColors::GLColor & _color );
		inline void bindTexture( const GLTextures::GLTexture * _texture );
		
		inline void renderNonIndexedVerts( const GLInterleavedVert3D * _verts, NSUInteger _numverts );
		inline void renderIndexedVerts( const GLInterleavedVert3D * _verts, const GLVertIndice * _indices, NSUInteger _numindices );
		inline void renderLineStrip( const _GLVert3D * _points, NSUInteger _numverts );
		
#pragma mark ---------------------------------------------------------
#pragma mark End Private Functions
#pragma mark ---------------------------------------------------------
		
#pragma mark ---------------------------------------------------------
#pragma mark Private Data
#pragma mark ---------------------------------------------------------
	private: // Data
				
		// E3D Scenes to render
		std::vector<E3D::E3DScene*>	m_scenes;
		
		// currently bound texture
		GLuint	m_boundTexture;
		
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
