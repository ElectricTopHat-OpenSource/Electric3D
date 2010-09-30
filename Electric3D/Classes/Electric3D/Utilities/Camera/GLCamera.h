//
//  GLCamera.h
//  Electric3D
//
//  Created by Robert McDowell on 28/09/2010.
//  Copyright 2010 Electric TopHat Ltd. All rights reserved.
//

#if !defined(__GLCamera_h__)
#define __GLCamera_h__

#import "CGMaths.h"

namespace GLCameras 
{
	
	class GLCamera
	{
#pragma mark ---------------------------------------------------------
#pragma mark Constructor / Destructor
#pragma mark ---------------------------------------------------------
	public: // Functions
		
		GLCamera();
		GLCamera( const GLCamera & _camera );
		virtual ~GLCamera();
		
#pragma mark ---------------------------------------------------------
#pragma mark End Constructor / Destructor
#pragma mark ---------------------------------------------------------

#pragma mark ---------------------------------------------------------
#pragma mark === Public Functions  ===
#pragma mark ---------------------------------------------------------
	public: // Functions
		
		inline float & fov()				{ return m_fov; };
		inline float fov() const			{ return m_fov; };
		inline void setFov( float _fov )	{ m_fov = _fov; };
		
		inline CGMaths::CGMatrix4x4 & transform()								{ return m_transform; };
		inline const CGMaths::CGMatrix4x4 & transform() const					{ return m_transform; };
		inline void setTransform( const CGMaths::CGMatrix4x4 & _transform )		{ m_transform = _transform; };
		
		void setTransform( const CGMaths::CGVector3D & _eye, const CGMaths::CGVector3D & _target, const CGMaths::CGVector3D & _up = CGMaths::CGVector3DYAxis );
		void setTransform( const CGMaths::CGQuaternion & _quat, const CGMaths::CGVector3D & _translation );
		
		

#pragma mark ---------------------------------------------------------
#pragma mark === End Public Functions  ===
#pragma mark ---------------------------------------------------------
		
#pragma mark ---------------------------------------------------------
#pragma mark === Private Data  ===
#pragma mark ---------------------------------------------------------
	private: // Data
		
		float					m_fov;
		CGMaths::CGMatrix4x4	m_transform;
		
#pragma mark ---------------------------------------------------------
#pragma mark === End Private Data  ===
#pragma mark ---------------------------------------------------------		
	};
	
};

#endif

