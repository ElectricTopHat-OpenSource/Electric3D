/*
 *  Color.h
 *  Electric3D
 *
 *  Created by robert on 22/04/2009.
 *  Copyright 2009 Electric TopHat. All rights reserved.
 *
 */

#if !defined(__GLColor_h__)
#define __GLColor_h__

#import <UIKit/UIKit.h>

namespace Colors 
{
	
	class Color
	{
	#pragma mark ---------------------------------------------------------
	#pragma mark Constructor / Destructor
	#pragma mark ---------------------------------------------------------
	public: // Functions
		
		// --------------------------------------------------
		// Constructor
		// --------------------------------------------------
		Color(float _red=1.0f, float _green=1.0f, float _blue=1.0f, float _alpha=1.0f);
		Color(UIColor * _color);
		
		// --------------------------------------------------
		// Destructor
		// --------------------------------------------------
		~Color();
		
	#pragma mark ---------------------------------------------------------
	#pragma mark End Constructor / Destructor
	#pragma mark ---------------------------------------------------------
		
	#pragma mark ---------------------------------------------------------
	#pragma mark Operator Functions
	#pragma mark ---------------------------------------------------------
	public:	// Functions
		
		// --------------------------------
		// operators Overloading
		// --------------------------------
		Color & operator=(const Color& _color)
		{
			m_red = _color.m_red;
			m_green = _color.m_green;
			m_blue = _color.m_blue;
			m_alpha = _color.m_alpha;
			return *this;
		}
		
		Color & operator+(const Color& _color)
		{
			m_red += _color.m_red;
			m_green += _color.m_green;
			m_blue += _color.m_blue;
			m_alpha += _color.m_alpha;
			return *this;		
		}
		// --------------------------------
		
		Color & operator=(const UIColor * _color);
		
	#pragma mark ---------------------------------------------------------
	#pragma mark End Operator Functions
	#pragma mark ---------------------------------------------------------
		
	#pragma mark ---------------------------------------------------------
	#pragma mark Public Functions
	#pragma mark ---------------------------------------------------------
	public:	// Functions
		
		inline float & getRed() 	{ return m_red; };
		inline float & getGreen() 	{ return m_green; };
		inline float & getBlue()	{ return m_blue; };
		inline float & getAlpha()	{ return m_alpha; };
		
		inline float red() const	{ return m_red; };
		inline float green() const	{ return m_green; };
		inline float blue() const	{ return m_blue; };
		inline float alpha() const	{ return m_alpha; };
		
		inline void setRed(float _red)		{ m_red = _red; };
		inline void setGreen(float _green)	{ m_green = _green; };
		inline void setBlue(float _blue)	{ m_blue = _blue; };
		inline void setAlpha(float _alpha)	{ m_alpha = _alpha; };
		
		inline void setColor(float _red, float _green, float _blue, float _alpha=1.0f) { m_red = _red; m_green = _green; m_blue = _blue; m_alpha = _alpha; };
		inline void setColor(const Color & _color) { m_red = _color.m_red; m_green = _color.m_green; m_blue = _color.m_blue; m_alpha = _color.m_alpha; };
		
		// set the color from a UIColor Object
		void setColor(const UIColor * _color);
		
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
		
		float m_red;
		float m_green;
		float m_blue;
		float m_alpha;
		
	#pragma mark ---------------------------------------------------------
	#pragma mark End Private Data
	#pragma mark ---------------------------------------------------------
	};

};

#endif
