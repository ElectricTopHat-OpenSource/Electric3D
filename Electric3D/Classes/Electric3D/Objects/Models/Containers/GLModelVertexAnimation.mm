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
	, m_targetFrame	( 0 )
	, m_blend		( 0.0f )
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
	// Get the mesh AABB
	// --------------------------------------------------
	const CGMaths::CGAABB GLModelVertexAnimation::aabb() const
	{
		CGMaths::CGAABB aabb;
		if ( m_mesh )
		{
			if ( m_startFrame == m_targetFrame )
			{
				aabb = m_mesh->aabb( m_startFrame );
			}
			else 
			{
				aabb = m_mesh->aabb( m_startFrame, m_targetFrame, m_blend );
			}
		}
		else 
		{
			aabb = CGMaths::CGAABBUnit;
		}
		
		return CGMaths::CGAABBMakeTransformed( aabb, m_transform );
	}
	
	// --------------------------------------------------
	// Get the model bounding sphere
	// --------------------------------------------------
	const CGMaths::CGSphere GLModelVertexAnimation::sphere() const
	{
		CGMaths::CGSphere sphere;
		
		if ( m_mesh )
		{
			if ( m_startFrame == m_targetFrame )
			{
				sphere = m_mesh->sphere( m_startFrame );
			}
			else 
			{
				sphere = m_mesh->sphere( m_startFrame, m_targetFrame, m_blend );
			}
		}
		else 
		{
			sphere = CGMaths::CGSphereUnit;
		}
		
		sphere.center = CGMaths::CGMatrix4x4TransformVector( m_transform, sphere.center );
		
		return sphere;
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
	// Number indices in the mesh
	// --------------------------------------------------
	NSUInteger GLModelVertexAnimation::numindices() const
	{
		if ( m_mesh )
		{
			return m_mesh->numindices();
		}
		return 0;
	}
	
	// --------------------------------------------------
	// Return the vert list type
	// --------------------------------------------------
	const eGLVertListType GLModelVertexAnimation::vertListType() const
	{
		if ( m_mesh )
		{
			return m_mesh->vertListType();
		}
		return eGLVertListType_Unknown;
	}
	
	// --------------------------------------------------
	// Get the verts for the mesh
	// --------------------------------------------------
	const GLInterleavedVert3D * GLModelVertexAnimation::verts() const
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
	
	// --------------------------------------------------
	// Get the verts indices for the mesh
	// --------------------------------------------------
	const GLVertIndice * GLModelVertexAnimation::indices() const
	{
		if ( m_mesh )
		{
			return m_mesh->indices();
		}
		return 0;
	}
	
#pragma mark ---------------------------------------------------------
#pragma mark === End Public Functions  ===
#pragma mark ---------------------------------------------------------
	
};