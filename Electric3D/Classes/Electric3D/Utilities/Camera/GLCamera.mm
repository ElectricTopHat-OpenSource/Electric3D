//
//  GLCamera.m,
//  Electric3D
//
//  Created by Robert McDowell on 28/09/2010.
//  Copyright 2010 Electric TopHat Ltd. All rights reserved.
//

#import "GLCamera.h"

namespace GLCameras 
{
#pragma mark ---------------------------------------------------------
#pragma mark Constructor / Destructor
#pragma mark ---------------------------------------------------------
	
	// --------------------------------------------------
	// Constructor
	// --------------------------------------------------
	GLCamera::GLCamera()
	: m_transform (CGMaths::CGMatrix4x4Identity)
	, m_fov		( 45.0f )
	, m_near	( 1.0f )
	, m_far		( 100.0f )
	{
	}
	
	// --------------------------------------------------
	// Copy Constructor
	// --------------------------------------------------
	GLCamera::GLCamera( const GLCamera & _camera )
	{
		m_transform = _camera.m_transform;
	}
	
	// --------------------------------------------------
	// Destructor
	// --------------------------------------------------
	GLCamera::~GLCamera()
	{
	}
	
#pragma mark ---------------------------------------------------------
#pragma mark End Constructor / Destructor
#pragma mark ---------------------------------------------------------
	
#pragma mark ---------------------------------------------------------
#pragma mark === Public Functions  ===
#pragma mark ---------------------------------------------------------
	
	// --------------------------------------------------
	// set the camera transform
	// --------------------------------------------------
	void GLCamera::setTransform( const CGMaths::CGVector3D & _eye, const CGMaths::CGVector3D & _target, const CGMaths::CGVector3D & _up )
	{	
		CGMaths::CGMatrix4x4SetTransform( m_transform, _eye, _target, _up );
	}
	
	// --------------------------------------------------
	// set the camera transform
	// --------------------------------------------------
	void GLCamera::setTransform( const CGMaths::CGQuaternion & _quat, const CGMaths::CGVector3D & _translation )
	{
		CGMaths::CGMatrix4x4SetTransform( m_transform, _quat, _translation );
	}
	
	/*
	CGMaths::CGVector2D	GLCamera::pointToScreen( CGMaths::CGVector3D _point )
	{
	}
	
	CGMaths::CGVector3D	GLCamera::pointToWorld( CGMaths::CGVector2D _point )
	{
	}
	*/
	
#pragma mark ---------------------------------------------------------
#pragma mark === End Public Functions  ===
#pragma mark ---------------------------------------------------------
};