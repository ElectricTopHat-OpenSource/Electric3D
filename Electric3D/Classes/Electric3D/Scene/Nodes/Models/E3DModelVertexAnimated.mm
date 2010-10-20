//
//  E3DModelVertexAnimated.m
//  Electric3D
//
//  Created by Robert McDowell on 19/10/2010.
//  Copyright 2010 Electric TopHat Ltd. All rights reserved.
//

#import "E3DModelVertexAnimated.h"

#import "CGMaths.h"
#import "GLMeshVertexAnimation.h"


namespace E3D  
{
#pragma mark ---------------------------------------------------------
#pragma mark Constructor / Destructor
#pragma mark ---------------------------------------------------------
	
	// --------------------------------------------------
	// Constructor
	// --------------------------------------------------
	E3DModelVertexAnimated::E3DModelVertexAnimated( NSString * _name, const GLMeshes::GLMeshVertexAnimation * _mesh, const GLTextures::GLTexture * _texture )
	: E3DModel		( _name, _texture )
	, m_mesh		( _mesh )
	, m_startFrame	( 0 )
	, m_targetFrame ( 0 )
	, m_blend		( 0.0f )
	{
	}
	
	// --------------------------------------------------
	// Destructor
	// --------------------------------------------------
	E3DModelVertexAnimated::~E3DModelVertexAnimated()
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
	const CGMaths::CGAABB E3DModelVertexAnimated::aabb() const
	{
		CGMaths::CGAABB aabb = m_mesh->aabb();
		return CGMaths::CGAABBMakeTransformed( aabb, m_transform );
	}
	
	// --------------------------------------------------
	// Get the model bounding sphere
	// --------------------------------------------------
	const CGMaths::CGSphere E3DModelVertexAnimated::sphere() const
	{
		CGMaths::CGSphere sphere = m_mesh->sphere();		
		sphere.center = CGMaths::CGMatrix4x4TransformVector( m_transform, sphere.center );
		return sphere;
	}
	
	// --------------------------------------------------
	// get the number of frames in the animation
	// --------------------------------------------------
	NSUInteger E3DModelVertexAnimated::numFrames() const
	{
		return m_mesh->numframes();
	}
	
	// --------------------------------------------------
	// set the start frame
	// --------------------------------------------------
	void E3DModelVertexAnimated::setStartFrame( NSUInteger _startFrame )
	{
		m_startFrame = CGMaths::Clamp( _startFrame, 0, m_mesh->numframes()-1 );
	}
	
	// --------------------------------------------------
	// set the target frame
	// --------------------------------------------------
	void E3DModelVertexAnimated::setTargetFrame( NSUInteger _targetFrame )
	{
		m_targetFrame = CGMaths::Clamp( _targetFrame, 0, m_mesh->numframes()-1 );
	}
	
	// --------------------------------------------------
	// set the Blend Value
	// --------------------------------------------------
	void E3DModelVertexAnimated::setBlendValue( float _blend )
	{
		m_blend = CGMaths::Clamp( _blend, 0.0f, 1.0f );
	}
	
#pragma mark ---------------------------------------------------------
#pragma mark === End Public Functions  ===
#pragma mark ---------------------------------------------------------
};