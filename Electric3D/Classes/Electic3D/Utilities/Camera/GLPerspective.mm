//
//  GLPerspective.m
//  Electric3D
//
//  Created by Robert McDowell on 29/09/2010.
//  Copyright 2010 Electric TopHat Ltd. All rights reserved.
//

#import "GLPerspective.h"

namespace GLCameras 
{
	
#pragma mark ---------------------------------------------------------
#pragma mark Constructor / Destructor
#pragma mark ---------------------------------------------------------
	
	// --------------------------------------------------
	// Constructor
	// --------------------------------------------------
	GLPerspective::GLPerspective()
	: m_fov		(45.0f)
	, m_aspect	(1.33333f)
	, m_near	(1.0f)
	, m_far		(1000.0f)
	, m_dirty	(FALSE)
	{
	}
	
	// --------------------------------------------------
	// Destructor
	// --------------------------------------------------
	GLPerspective::~GLPerspective()
	{
	}
	
#pragma mark ---------------------------------------------------------
#pragma mark End Constructor / Destructor
#pragma mark ---------------------------------------------------------
	
#pragma mark ---------------------------------------------------------
#pragma mark === Public Functions  ===
#pragma mark ---------------------------------------------------------
	
	// --------------------------------------------------
	// create the persepctive transform
	// --------------------------------------------------
	BOOL GLPerspective::convertToMatrix( CGMaths::CGMatrix4x4 & _matrix )
	{		
		float deltaz = m_far - m_near;
		float radians = CGMaths::Degrees2Radians( m_fov / 2.0f );
		float sine = sinf(radians);
		if ( (deltaz != 0) && (sine != 0) && (m_aspect != 0) ) 
		{
			_matrix = CGMaths::CGMatrix4x4Identity;
			
			float cotangent = cosf(radians) / sine;
			_matrix.m[0]  = cotangent / m_aspect;
			_matrix.m[5]  = cotangent;
			_matrix.m[10] = -(m_far + m_near) / deltaz;
			_matrix.m[11] = -1;
			_matrix.m[14] = -2 * m_near * m_far / deltaz;
			_matrix.m[15] = 0;
			
			return TRUE;
		}
		
		return FALSE;
	}
	
#pragma mark ---------------------------------------------------------
#pragma mark === End Public Functions  ===
#pragma mark ---------------------------------------------------------
	
};