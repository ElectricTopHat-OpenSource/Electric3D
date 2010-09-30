//
//  GLES1Renderer.m
//  Electric3D
//
//  Created by Robert McDowell on 25/09/2010.
//  Copyright 2010 Electric TopHat Ltd. All rights reserved.
//

#import "GLES1Renderer.h"

#import <OpenGLES/ES1/gl.h>
#import <OpenGLES/ES1/glext.h>
#import <algorithm>

#import "GLScene.h"

#import "GLObjectTypes.h"
#import "GLObject.h"
#import "GLModel.h"

#import "GLVertexTypes.h"
#import "GLMesh.h"
#import "GLMeshShapes.h"

#import "GLTexture.h"

namespace GLRenderers 
{
#pragma mark ---------------------------------------------------------
#pragma mark Constructor / Destructor
#pragma mark ---------------------------------------------------------
	
	GLES1Renderer::GLES1Renderer()
	{
		m_boundTexture	= 0;
	}
	
	GLES1Renderer::~GLES1Renderer()
	{	
		m_objects.clear();
	}
	
#pragma mark ---------------------------------------------------------
#pragma mark End Constructor / Destructor
#pragma mark ---------------------------------------------------------
	
#pragma mark ---------------------------------------------------------
#pragma mark Public Functions
#pragma mark ---------------------------------------------------------
	
	void GLES1Renderer::initialize()
	{
		glEnable(GL_TEXTURE_2D);
		
		glEnable(GL_ALPHA_TEST);
		glAlphaFunc(GL_GREATER, 0.1f);
		
		glEnable(GL_BLEND);
		glBlendFunc(GL_ONE, GL_ONE_MINUS_SRC_ALPHA);
		glBlendFunc(GL_SRC_ALPHA,GL_ONE_MINUS_SRC_ALPHA);
		
		glTexEnvf(GL_TEXTURE_ENV, GL_TEXTURE_ENV_MODE, GL_MODULATE);
		
		//glFrontFace(GL_CW);
		//glEnable(GL_CULL_FACE);
		//glCullFace(GL_BACK);
		
		glEnableClientState(GL_VERTEX_ARRAY);
		glEnableClientState(GL_NORMAL_ARRAY);
#if GLInterleavedVert3D_color
		glEnableClientState(GL_COLOR_ARRAY);
#endif
		glEnableClientState(GL_TEXTURE_COORD_ARRAY);
	}
	
	void GLES1Renderer::teardown()
	{
		
	}
	
	BOOL GLES1Renderer::contains( GLObjects::GLScene * _scene )
	{
		return FALSE;
	}
	
	void GLES1Renderer::add( GLObjects::GLScene * _scene )
	{
		m_objects.push_back( _scene );
	}
	
	void GLES1Renderer::remove( GLObjects::GLScene * _scene )
	{
		m_objects.erase(std::remove(m_objects.begin(), m_objects.end(), _scene), m_objects.end());
	}
	
	void GLES1Renderer::render()
	{	
		// reset the bound texture and color
		m_boundTexture	= 0;
		
		// set the base scene color to white
		GLColors::GLColor color = GLColors::GLColorWhite;
		
		for ( _RenderScenesListIterator it = m_objects.begin(); it != m_objects.end(); it++ )
		{
			GLObjects::GLScene * obj = *it;
			render( obj, color ); 
		}
	}
	
#pragma mark ---------------------------------------------------------
#pragma mark End Public Functions
#pragma mark ---------------------------------------------------------
	
#pragma mark ---------------------------------------------------------
#pragma mark Private Functions
#pragma mark ---------------------------------------------------------
	
	// ------------------------------------------
	// render a scene
	// ------------------------------------------
	void GLES1Renderer::render( GLObjects::GLScene * _scene, const GLColors::GLColor & _color )
	{
		if ( !_scene->isHidden() )
		{
			glPushMatrix();
			glMultMatrixf( _scene->transform().m );
			
			GLColors::GLColor color = _color * _scene->color();
			
			const GLObjects::_SceneList & scene = _scene->objects();
			for ( GLObjects::_SceneListConstIterator it = scene.begin(); it != scene.end(); it++ )
			{
				GLObjects::GLObject * obj = it->second;
				switch ( obj->type() )
				{
					case GLObjects::eGLObjectType_Scene:
					{
						render( (GLObjects::GLScene*) obj, color );
						break;
					}
					case GLObjects::eGLObjectType_Model:
					{
						render( (GLObjects::GLModel*) obj, color );
						break;
					}
				};
			}
			
			glPopMatrix();
		}
	}
	
	// ------------------------------------------
	// render an object
	// ------------------------------------------
	void GLES1Renderer::render( GLObjects::GLModel * _object, const GLColors::GLColor & _color )
	{
		if ( !_object->isHidden() )
		{
			glPushMatrix();
			
			glMultMatrixf( _object->transform().m );
			
			const GLColors::GLColor color = _color * _object->color();
			
			bindColor( color );
			bindTexture( _object->texture() );
			renderVerts( _object->verts(), _object->numverts() );
			
			glPopMatrix();
		}
	}
	
	// ------------------------------------------
	// bind the GLColor
	// ------------------------------------------
	void GLES1Renderer::bindColor( const GLColors::GLColor & _color )
	{
		glColor4f(_color.red(), _color.green(), _color.blue(), _color.alpha());
	}
	
	// ------------------------------------------
	// bind the Texture
	// ------------------------------------------
	void GLES1Renderer::bindTexture( const GLTextures::GLTexture * _texture )
	{		
		if ( _texture )
		{
			GLuint newTexture = _texture->bindID();
			if ( m_boundTexture != newTexture )
			{			
				m_boundTexture = newTexture;
				glBindTexture(GL_TEXTURE_2D, newTexture);
			}
		}
	}				
	
	// ------------------------------------------
	// render the verts
	// ------------------------------------------
	void GLES1Renderer::renderVerts( const GLInterleavedVert3D * _verts, NSUInteger _numverts )
	{
		glVertexPointer(3, GL_FLOAT,	sizeof(GLInterleavedVert3D), &_verts[0].vert.x);
		glNormalPointer(GL_FLOAT,		sizeof(GLInterleavedVert3D), &_verts[0].normal.x);
#if GLInterleavedVert3D_color
		glColorPointer(4, GL_UNSIGNED_BYTE, sizeof(GLInterleavedVert3D), &_verts[0].color);
#endif
		glTexCoordPointer(2, GL_FLOAT,	sizeof(GLInterleavedVert3D), &_verts[0].uv.x);
		glDrawArrays(GL_TRIANGLES, 0, _numverts);
	}
	
#pragma mark ---------------------------------------------------------
#pragma mark End Private Functions
#pragma mark ---------------------------------------------------------
};