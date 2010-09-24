//
//  GLUILabel.h
//  Electric3D
//
//  Created by Robert McDowell on 21/09/2010.
//  Copyright 2010 Electric TopHat Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <OpenGLES/ES2/gl.h>
#import "GLUIObject.h"
#import "CGMaths.h"
#import "Color.h"


namespace GLObjects
{
	typedef enum
	{
		UITextVerticalAlignmentMiddle = 0,
		UITextVerticalAlignmentTop,
		UITextVerticalAlignmentBottom,
		
	} UITextVerticalAlignment;
	
	// -------------------------------------------------------------------
	//
	// -------------------------------------------------------------------
	class GLUILabel : public GLUIObject
	{		
#pragma mark ---------------------------------------------------------
#pragma mark Constructor / Destructor
#pragma mark ---------------------------------------------------------
	public: // Functions
		
		// --------------------------------------------------
		// Constructor
		// --------------------------------------------------
		GLUILabel( NSString * _text=@"", Boolean _staticText=false, CGSize _size = CGSizeMake(64.0f, 32.0f), UITextAlignment _alignment = UITextAlignmentCenter, float _fontSize = 14.0f, NSString * _fontName = @"Arial", CGPoint _center = CGPointMake(20.0f,455.0f) );
		
		// --------------------------------------------------
		// Destructor
		// --------------------------------------------------
		~GLUILabel();
		
#pragma mark ---------------------------------------------------------
#pragma mark End Constructor / Destructor
#pragma mark ---------------------------------------------------------
		
#pragma mark ---------------------------------------------------------
#pragma mark Public Functions
#pragma mark ---------------------------------------------------------
	public:	// Functions
		
		inline eGLUITypes type() const { return eGLUILabel; };
		
		// access the text string
		inline NSString * text() const { return m_text; };
		// set the text string
		inline void setText(NSString * _text) { m_text = [_text copy]; m_dirty = true; };
		
		// access the font size
		inline float fontSize() const { return m_fontSize; };
		// set the font size
		inline void setFontSize( float _size ) { m_dirty = (_size != m_fontSize); m_fontSize = _size; };
		
		// access the font name
		inline NSString * fontName() const { return m_fontName; };
		// set the font name
		inline void setFontName( NSString * _fontName ) { m_fontName = [_fontName copy];  m_dirty = true; };
		
		// access the text alignment
		inline UITextAlignment alignment() const { return m_fontAlignment; };
		// set the text alignment
		inline void setAlignment( UITextAlignment _alignment ) { m_fontAlignment = _alignment; m_dirty = true; };
		
		// access the text vertical alignment
		inline UITextVerticalAlignment verticalalignment() const { return m_fontVerticalAlignment; };
		// set the text vertical alignment
		inline void setVerticalAlignment( UITextVerticalAlignment _alignment ) { m_fontVerticalAlignment = _alignment; m_dirty = true; };
		
		// access the variable to see if the shadow is enabled
		inline Boolean shadow() const { return m_shadow; };
		// enable / disable the shadow
		inline void setShadow( Boolean _enabled ) { m_shadow = _enabled; };
		
		// access the text alpha value
		inline float alpha() const { return m_alpha; };
		// set the text alpha value
		inline void setAlpha(float _alpha) { m_alpha = _alpha; };
		
		// access the image rotation in degrees
		inline float rotation() const { return m_rotation; };
		// set the rotation of the image in degrees
		inline void setRotation(float _rotation) { m_rotation = _rotation; };
		
		// access the image size in pixels
		inline const CGSize & size() const { return m_size; };
		inline float width() const { return m_size.width; };
		inline float height() const { return m_size.height; };
		
		// set the size of the image in pixels
		inline void setSize(CGSize _size) { m_size = _size; m_dirtySize = true; };
		inline void setSize(float _size)  { m_size.width = _size; m_size.height = _size; m_dirtySize = true; };
		inline void setSize(float _width, float _height) { m_size.width = _width; m_size.height = _height;  m_dirtySize = true; };
		
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
		
		// access the shadow offset
		inline const CGPoint & shadowOffset() const { return m_fontShadowOffSet; };
		// set the shadow offset value
		inline void setShadowOffset(CGPoint _offset) { m_fontShadowOffSet = _offset; };
		inline void setShadowOffset(CGSize  _offset) { m_fontShadowOffSet.x = _offset.width; m_fontShadowOffSet.y = _offset.height; };
		inline void setShadowOffset(float _x, float _y) { m_fontShadowOffSet.x = _x; m_fontShadowOffSet.y = _y; };
		
		// access the color variable
		inline const Colors::Color & color() const { return m_fontColor; };
		// set the color or the font
		inline void setColor(float _red, float _green, float _blue, float _alpha=1.0f) { m_fontColor.setColor(_red,_green,_blue,_alpha); };
		inline void setColor(const Colors::Color & _color) { m_fontColor.setColor(_color); };
		inline void setColor(const UIColor * _color) { m_fontColor.setColor(_color); };
		
		// access the shadow color variable
		inline const Colors::Color & shadowColor() const { return m_fontShadowColor; };
		// set the color of the shadow
		inline void setShadowColor(float _red, float _green, float _blue, float _alpha=1.0f) { m_fontShadowColor.setColor(_red,_green,_blue,_alpha); };
		inline void setShadowColor(const Colors::Color & _color) { m_fontShadowColor.setColor(_color); };
		inline void setShadowColor(const UIColor * _color) { m_fontShadowColor.setColor(_color); };
		
		// access the texture bind id
		inline GLuint bindID() const { return m_bindID; };
		
		// update the render bimp if needed
		Boolean update(); 
		
#pragma mark ---------------------------------------------------------
#pragma mark End Public Functions
#pragma mark ---------------------------------------------------------
		
#pragma mark ---------------------------------------------------------
#pragma mark Private Functions
#pragma mark ---------------------------------------------------------
	private: // Functions
		
		// update the texture size
		void updateBuffers();
		
		NSInteger nearestpower2(NSInteger v);
		
		// render the string to the
		// texture buffer.
		void renderStringToTexture();
		
		// release the texture data
		void releaseTexture();
		
		void createBuffers();
		
		void releaseBuffers();
		
		inline NSInteger frameWidth() const { return m_fontFrameWidth; };
		inline NSInteger frameHeight() const { return m_fontFrameHeight; };
		inline NSInteger textureWidth() const { return m_fontTextureWidth; };
		inline NSInteger textureHeight() const { return m_fontTextureHeight; };
		
#pragma mark ---------------------------------------------------------
#pragma mark End Private Functions
#pragma mark ---------------------------------------------------------
		
#pragma mark ---------------------------------------------------------
#pragma mark Private Data
#pragma mark ---------------------------------------------------------
	private: // Data
		
		NSString *				m_text;
		
		GLuint					m_bindID; // Texture Bind ID
		
		void *					m_data;
		
		NSString *				m_fontName;
		float					m_fontSize;
		UITextAlignment			m_fontAlignment;
		UITextVerticalAlignment m_fontVerticalAlignment;
		NSInteger				m_fontFrameWidth;
		NSInteger				m_fontFrameHeight;
		NSInteger				m_fontTextureWidth;
		NSInteger				m_fontTextureHeight;
		Colors::Color			m_fontColor;
		
		CGPoint					m_fontShadowOffSet;
		Colors::Color			m_fontShadowColor;
		
		float					m_alpha;
		
		float					m_rotation;
		CGSize					m_size;
		CGSize					m_scale;
		CGPoint					m_center;
		
		Boolean					m_shadow;
		Boolean					m_static;
		Boolean					m_dirty;
		Boolean					m_dirtySize;
		
#pragma mark ---------------------------------------------------------
#pragma mark End Private Data
#pragma mark ---------------------------------------------------------
	};
};
