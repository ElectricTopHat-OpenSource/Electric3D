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
		CGMaths::CGVector3D at = CGMaths::CGVector3DMake( _target.x - _eye.x, _target.y - _eye.y, _target.z - _eye.z);
		CGMaths::CGVector3DNormalise( at );
		
		CGMaths::CGVector3D right = CGMaths::CGVector3DCrossProduct( at, _up );
		CGMaths::CGVector3DNormalise( right );
		
		CGMaths::CGVector3D up = CGMaths::CGVector3DCrossProduct( right, at );
		//CGMaths::CGVector3DNormalise( up );
		
		// set the camera rotation
		m_transform.m[0]  = right.x;	m_transform.m[1]  = up.x;	m_transform.m[2]  = at.x;	m_transform.m[3]  = 0.0f;
		m_transform.m[4]  = right.y;	m_transform.m[5]  = up.y;	m_transform.m[6]  = at.y;	m_transform.m[7]  = 0.0f;
		m_transform.m[8]  = right.z;	m_transform.m[9]  = up.z;	m_transform.m[10] = at.z;	m_transform.m[11] = 0.0f;

		
		// Set the translation
		m_transform.m[12] = _eye.x; 
		m_transform.m[13] = _eye.y; 
		m_transform.m[14] = _eye.z; 
		m_transform.m[15] = 1.0f;
	}
	
	// --------------------------------------------------
	// set the camera transform
	// --------------------------------------------------
	void GLCamera::setTransform( const CGMaths::CGQuaternion & _quat, const CGMaths::CGVector3D & _translation )
	{
		CGMaths::CGMatrix4x4SetRotation( m_transform, _quat );
		CGMaths::CGMatrix4x4SetTranslation( m_transform, _translation );
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