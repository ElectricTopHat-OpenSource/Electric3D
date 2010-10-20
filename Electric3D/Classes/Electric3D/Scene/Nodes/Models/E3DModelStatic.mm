//
//  E3DModelStatic.m
//  Electric3D
//
//  Created by Robert McDowell on 19/10/2010.
//  Copyright 2010 Electric TopHat Ltd. All rights reserved.
//

#import "E3DModelStatic.h"
#import "GLMesh.h"

namespace E3D  
{
	
#pragma mark ---------------------------------------------------------
#pragma mark Constructor / Destructor
#pragma mark ---------------------------------------------------------

	// --------------------------------------------------
	// Constructor
	// --------------------------------------------------
	E3DModelStatic::E3DModelStatic( NSString * _name, const GLMeshes::GLMesh * _mesh, const GLTextures::GLTexture * _texture )
	: E3DModel	( _name, _texture )
	, m_mesh	( _mesh )
	{
	}
	
	// --------------------------------------------------
	// Destructor
	// --------------------------------------------------
	E3DModelStatic::~E3DModelStatic()
	{
	}

#pragma mark ---------------------------------------------------------
#pragma mark End Constructor / Destructor
#pragma mark ---------------------------------------------------------
	
#pragma mark ---------------------------------------------------------
#pragma mark === Public Functions  ===
#pragma mark ---------------------------------------------------------
		
	// --------------------------------------------------
	// Get the mesh AABB
	// --------------------------------------------------
	const CGMaths::CGAABB E3DModelStatic::aabb() const
	{
		CGMaths::CGAABB aabb = m_mesh->aabb();
		return CGMaths::CGAABBMakeTransformed( aabb, m_transform );
	}
	
	// --------------------------------------------------
	// Get the model bounding sphere
	// --------------------------------------------------
	const CGMaths::CGSphere E3DModelStatic::sphere() const
	{
		CGMaths::CGSphere sphere = m_mesh->sphere();		
		sphere.center = CGMaths::CGMatrix4x4TransformVector( m_transform, sphere.center );
		return sphere;
	}
	
#pragma mark ---------------------------------------------------------
#pragma mark === End Public Functions  ===
#pragma mark ---------------------------------------------------------
	
};