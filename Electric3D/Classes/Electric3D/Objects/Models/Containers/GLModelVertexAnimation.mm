//
//  GLModelVertexAnimation.m
//  Electric3D
//
//  Created by Robert McDowell on 27/09/2010.
//  Copyright 2010 Electric TopHat Ltd. All rights reserved.
//

#import "GLModelVertexAnimation.h"

#import "GLMeshTypes.h"
#import "GLMeshVertexAnimation.h"

#import "CGMaths.h"

namespace GLObjects
{
	
#pragma mark ---------------------------------------------------------
#pragma mark Constructor / Destructor
#pragma mark ---------------------------------------------------------

	// --------------------------------------------------
	// Constructor
	// --------------------------------------------------
	GLModelVertexAnimation::GLModelVertexAnimation( NSString * _name ) 
	: GLModel		(_name) 
	, m_mesh		( nil )
	, m_startFrame	( 0 )
	, m_targetFrame	( 1 )
	, m_blend		( 0.5f )
	{
	}
	
	// --------------------------------------------------
	// Destructor
	// --------------------------------------------------
	GLModelVertexAnimation::~GLModelVertexAnimation()
	{
	}

#pragma mark ---------------------------------------------------------
#pragma mark End Constructor / Destructor
#pragma mark ---------------------------------------------------------

#pragma mark ---------------------------------------------------------
#pragma mark === Public Functions  ===
#pragma mark ---------------------------------------------------------
	
	// --------------------------------------------------
	// set the start frame
	// --------------------------------------------------
	void GLModelVertexAnimation::setStartFrame( NSUInteger _startFrame )
	{
		m_startFrame = CGMaths::iClamp( _startFrame, 0, m_mesh->numframes() );
	}
	
	// --------------------------------------------------
	// set the target frame
	// --------------------------------------------------
	void GLModelVertexAnimation::setTargetFrame( NSUInteger _targetFrame )
	{
		m_targetFrame = CGMaths::iClamp( _targetFrame, 0, m_mesh->numframes() );
	}
	
	// --------------------------------------------------
	// set the Blend Value
	// --------------------------------------------------
	void GLModelVertexAnimation::setBlendValue( float _blend )
	{
		m_blend = CGMaths::fClamp( _blend, 0.0f, 1.0f );
	}
	
	// --------------------------------------------------
	// get the number of frames in the animation
	// --------------------------------------------------
	NSUInteger GLModelVertexAnimation::numFrames() const
	{
		if ( m_mesh )
		{
			return m_mesh->numframes();
		}
		return 0;
	}
	
	// --------------------------------------------------
	// set the Mesh
	// --------------------------------------------------
	void GLModelVertexAnimation::setMesh(const GLMeshes::GLMesh * _mesh)
	{
		if ( _mesh && ( _mesh->type() == GLMeshes::eGLMeshType_VertexAnimation ) )
		{
			m_mesh = (GLMeshes::GLMeshVertexAnimation*)_mesh;
		}
		else 
		{
			DPrint( @"WARNING :: Model %@ did not accept mesh as it does not support vertex animations", m_name );
			m_mesh = nil;
		}
	}
	
	// --------------------------------------------------
	// get the mesh
	// --------------------------------------------------
	const GLMeshes::GLMesh * GLModelVertexAnimation::mesh() const
	{
		return m_mesh;
	}
	
	// --------------------------------------------------
	// get the number of verts in the mesh
	// --------------------------------------------------
	NSUInteger GLModelVertexAnimation::numverts() const
	{
		if ( m_mesh )
		{
			return m_mesh->numverts();
		}
		return 0;
	}
	
	// --------------------------------------------------
	// Get the verts for the mesh
	// --------------------------------------------------
	const GLInterleavedVert3D* GLModelVertexAnimation::verts() const
	{
		if ( m_mesh )
		{
			if ( m_startFrame == m_targetFrame )
			{
				return m_mesh->interpverts( m_startFrame );
			}
			else 
			{
				return m_mesh->interpverts( m_startFrame, m_targetFrame, m_blend );
			}
		}
		return nil;
	}
	
#pragma mark ---------------------------------------------------------
#pragma mark === End Public Functions  ===
#pragma mark ---------------------------------------------------------
	
};