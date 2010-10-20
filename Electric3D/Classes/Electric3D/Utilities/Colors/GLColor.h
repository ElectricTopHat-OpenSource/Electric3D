/*
 *  GLColor.h
 *  Electric3D
 *
 *  Created by robert on 22/04/2009.
 *  Copyright 2009 Electric TopHat. All rights reserved.
 *
 */

#if !defined(__GLColor_h__)
#define __GLColor_h__

@class UIColor;

namespace GLColors 
{
	
	class GLColor
	{
	#pragma mark ---------------------------------------------------------
	#pragma mark Constructor / Destructor
	#pragma mark ---------------------------------------------------------
	public: // Functions
		
		// --------------------------------------------------
		// Constructor
		// --------------------------------------------------
		GLColor(float _red=1.0f, float _green=1.0f, float _blue=1.0f, float _alpha=1.0f);
		GLColor(UIColor * _color);
		
		// --------------------------------------------------
		// Destructor
		// --------------------------------------------------
		virtual ~GLColor();
		
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
		GLColor & operator=(const UIColor * _color);
		
		inline GLColor & operator=(const GLColor& _color)
		{
			m_red = _color.m_red;
			m_green = _color.m_green;
			m_blue = _color.m_blue;
			m_alpha = _color.m_alpha;
			return *this;
		}
		
		inline GLColor operator+(const GLColor& _color) const
		{
			return GLColor( m_red   + _color.m_red, 
						    m_green + _color.m_green, 
						    m_blue  + _color.m_blue, 
						    m_alpha + _color.m_alpha );
		}
		
		inline GLColor operator-(const GLColor& _color) const
		{
			return GLColor( m_red   - _color.m_red, 
						    m_green - _color.m_green, 
						    m_blue  - _color.m_blue, 
						    m_alpha - _color.m_alpha );
		}
		
		inline GLColor operator*(const GLColor& _color) const
		{
			return GLColor( m_red   * _color.m_red, 
						    m_green * _color.m_green, 
						    m_blue  * _color.m_blue, 
						    m_alpha * _color.m_alpha );		
		}
		
		inline GLColor operator/(const GLColor& _color) const
		{
			return GLColor( m_red   / _color.m_red, 
						    m_green / _color.m_green, 
						    m_blue  / _color.m_blue, 
						    m_alpha / _color.m_alpha );		
		}
		
        inline GLColor & operator+=( const GLColor& _color )
        {
            m_red	+= _color.m_red;
			m_green += _color.m_green;
			m_blue	+= _color.m_blue;
			m_alpha += _color.m_alpha;
			return *this;		
        }
		
		inline GLColor & operator-=( const GLColor& _color )
        {
            m_red	-= _color.m_red;
			m_green -= _color.m_green;
			m_blue	-= _color.m_blue;
			m_alpha -= _color.m_alpha;
			return *this;		
        }
		
		inline GLColor & operator*=( const GLColor& _color )
        {
            m_red	*= _color.m_red;
			m_green *= _color.m_green;
			m_blue	*= _color.m_blue;
			m_alpha *= _color.m_alpha;
			return *this;		
        }
		
		inline GLColor & operator/=( const GLColor& _color )
        {
            m_red	/= _color.m_red;
			m_green /= _color.m_green;
			m_blue	/= _color.m_blue;
			m_alpha /= _color.m_alpha;
			return *this;		
        }
		// --------------------------------
		
		// --------------------------------
		inline float & operator[](NSUInteger i)
		{ 
			return  colors[i];
		}
		
		inline float  operator[](NSUInteger i) const
		{ 
			return  (i < 4) ? colors[i] : 0.0f;
		}
		// --------------------------------
		
		// --------------------------------
		inline BOOL operator==( const GLColor& _color )
        {
           return ( fabs(m_red -	_color.m_red)	< 0.001f ) &&
				  ( fabs(m_green -	_color.m_green) < 0.001f ) &&
				  ( fabs(m_blue -	_color.m_blue)	< 0.001f ) &&
				  ( fabs(m_alpha -	_color.m_alpha) < 0.001f );
        }
		// --------------------------------
		
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
		inline void setColor(const GLColor & _color) { m_red = _color.m_red; m_green = _color.m_green; m_blue = _color.m_blue; m_alpha = _color.m_alpha; };
		
		// set the color from a UIColor Object
		void setColor(const UIColor * _color);
		
		inline const float * getColors() const { return &colors[0]; };
		
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
		
		union 
		{
			float colors[4];
			struct 
			{
				float m_red;
				float m_green;
				float m_blue;
				float m_alpha;
			};
		};
	#pragma mark ---------------------------------------------------------
	#pragma mark End Private Data
	#pragma mark ---------------------------------------------------------
	};

};

#endif
