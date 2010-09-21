//
//  GLUIImage.mm
//  Electric3D
//
//  Created by Robert McDowell on 21/09/2010.
//  Copyright 2010 Electric TopHat Ltd. All rights reserved.
//

#import "GLUIImage.h"
#import "GLTexture.h"

namespace UI
{

	#pragma mark ---------------------------------------------------------
	#pragma mark Constructor / Destructor
	#pragma mark ---------------------------------------------------------

	// --------------------------------------------------
	// Constructor
	// --------------------------------------------------
	GLUIImage::GLUIImage( const GLTextures::GLTexture * _texture, CGPoint _center, CGSize _size )
	: GLUIObject( eGLObjectImage )
	{
		m_texture = _texture;
		m_center = _center;
		m_rotation = 0.0f;
		m_scale = CGSizeMake(1.0f, 1.0f);
		m_coordinatesLayout = eGLUICoordinatesLayout_LeftToRight_TopToBottom;
		
		if (( CGSizeEqualToSize(_size, CGSizeZero) ) && 
			( _texture != nil ))
		{
			m_size = _texture->size();
		}
		else
		{
			m_size = _size;
		}
	}

	// --------------------------------------------------
	// Destructor
	// --------------------------------------------------
	GLUIImage::~GLUIImage()
	{
	}

	#pragma mark ---------------------------------------------------------
	#pragma mark End Constructor / Destructor
	#pragma mark ---------------------------------------------------------

	#pragma mark ---------------------------------------------------------
	#pragma mark Public Functions
	#pragma mark ---------------------------------------------------------

	// --------------------------------------------------
	// set the rect
	// --------------------------------------------------
	void GLUIImage::setRect( CGRect _rect )
	{
		m_scale	= CGSizeMake(1.0f, 1.0f);
		m_size	= _rect.size;
		
		m_center = _rect.origin;
		m_center.x += m_size.width * 0.5f;
		m_center.y += m_size.height * 0.5f;
	}

	#pragma mark ---------------------------------------------------------
	#pragma mark End Public Functions
	#pragma mark ---------------------------------------------------------

};