/*
 *  GLColor.mm
 *  Electric3D
 *
 *  Created by robert on 22/04/2009.
 *  Copyright 2009 Electric TopHat. All rights reserved.
 *
 */

#import "GLColor.h"
#import <UIKit/UIKit.h>

namespace GLColors 
{

	#pragma mark ---------------------------------------------------------
	#pragma mark C Functions
	#pragma mark ---------------------------------------------------------

	BOOL getRGBAComponents( UIColor * _color, CGFloat * _red, CGFloat * _green, CGFloat * _blue, CGFloat * _alpha )
	{
		const CGFloat *components = CGColorGetComponents(_color.CGColor);
		
		CGFloat r,g,b,a = 1.0f;
		
		switch ( CGColorSpaceGetModel(CGColorGetColorSpace(_color.CGColor)) )
		{
			case kCGColorSpaceModelMonochrome:
				r = g = b = components[0];
				a = components[1];
				break;
			case kCGColorSpaceModelRGB:
				r = components[0];
				g = components[1];
				b = components[2];
				a = components[3];
				break;
			default:	// We don't know how to handle this model
				return NO;
		}
		
		if (_red) *_red = r;
		if (_green) *_green = g;
		if (_blue) *_blue = b;
		if (_alpha) *_alpha = a;
		
		return YES;
	}

	#pragma mark ---------------------------------------------------------
	#pragma mark End C Functions
	#pragma mark ---------------------------------------------------------

	#pragma mark ---------------------------------------------------------
	#pragma mark Constructor / Destructor
	#pragma mark ---------------------------------------------------------
	
	// --------------------------------------------------
	// Constructor
	// --------------------------------------------------
	GLColor::GLColor(float _red, float _green, float _blue, float _alpha)
	{
		m_red = _red;
		m_green = _green;
		m_blue = _blue;
		m_alpha = _alpha;
	}

	// --------------------------------------------------
	// Constructor
	// --------------------------------------------------
	GLColor::GLColor(UIColor * _color)
	{
		getRGBAComponents( _color, &m_red, &m_green, &m_blue, &m_alpha );
	}

	// --------------------------------------------------
	// Destructor
	// --------------------------------------------------
	GLColor::~GLColor()
	{
	}

	#pragma mark ---------------------------------------------------------
	#pragma mark End Constructor / Destructor
	#pragma mark ---------------------------------------------------------

	#pragma mark ---------------------------------------------------------
	#pragma mark Public Functions
	#pragma mark ---------------------------------------------------------

	// --------------------------------------------------
	// operator
	// --------------------------------------------------
	GLColor & GLColor::operator=(const UIColor * _color)
	{
		getRGBAComponents( _color, &m_red, &m_green, &m_blue, &m_alpha );
		return *this;
	}

	// --------------------------------------------------
	// Set the colors
	// --------------------------------------------------
	void GLColor::setColor(const UIColor * _color)
	{
		getRGBAComponents( _color, &m_red, &m_green, &m_blue, &m_alpha );
	}

	#pragma mark ---------------------------------------------------------
	#pragma mark End Public Functions
	#pragma mark ---------------------------------------------------------

};