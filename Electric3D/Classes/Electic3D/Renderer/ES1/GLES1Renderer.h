//
//  GLES1Renderer.h
//  Electric3D
//
//  Created by Robert McDowell on 25/09/2010.
//  Copyright 2010 Electric TopHat Ltd. All rights reserved.
//

#if !defined(__GLES1Renderer_h__)
#define __GLES1Renderer_h__

#import <OpenGLES/ES1/gl.h>
#import <OpenGLES/ES1/glext.h>
#import <vector>
#import "GLVertexTypes.h"
#import "GLTexture.h"

namespace GLObjects		{ class GLScene; };
//namespace GLTextures	{ class GLTexture; };
namespace GLObjects		{ class GLModel; };

namespace GLRenderers 
{
#pragma mark ---------------------------------------------------------
#pragma mark Type Defines
#pragma mark ---------------------------------------------------------
	
	typedef std::vector<GLObjects::GLScene*>					_RenderScenesList;
	typedef std::vector<GLObjects::GLScene*>::iterator			_RenderScenesListIterator;
	typedef std::vector<GLObjects::GLScene*>::const_iterator	_RenderScenesListConstIterator;
	
#pragma mark ---------------------------------------------------------
#pragma mark End Type Defines
#pragma mark ---------------------------------------------------------
	
	class GLES1Renderer
	{
#pragma mark ---------------------------------------------------------
#pragma mark Constructor / Destructor
#pragma mark ---------------------------------------------------------
	public: // Functions
		
		GLES1Renderer();
		virtual ~GLES1Renderer();
		
#pragma mark ---------------------------------------------------------
#pragma mark End Constructor / Destructor
#pragma mark ---------------------------------------------------------
		
#pragma mark ---------------------------------------------------------
#pragma mark Public Functions
#pragma mark ---------------------------------------------------------
	public: // Functions
		
		void initialize();
		void teardown();
		
		BOOL contains( GLObjects::GLScene * _scene );
		void add( GLObjects::GLScene * _scene );
		void remove( GLObjects::GLScene * _scene );
		
		void render();
		
#pragma mark ---------------------------------------------------------
#pragma mark End Public Functions
#pragma mark ---------------------------------------------------------
		
#pragma mark ---------------------------------------------------------
#pragma mark Private Functions
#pragma mark ---------------------------------------------------------
	private: // Data
		
		inline void render( GLObjects::GLScene * _scene );
		inline void render( GLObjects::GLModel * _object );
		
		inline void bindTexture( const GLTextures::GLTexture * _texture );
		inline void renderVerts( const GLInterleavedVert3D * _verts, NSUInteger _numverts );
		
#pragma mark ---------------------------------------------------------
#pragma mark End Private Functions
#pragma mark ---------------------------------------------------------
		
#pragma mark ---------------------------------------------------------
#pragma mark Private Data
#pragma mark ---------------------------------------------------------
	private: // Data
		
		GLuint				m_boundTexture;
		_RenderScenesList	m_objects;
		
#pragma mark ---------------------------------------------------------
#pragma mark End Private Data
#pragma mark ---------------------------------------------------------
	};
};

#endif