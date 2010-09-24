//
//  GLUISprite.m
//  Electric3D
//
//  Created by Robert McDowell on 21/09/2010.
//  Copyright 2010 Electric TopHat Ltd. All rights reserved.
//

#import "GLUISprite.h"


namespace GLObjects 
{	
#pragma mark ---------------------------------------------------------
#pragma mark Constructor / Destructor
#pragma mark ---------------------------------------------------------
	
	// --------------------------------------------------
	// Constructor
	// --------------------------------------------------
	GLUISprite::GLUISprite( const GLSprites::GLSprite * _sprite, CGPoint _center, CGSize _size )
	{
		m_sprite = _sprite;
		m_center = _center;
		m_rotation = 0.0f;
		m_frame = 0;
		m_scale = CGSizeMake(1.0f, 1.0f);
		m_textureCoordinatesLayout = eGLUICoordinatesLayout_LeftToRight_TopToBottom;
		
		if ( CGSizeEqualToSize(_size, CGSizeZero) )
		{
			if ( _sprite )
			{
				m_size = _sprite->frameSize(0);
			}
			else 
			{
				m_size = CGSizeMake(10.0f,10.0f);
			}
		}
		else
		{
			m_size = _size;
		}
	}
	
	// --------------------------------------------------
	// Destructor
	// --------------------------------------------------
	GLUISprite::~GLUISprite()
	{
	}
	
#pragma mark ---------------------------------------------------------
#pragma mark End Constructor / Destructor
#pragma mark ---------------------------------------------------------
	
#pragma mark ---------------------------------------------------------
#pragma mark Public Functions
#pragma mark ---------------------------------------------------------
	
	// --------------------------------------------------
	// set the current frame number
	// --------------------------------------------------
	void GLUISprite::setFrame(NSUInteger _frame) 
	{ 
		m_frame = CGMaths::fClamp(_frame, 0, m_sprite->numframes() ); 
	}
	
	// --------------------------------------------------
	// set the rect
	// --------------------------------------------------
	void GLUISprite::setRect( CGRect _rect )
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
