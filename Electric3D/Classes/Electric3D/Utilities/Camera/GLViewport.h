//
//  GLViewport.h
//  Electric3D
//
//  Created by Robert McDowell on 12/10/2010.
//  Copyright 2010 Electric TopHat Ltd. All rights reserved.
//

#if !defined(__GLViewport_h__)
#define __GLViewport_h__

namespace GLCameras 
{
	
	class GLViewport
	{
#pragma mark ---------------------------------------------------------
#pragma mark Constructor / Destructor
#pragma mark ---------------------------------------------------------
	public: // Functions
		
		GLViewport() { m_x=0; m_y=0; m_width=640.0f; m_height=320.0f; };
		virtual ~GLViewport(){};
		
#pragma mark ---------------------------------------------------------
#pragma mark End Constructor / Destructor
#pragma mark ---------------------------------------------------------
		
#pragma mark ---------------------------------------------------------
#pragma mark === Public Functions  ===
#pragma mark ---------------------------------------------------------
	public: // Functions
		
		inline BOOL isDirty() const				{ return m_dirty; };
		inline float x() const					{ return m_x; };
		inline float y() const					{ return m_y; };
		inline float width() const				{ return m_width; };
		inline float height() const				{ return m_height; };
		
		inline void set( float _x, float _y, float _width, float _height ) 
		{
			m_x = _x;
			m_y = _y;
			m_width = _width;
			m_height = _height; 
			m_dirty = TRUE;
		}
		inline void setX( float _x  )			{ m_x = _x; m_dirty = TRUE; };
		inline void setY( float _y )			{ m_y = _y; m_dirty = TRUE; };
		inline void setWidth( float _width )	{ m_width = _width; m_dirty = TRUE; };
		inline void setHeight( float _height )	{ m_height = _height; m_dirty = TRUE; };
		
		inline void resetFlags()				{ m_dirty = FALSE; };
		
#pragma mark ---------------------------------------------------------
#pragma mark === End Public Functions  ===
#pragma mark ---------------------------------------------------------
		
#pragma mark ---------------------------------------------------------
#pragma mark === Private Data  ===
#pragma mark ---------------------------------------------------------
	private: // Data
		
		float					m_x;
		float					m_y;
		float					m_width;
		float					m_height;
		BOOL					m_dirty;
		
#pragma mark ---------------------------------------------------------
#pragma mark === End Private Data  ===
#pragma mark ---------------------------------------------------------
	};
	
};

#endif
