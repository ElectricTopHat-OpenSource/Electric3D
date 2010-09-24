//
//  GLUIImage.h
//  Electric3D
//
//  Created by Robert McDowell on 21/09/2010.
//  Copyright 2010 Electric TopHat Ltd. All rights reserved.
//

#if !defined(__GLUIImage_h__)
#define __GLUIImage_h__

#import <UIKit/UIKit.h>
#import "GLUIObject.h"
#import "CGMaths.h"
#import "Colors.h"

namespace GLTextures { class GLTexture; };

namespace GLObjects
{
	// -------------------------------------------------------------------
	// GLImage is a simple image render object, 
	// it does nothing fancy but will fill the object
	// the desired texture.
	// -------------------------------------------------------------------
	class GLUIImage : public GLUIObject
	{
	#pragma mark ---------------------------------------------------------
	#pragma mark Constructor / Destructor
	#pragma mark ---------------------------------------------------------
	public: // Functions
		
		// --------------------------------------------------
		// Constructor
		// --------------------------------------------------
		GLUIImage( const GLTextures::GLTexture * _texture = nil, CGPoint _center = CGPointZero, CGSize _size = CGSizeZero );
		
		// --------------------------------------------------
		// Destructor
		// --------------------------------------------------
		~GLUIImage();
		
	#pragma mark ---------------------------------------------------------
	#pragma mark End Constructor / Destructor
	#pragma mark ---------------------------------------------------------
		
	#pragma mark ---------------------------------------------------------
	#pragma mark Public Functions
	#pragma mark ---------------------------------------------------------
	public:	// Functions
		
		inline eGLUITypes type() const { return eGLUIImage; };
		
		// set the texture object
		inline void setTexture(const GLTextures::GLTexture * _texture) { m_texture = _texture; };
		// access the texture object
		inline const GLTextures::GLTexture * texture() const { return m_texture; };
		
		// access the texture coordinate layout
		inline eGLUICoordinatesLayout coordinatesLayout() const { return m_coordinatesLayout; };
		// set the texture coordinate layout
		inline void setCoordinatesLayout( eGLUICoordinatesLayout _layout ) { m_coordinatesLayout = _layout; };
		
		// access the image alpha value
		inline float alpha() const { return m_color.alpha(); };
		// set the image alpha value
		inline void setAlpha(float _alpha) { m_color.setAlpha(_alpha); };
		
		// access the color variable
		inline const Colors::Color & color() const { return m_color; };
		// set the color or the font
		inline void setColor(float _red, float _green, float _blue, float _alpha=1.0f) { m_color.setColor(_red,_green,_blue,_alpha); };
		inline void setColor(const Colors::Color & _color) { m_color.setColor(_color); };
		inline void setColor(const UIColor * _color) { m_color.setColor(_color); };
		
		// access the image rotation in degrees
		inline float rotation() const { return m_rotation; };
		// set the rotation of the image in degrees
		inline void setRotation(float _rotation) { m_rotation = _rotation; };
		
		// access the image size in pixels
		inline const CGSize & size() const { return m_size; };
		// set the size of the image in pixels
		inline void setSize(CGSize _size) { m_size = _size; };
		inline void setSize(float _size)  { m_size.width = _size; m_size.height = _size; };
		inline void setSize(float _width, float _height) { m_size.width = _width; m_size.height = _height; };
		
		// access the image scale
		inline const CGSize & scale() const { return m_scale; };
		// set the image scale
		inline void setScale(CGSize _scale) { m_scale = _scale; };
		inline void setScale(float _width, float _height) { m_scale.width = _width; m_scale.height = _height; };
		inline void setScale(float _scale) { m_scale.width = _scale; m_scale.height = _scale; };
		
		// access the center point
		inline const CGPoint & center() const { return m_center; };
		// set the center point
		inline void setCenter(CGPoint _center) { m_center = _center; };
		inline void setCenter(float _x, float _y) { m_center.x = _x; m_center.y = _y; };
		
		// access the objects frame
		inline const CGRect rect() const { return CGRectMake(m_center.x - ((m_size.width*m_scale.width)*0.5f), m_center.y - ((m_size.height*m_scale.height)*0.5f), m_size.width*m_scale.width, m_size.height*m_scale.height); };
		void setRect( CGRect _rect );
		
	#pragma mark ---------------------------------------------------------
	#pragma mark End Public Functions
	#pragma mark ---------------------------------------------------------
		
	#pragma mark ---------------------------------------------------------
	#pragma mark Private Functions
	#pragma mark ---------------------------------------------------------
	private: // Functions
		
	#pragma mark ---------------------------------------------------------
	#pragma mark End Private Functions
	#pragma mark ---------------------------------------------------------
		
	#pragma mark ---------------------------------------------------------
	#pragma mark Private Data
	#pragma mark ---------------------------------------------------------
	private: // Data
		
		const GLTextures::GLTexture * m_texture;
		
		eGLUICoordinatesLayout	m_coordinatesLayout;
		
		Colors::Color	m_color;
		
		float			m_rotation;
		CGSize			m_size;
		CGSize			m_scale;
		CGPoint			m_center;
		
	#pragma mark ---------------------------------------------------------
	#pragma mark End Private Data
	#pragma mark ---------------------------------------------------------
	};
	
};

#endif
