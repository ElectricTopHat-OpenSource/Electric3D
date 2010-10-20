//
//  E3DColorComponent.h
//  Electric3D
//
//  Created by Robert McDowell on 19/10/2010.
//  Copyright 2010 Electric TopHat Ltd. All rights reserved.
//

#if !defined(__E3DColorComponent_h__)
#define __E3DColorComponent_h__

#import "GLColors.h"

namespace E3D  
{
	// Color Component 
	class E3DColorComponent 
	{
#pragma mark ---------------------------------------------------------
#pragma mark Constructor / Destructor
#pragma mark ---------------------------------------------------------
	public: // Functions
		
		E3DColorComponent(){};
		virtual ~E3DColorComponent(){};
		
#pragma mark ---------------------------------------------------------
#pragma mark End Constructor / Destructor
#pragma mark ---------------------------------------------------------
		
#pragma mark ---------------------------------------------------------
#pragma mark === Public Functions  ===
#pragma mark ---------------------------------------------------------
	public: // Functions
		
		inline BOOL	isWhite() 
		{
			if ( m_dirty )
			{
				m_dirty	= FALSE;
				m_white	= ( m_color == GLColors::GLColorWhite );
			}
			return m_white;
		};
		
		inline GLColors::GLColor & color()										{ return m_color; };
		inline const GLColors::GLColor & color() const							{ return m_color; };
		
		inline float red() const	{ return m_color.red(); };
		inline float green() const	{ return m_color.green(); };
		inline float blue() const	{ return m_color.blue(); };
		inline float alpha() const	{ return m_color.alpha(); };
		
		inline void setColor( const GLColors::GLColor & _color )							{ m_color.setColor(_color); };
		inline void setColor( const UIColor * _color )										{ m_color.setColor(_color); };
		inline void setColor( float _red, float _green, float _blue, float _alpha = 1.0f )	{ m_color.setColor(_red, _green, _blue, _alpha); };
		
#pragma mark ---------------------------------------------------------
#pragma mark === End Public Functions  ===
#pragma mark ---------------------------------------------------------
		
#pragma mark ---------------------------------------------------------
#pragma mark === Protected Data  ===
#pragma mark ---------------------------------------------------------
	protected: // Data
		
		GLColors::GLColor	m_color;
		BOOL				m_dirty;
		BOOL				m_white;
		
#pragma mark ---------------------------------------------------------
#pragma mark === End Protected Data  ===
#pragma mark ---------------------------------------------------------
	};
	
};

#endif