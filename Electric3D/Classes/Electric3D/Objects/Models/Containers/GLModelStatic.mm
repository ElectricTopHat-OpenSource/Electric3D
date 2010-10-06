//
//  GLModelStatic.m
//  Electric3D
//
//  Created by Robert McDowell on 27/09/2010.
//  Copyright 2010 Electric TopHat Ltd. All rights reserved.
//

#import "GLModelStatic.h"
#import "GLMesh.h"

namespace GLObjects
{
	
#pragma mark ---------------------------------------------------------
#pragma mark Constructor / Destructor
#pragma mark ---------------------------------------------------------
	
	// --------------------------------------------------
	// Constructor
	// --------------------------------------------------
	GLModelStatic::GLModelStatic( NSString * _name ) 
	: GLModel	(_name) 
	, m_mesh	( nil )
	{
	}
	
	// --------------------------------------------------
	// Destructor
	// --------------------------------------------------
	GLModelStatic::~GLModelStatic()
	{
	}
	
#pragma mark ---------------------------------------------------------
#pragma mark End Constructor / Destructor
#pragma mark ---------------------------------------------------------
	
#pragma mark ---------------------------------------------------------
#pragma mark === Public Functions  ===
#pragma mark ---------------------------------------------------------
	
	// --------------------------------------------------
	// Number verts in the mesh
	// --------------------------------------------------
	NSUInteger GLModelStatic::numverts() const
	{
		if ( m_mesh )
		{
			return m_mesh->numverts();
		}
		return 0;
	}
	
	// --------------------------------------------------
	// Number faces in the mesh
	// --------------------------------------------------
	NSUInteger GLModelStatic::numindices() const
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
	const eGLVertListType GLModelStatic::vertListType() const
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
	const GLInterleavedVert3D * GLModelStatic::verts() const
	{
		if ( m_mesh )
		{
			return m_mesh->verts();
		}
		return 0;
	}
	
	// --------------------------------------------------
	// Get the verts indices for the mesh
	// --------------------------------------------------
	const GLVertIndice * GLModelStatic::indices() const
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
