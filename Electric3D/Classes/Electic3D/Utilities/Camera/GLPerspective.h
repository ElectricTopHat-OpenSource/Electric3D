//
//  GLPerspective.h
//  Electric3D
//
//  Created by Robert McDowell on 29/09/2010.
//  Copyright 2010 Electric TopHat Ltd. All rights reserved.
//

#if !defined(__GLPerspective_h__)
#define __GLPerspective_h__

#import "CGMaths.h"

namespace GLCameras 
{
	
	class GLPerspective 
	{
#pragma mark ---------------------------------------------------------
#pragma mark Constructor / Destructor
#pragma mark ---------------------------------------------------------
	public: // Functions
		
		GLPerspective();
		virtual ~GLPerspective();
		
#pragma mark ---------------------------------------------------------
#pragma mark End Constructor / Destructor
#pragma mark ---------------------------------------------------------
		
#pragma mark ---------------------------------------------------------
#pragma mark === Public Functions  ===
#pragma mark ---------------------------------------------------------
	public: // Functions
		
		inline BOOL isDirty() const				{ return m_dirty; };
		inline float fov() const				{ return m_fov; };
		inline float aspect() const				{ return m_aspect; };
		inline float near() const				{ return m_near; };
		inline float far() const				{ return m_far;	};
		
		inline void setFov( float _fov )		{ m_fov = _fov; m_dirty = TRUE; };
		inline void setAspect( float _aspect )	{ m_aspect = _aspect; m_dirty = TRUE; };
		inline void setNear( float _near )		{ m_near = _near; m_dirty = TRUE; };
		inline void setFar( float _far )		{ m_far = _far; m_dirty = TRUE; };
		
		inline void resetFlags()				{ m_dirty = FALSE; };
		
		BOOL convertToMatrix( CGMaths::CGMatrix4x4 & _transform );	
		
#pragma mark ---------------------------------------------------------
#pragma mark === End Public Functions  ===
#pragma mark ---------------------------------------------------------
		
#pragma mark ---------------------------------------------------------
#pragma mark === Private Data  ===
#pragma mark ---------------------------------------------------------
	private: // Data
		
		float					m_fov;
		float					m_aspect;
		float					m_near;
		float					m_far;
		BOOL					m_dirty;
		
#pragma mark ---------------------------------------------------------
#pragma mark === End Private Data  ===
#pragma mark ---------------------------------------------------------
		
	};
};

#endif