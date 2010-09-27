//
//  GLModel.m
//  Electric3D
//
//  Created by Robert McDowell on 22/09/2010.
//  Copyright 2010 Electric TopHat Ltd. All rights reserved.
//

#import "GLModel.h"
#import "GLMesh.h"

namespace GLObjects
{
	
#pragma mark ---------------------------------------------------------
#pragma mark Constructor / Destructor
#pragma mark ---------------------------------------------------------
	
	// --------------------------------------------------
	// Constructor
	// --------------------------------------------------
	GLModel::GLModel( NSString * _name ) 
	:GLObject(_name) 
	{
	}
	
	// --------------------------------------------------
	// Destructor
	// --------------------------------------------------
	GLModel::~GLModel()
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
	NSUInteger GLModel::numverts() const
	{
		return m_mesh->numverts();
	}
	
	// --------------------------------------------------
	// Get the verts for the mesh
	// --------------------------------------------------
	const GLInterleavedVert3D* GLModel::verts() const
	{
		return m_mesh->verts();
	}
	
#pragma mark ---------------------------------------------------------
#pragma mark === End Public Functions  ===
#pragma mark ---------------------------------------------------------
	
};