//
//  GLES1RenderEngine.m
//  Electric3D
//
//  Created by Robert McDowell on 22/09/2010.
//  Copyright 2010 Electric TopHat Ltd. All rights reserved.
//

#import "GLES1RenderEngine.h"
#import <algorithm>

#import "E3DScene.h"
#import "E3DCamera.h"

#import "E3DModelStatic.h"
#import "E3DModelMorph.h"

#import "E3DTexture.h"

#import "E3DMesh.h"
#import "E3DMeshMorph.h"

namespace GLRenderers 
{
#pragma mark ---------------------------------------------------------
#pragma mark Constructor / Destructor
#pragma mark ---------------------------------------------------------
	
	// --------------------------------------------------
	// Constructor
	// --------------------------------------------------
	GLES1RenderEngine::GLES1RenderEngine()
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
	GLES1RenderEngine::~GLES1RenderEngine()
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
	void GLES1RenderEngine::createRenderBuffer()
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
	void GLES1RenderEngine::createFrameBuffer()
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
	
	// ----------------------------------------------
	// Create the Depth Buffer
	// ----------------------------------------------
	void GLES1RenderEngine::createDepthBuffer()
	{
		if ( ( m_renderbuffer ) && ( m_framebuffer ) && ( m_depthbuffer == 0 ) )
		{
			glGenRenderbuffersOES(1, &m_depthbuffer);
			glBindRenderbufferOES(GL_RENDERBUFFER_OES, m_depthbuffer);
			glRenderbufferStorageOES(GL_RENDERBUFFER_OES, GL_DEPTH_COMPONENT16_OES, m_width, m_height);
			glFramebufferRenderbufferOES(GL_FRAMEBUFFER_OES, GL_DEPTH_ATTACHMENT_OES, GL_RENDERBUFFER_OES, m_depthbuffer);
			
			glBindRenderbufferOES(GL_RENDERBUFFER_OES, m_renderbuffer);
			
			m_clearValue |= GL_DEPTH_BUFFER_BIT;
		}
	}
	
	// ----------------------------------------------
	// Destroy the Render Buffer
	// ----------------------------------------------
	void GLES1RenderEngine::destroyRenderBuffer()
	{
		if( m_renderbuffer ) 
		{
			glDeleteRenderbuffersOES(1, &m_renderbuffer);
			m_renderbuffer = 0;
		}
	}
	
	// ----------------------------------------------
	// Destroy the Frame Buffer
	// ----------------------------------------------
	void GLES1RenderEngine::destroyFrameBuffer()
	{
		if( m_framebuffer )
		{
			glDeleteFramebuffersOES(1, &m_framebuffer);
			m_framebuffer = 0;
		}
	}
	
	// ----------------------------------------------
	// Destroy the Depth Buffer
	// ----------------------------------------------
	void GLES1RenderEngine::destroyDepthBuffer()
	{
		if( m_depthbuffer ) 
		{
			glDeleteRenderbuffersOES(1, &m_depthbuffer);
			m_depthbuffer = 0;
		}
	}
	
	// --------------------------------------------------
	// rebind the buffers to the context
	// --------------------------------------------------
	void GLES1RenderEngine::rebindBuffers()
	{
		glBindRenderbufferOES(GL_RENDERBUFFER_OES, m_renderbuffer);
		glBindFramebufferOES(GL_FRAMEBUFFER_OES, m_framebuffer);
	}
	
	// --------------------------------------------------
	// Initialize
	// --------------------------------------------------
	void GLES1RenderEngine::initialize()
	{	
		glClearColor(0.5f, 0.5f, 0.5f, 1.0f);
		
		glViewport(0, 0, m_width, m_height);
		
		glEnable(GL_LIGHTING);
		glEnable(GL_LIGHT0);
		glEnable(GL_COLOR_MATERIAL);
		glShadeModel(GL_SMOOTH);
		
		GLfloat lightAmbient[]		= { 0.6f, 0.6f, 0.6f, 1.0f };
		GLfloat lightDiffuse[]		= { 0.6f, 0.6f, 0.6f, 1.0f };
		GLfloat lightSpecular[]		= { 0.6f, 0.6f, 0.6f, 1.0f };
		
		glLightfv( GL_LIGHT0, GL_AMBIENT,  lightAmbient );
		glLightfv( GL_LIGHT0, GL_DIFFUSE,  lightDiffuse );
		glLightfv( GL_LIGHT0, GL_SPECULAR, lightSpecular );
		
		GLfloat lightmodelAmbient[]	= { 0.2f, 0.2f, 0.2f, 1.0f };
		GLfloat lightmodelDiffuse[]	= { 0.2f, 0.2f, 0.2f, 1.0f };
		glLightModelfv( GL_AMBIENT, lightmodelAmbient );
		glLightModelfv( GL_DIFFUSE, lightmodelDiffuse );
	
		//GLfloat matAmbient[]		= { 1.0f, 0.0f, 0.6f, 1.0f };
		//GLfloat matDiffuse[]		= { 1.0f, 0.0f, 0.6f, 1.0f };
		
		//glMaterialfv(GL_FRONT_AND_BACK, GL_AMBIENT, matAmbient);
		//glMaterialfv(GL_FRONT_AND_BACK, GL_DIFFUSE, matDiffuse);
		
		glEnable(GL_DEPTH_TEST);
		//glDepthFunc(GL_LESS);
		glDepthFunc(GL_LEQUAL);
		//glDepthFunc(GL_EQUAL);
		//glDepthFunc(GL_ALWAYS);
		
		glEnable(GL_ALPHA_TEST);
		glAlphaFunc(GL_GREATER, 0.1f);
		//glAlphaFunc(GL_EQUAL,1.0f);
				
		glEnable(GL_BLEND);
		glEnable(GL_BLEND_COLOR);

		glBlendFunc(GL_DST_COLOR, GL_ZERO);
		glBlendFunc(GL_ONE, GL_ONE_MINUS_SRC_ALPHA);
		//glBlendFunc(GL_SRC_ALPHA, GL_ONE);
		glBlendFunc(GL_SRC_ALPHA, GL_ONE_MINUS_SRC_ALPHA);
		//glBlendFunc(GL_SRC_ALPHA_SATURATE, GL_ONE);
		
		glBlendEquation(GL_FUNC_ADD);
		
		//glFrontFace(GL_CW);
		glEnable(GL_CULL_FACE);
		glCullFace(GL_BACK);
		
		glEnable(GL_TEXTURE_2D);
		glEnableClientState(GL_VERTEX_ARRAY);
		glEnableClientState(GL_NORMAL_ARRAY);
		glEnableClientState(GL_TEXTURE_COORD_ARRAY);
		
		glEnableClientState(GL_COLOR_ARRAY);
	}
	
	// --------------------------------------------------
	// Teardown
	// --------------------------------------------------
	void GLES1RenderEngine::teardown()
	{
		glDisableClientState(GL_TEXTURE_COORD_ARRAY);
		glDisableClientState(GL_NORMAL_ARRAY);
		glDisableClientState(GL_COLOR_ARRAY);
		glDisable(GL_TEXTURE_2D); 
	}
	
	// --------------------------------------------------
	// set the Clear GLColor
	// --------------------------------------------------
	void GLES1RenderEngine::setClearColor( float _red, float _green, float _blue )
	{
		glClearColor(_red, _green, _blue, 1.0f);
	}
	
	// --------------------------------------------------
	//
	// --------------------------------------------------
	void GLES1RenderEngine::update( float _timeStep )
	{
	}
	
	// --------------------------------------------------
	// Render the Scene
	// --------------------------------------------------
	void GLES1RenderEngine::render()
	{
		// --------------------------------------
		// clear the screen
		// --------------------------------------
		glClear(m_clearValue);
		// --------------------------------------
		
		// --------------------------------------
		// reset the bound texture and color
		// --------------------------------------
		m_boundTexture	= 0;
		// --------------------------------------
		
		// --------------------------------------
		// Render the Scenes
		// --------------------------------------
		int i;
		for ( i=0; i<m_scenes.size(); i++ )
		{
			renderScene( m_scenes[i] );
		}
		// --------------------------------------
		
		// --------------------------------------
		// Re-bind the render buffer
		// --------------------------------------
		glBindRenderbufferOES(GL_RENDERBUFFER_OES, m_renderbuffer);
		// --------------------------------------
	}
	
	// --------------------------------------------------
	// On Rotate
	// --------------------------------------------------
	void GLES1RenderEngine::onRotate( eDeviceOrientation _newOrientation )
	{
	}
	
	// --------------------------------------------------
	// contains the scene
	// --------------------------------------------------
	BOOL GLES1RenderEngine::contains( E3D::E3DScene * _scene )
	{
		return FALSE;
	}
	
	// --------------------------------------------------
	// add the Scene to the render
	// --------------------------------------------------
	void GLES1RenderEngine::add( E3D::E3DScene * _scene )
	{
		m_scenes.push_back( _scene );
	}
	
	// --------------------------------------------------
	// remove the Scene from the render
	// --------------------------------------------------
	void GLES1RenderEngine::remove( E3D::E3DScene * _scene )
	{
		m_scenes.erase(std::remove(m_scenes.begin(), m_scenes.end(), _scene), m_scenes.end());
	}
	
#pragma mark ---------------------------------------------------------
#pragma mark End Public Functions
#pragma mark ---------------------------------------------------------
	
	
#pragma mark ---------------------------------------------------------
#pragma mark Private Functions
#pragma mark ---------------------------------------------------------
	
	// --------------------------------------------------
	// render a scene
	// --------------------------------------------------
	void GLES1RenderEngine::renderScene( E3D::E3DScene * _scene )
	{
		E3D::E3DCamera * camera = _scene->camera();
		
		// --------------------------------------
		// Update the view port
		// --------------------------------------
		const CGRect & viewport = camera->viewport();
		glViewport(viewport.origin.x, viewport.origin.y, viewport.size.width, viewport.size.height);
		// --------------------------------------
		
		// --------------------------------------
		// Update the camera perspective
		// --------------------------------------
		CGMaths::CGMatrix4x4 perspective = camera->projectionMatrix();
		glMatrixMode(GL_PROJECTION);
		glLoadMatrixf( perspective.m );
		// --------------------------------------
		
		// --------------------------------------
		// Update the camera matrix
		// --------------------------------------
		CGMaths::CGMatrix4x4 matrix = camera->modelMatrix();
		glMatrixMode(GL_MODELVIEW);	
		glLoadMatrixf( matrix.m );
		// --------------------------------------
		
		// --------------------------------------
		// render the root node
		// --------------------------------------
		renderNode( &_scene->root(), GLColors::GLColorWhite );
		// --------------------------------------
	}
	
	// --------------------------------------------------
	// render a node
	// --------------------------------------------------
	void GLES1RenderEngine::renderNode( E3D::E3DSceneNode * _node, const GLColors::GLColor & _color )
	{
		if ( _node->isVisible() )
		{
			GLColors::GLColor color = _color * _node->color();
			
			glPushMatrix();
			glMultMatrixf( _node->transform().m );

			switch (_node->type()) 
			{
				case E3D::eE3DSceneNodeType_ModelMorph:
				{
					E3D::E3DModelMorph * model = (E3D::E3DModelMorph*)_node;
					const E3D::E3DMeshMorph * mesh =  model->meshVA();
					
					bindColor( color );
					bindTexture( model->texture() );
					
					const GLInterleavedVert3D * verts;
					if ( model->startFrame() == model->targetFrame() )
					{
						verts = mesh->interpverts( model->startFrame() );
					}
					else 
					{
						verts = mesh->interpverts( model->startFrame(), model->targetFrame(), model->blendValue() );
					}
					
					if ( mesh->indices() == nil )
					{
						renderNonIndexedVerts( verts, mesh->numverts() );
					}
					else 
					{
						renderIndexedVerts( verts, mesh->indices(), mesh->numindices() );
					}
					
					break;
				}
				case E3D::eE3DSceneNodeType_ModelStatic:
				{	
					E3D::E3DModelStatic * model = (E3D::E3DModelStatic*)_node;
					const E3D::E3DMesh * mesh = model->mesh();
					
					bindColor( color );
					bindTexture( model->texture() );
					
					if ( mesh->indices() == nil )
					{
						renderNonIndexedVerts( mesh->verts(), mesh->numverts() );
					}
					else 
					{
						renderIndexedVerts( mesh->verts(), mesh->indices(), mesh->numindices() );
					}
					break;
				}
				default:
					break;
			}
			
			int i;
			for ( i=0; i<_node->numchildren(); i++ )
			{
				renderNode( _node->child(i), color );
			}
			
			glPopMatrix();
		}
	}
	
	// ------------------------------------------
	// bind the GLColor
	// ------------------------------------------
	void GLES1RenderEngine::bindColor( const GLColors::GLColor & _color )
	{
		glColor4f(_color.red(), _color.green(), _color.blue(), _color.alpha());
	}
	
	// ------------------------------------------
	// bind the Texture
	// ------------------------------------------
	void GLES1RenderEngine::bindTexture( const E3D::E3DTexture * _texture )
	{		
		GLuint newTexture = 0;
		if ( _texture )
		{
			newTexture = _texture->bindID();
		}
		if ( m_boundTexture != newTexture )
		{			
			m_boundTexture = newTexture;
			glBindTexture(GL_TEXTURE_2D, newTexture);
		}
	}				
	
	// ------------------------------------------
	// render the verts
	// ------------------------------------------
	void GLES1RenderEngine::renderNonIndexedVerts( const GLInterleavedVert3D * _verts, NSUInteger _numverts )
	{
		glVertexPointer(3, GL_FLOAT,	sizeof(GLInterleavedVert3D), &_verts[0].vert.x);
		glNormalPointer(GL_FLOAT,		sizeof(GLInterleavedVert3D), &_verts[0].normal.x);
#if GLInterleavedVert3D_color
		glColorPointer(4, GL_UNSIGNED_BYTE, sizeof(GLInterleavedVert3D), &_verts[0].color);
#endif
		glTexCoordPointer(2, GL_FLOAT,	sizeof(GLInterleavedVert3D), &_verts[0].uv.x);
		
		glDrawArrays(GL_TRIANGLES, 0, _numverts);
	}
	
	// ------------------------------------------
	// render the verts
	// ------------------------------------------
	void GLES1RenderEngine::renderIndexedVerts( const GLInterleavedVert3D * _verts, const GLVertIndice * _indices, NSUInteger _numindices )
	{
		glVertexPointer(3, GL_FLOAT,	sizeof(GLInterleavedVert3D), &_verts[0].vert.x);
		glNormalPointer(GL_FLOAT,		sizeof(GLInterleavedVert3D), &_verts[0].normal.x);
#if GLInterleavedVert3D_color
		glColorPointer(4, GL_UNSIGNED_BYTE, sizeof(GLInterleavedVert3D), &_verts[0].color);
#endif
		glTexCoordPointer(2, GL_FLOAT,	sizeof(GLInterleavedVert3D), &_verts[0].uv.x);
		
		glDrawElements(GL_TRIANGLES, _numindices, GL_UNSIGNED_SHORT, &_indices[0]);
	}
	
	// ------------------------------------------
	// render the lines
	// ------------------------------------------
	void GLES1RenderEngine::renderLineStrip( const _GLVert3D * _points, NSUInteger _numpoints )
	{
		glDisable(GL_TEXTURE_2D);		
		glDisableClientState(GL_TEXTURE_COORD_ARRAY);
		glDisableClientState(GL_NORMAL_ARRAY);
#if GLInterleavedVert3D_color
		glDisableClientState(GL_COLOR_ARRAY);
#endif 
		
		glColor4f(1.0f, 1.0f, 1.0f, 1.0f);	// line color
		glLineWidth(1.0f);					// line width
		
		glVertexPointer(3, GL_FLOAT, 0, _points);
		glDrawArrays(GL_LINE_STRIP, 0, _numpoints);
		
		glEnable(GL_TEXTURE_2D); 
		glEnableClientState(GL_TEXTURE_COORD_ARRAY);
		glEnableClientState(GL_NORMAL_ARRAY);
#if GLInterleavedVert3D_color
		glEnableClientState(GL_COLOR_ARRAY);
#endif
	}
	
#pragma mark ---------------------------------------------------------
#pragma mark End Private Functions
#pragma mark ---------------------------------------------------------
	
};