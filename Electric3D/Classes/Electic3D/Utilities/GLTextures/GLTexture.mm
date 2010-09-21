/*
 *  Texture.mm
 *  Electric3D
 *
 *  Created by robert on 15/04/2009.
 *  Copyright 2009 Electric TopHat. All rights reserved.
 *
 */

#include "GLTexture.h"

namespace GLTextures 
{
	#pragma mark ---------------------------------------------------------
	#pragma mark Constructor / Destructor
	#pragma mark ---------------------------------------------------------

	// --------------------------------------------------
	// Constructor
	// --------------------------------------------------
	GLTexture::GLTexture(const NSString * _name, GLint _bindID, CGSize _size)
	{	
		m_name				= _name;
		m_bindID			= _bindID;
		m_size				= _size;
		m_referenceCount	= 1;
	}

	// --------------------------------------------------
	// Destructor
	// --------------------------------------------------
	GLTexture::~GLTexture()
	{
	}

	#pragma mark ---------------------------------------------------------
	#pragma mark End Constructor / Destructor
	#pragma mark ---------------------------------------------------------
};