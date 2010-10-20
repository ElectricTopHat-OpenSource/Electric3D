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
		
		inline CGMaths::CGVector3D position() const								{ return CGMaths::CGMatrix4x4GetTranslation( m_transform ); };
		inline void setPosition( const CGMaths::CGVector3D & _pos )				{ CGMaths::CGMatrix4x4SetTranslation( m_transform, _pos ); };
		
		inline CGMaths::CGVector3D at() const									{ return CGMaths::CGMatrix4x4GetAt( m_transform ); };
		inline void setAt( const CGMaths::CGVector3D & _at )					{ CGMaths::CGMatrix4x4SetAt( m_transform, _at ); };
		
		inline CGMaths::CGVector3D up() const									{ return CGMaths::CGMatrix4x4GetUp( m_transform ); };
		inline void setUp( const CGMaths::CGVector3D & _up )					{ CGMaths::CGMatrix4x4SetUp( m_transform, _up ); };
		
		inline CGMaths::CGVector3D right() const								{ return CGMaths::CGMatrix4x4GetRight( m_transform ); };
		inline void setRight( const CGMaths::CGVector3D & _right )				{ CGMaths::CGMatrix4x4SetRight( m_transform, _right ); };
		
		inline CGMaths::CGMatrix4x4 & transform()								{ return m_transform; };
		inline const CGMaths::CGMatrix4x4 & transform() const					{ return m_transform; };
		inline void setTransform( const CGMaths::CGMatrix4x4 & _transform )		{ m_transform = _transform; };
		
		void setTransform( const CGMaths::CGVector3D & _eye, const CGMaths::CGVector3D & _target, const CGMaths::CGVector3D & _up = CGMaths::CGVector3DYAxis );
		void setTransform( const CGMaths::CGQuaternion & _quat, const CGMaths::CGVector3D & _translation );

		inline float fov() const												{ return m_fov; };
		inline float near() const												{ return m_near; };
		inline float far() const												{ return m_far; };
		
		inline void setFov( float _fov )										{ m_fov  = _fov; };
		inline void setNear( float _near )										{ m_near = _near; };
		inline void setFar( float _far )										{ m_far  = _far; };
		
#pragma mark ---------------------------------------------------------
#pragma mark === End Public Functions  ===
#pragma mark ---------------------------------------------------------
		
#pragma mark ---------------------------------------------------------
#pragma mark === Private Data  ===
#pragma mark ---------------------------------------------------------
	private: // Data
		
		float					m_fov;
		float					m_near;
		float					m_far;
		CGMaths::CGMatrix4x4	m_transform;
		
		
#pragma mark ---------------------------------------------------------
#pragma mark === End Private Data  ===
#pragma mark ---------------------------------------------------------
	};
	
};

#endif

