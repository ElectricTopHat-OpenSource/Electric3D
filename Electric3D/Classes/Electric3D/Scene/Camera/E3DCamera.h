//
//  E3DCamera.h
//  Electric3D
//
//  Created by Robert McDowell on 19/10/2010.
//  Copyright 2010 Electric TopHat Ltd. All rights reserved.
//

#if !defined(__E3DCamera_h__)
#define __E3DCamera_h__

#import "CGMaths.h"

namespace E3D  
{	
	class E3DCamera  
	{
#pragma mark ---------------------------------------------------------
#pragma mark Constructor / Destructor
#pragma mark ---------------------------------------------------------
	public: // Functions
		
		E3DCamera( NSString * _name = nil );
		virtual ~E3DCamera();
		
#pragma mark ---------------------------------------------------------
#pragma mark End Constructor / Destructor
#pragma mark ---------------------------------------------------------
		
#pragma mark ---------------------------------------------------------
#pragma mark === Public Functions  ===
#pragma mark ---------------------------------------------------------
	public: // Functions
		
		inline float fov() const												{ return m_fov; };
		inline void setFov( float _fov )										{ m_fov  = _fov; };
		
		inline float near() const												{ return m_near; };
		inline void setNear( float _near )										{ m_near = _near; };
		
		inline float far() const												{ return m_far; };
		inline void setFar( float _far )										{ m_far  = _far; };
		
		inline CGRect viewport() const											{ return m_viewport; };
		inline void setViewport( CGRect _viewport )								{ m_viewport = _viewport; };
		
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
		inline void setTransform( const CGMaths::CGVector3D & _eye, const CGMaths::CGVector3D & _target, const CGMaths::CGVector3D & _up = CGMaths::CGVector3DYAxis ) { CGMaths::CGMatrix4x4SetTransform( m_transform, _eye, _target, _up ); };
		inline void setTransform( const CGMaths::CGQuaternion & _quat, const CGMaths::CGVector3D & _translation ) { CGMaths::CGMatrix4x4SetTransform( m_transform, _quat, _translation ); };
		
		CGMaths::CGMatrix4x4	projectionMatrix();
		CGMaths::CGMatrix4x4	modelMatrix();
		
		CGMaths::CGVector3D		worldToScreen( const CGMaths::CGVector3D & _point );
		CGMaths::CGVector3D		screenToWorld( const CGMaths::CGVector3D & _point );
		
#pragma mark ---------------------------------------------------------
#pragma mark === End Public Functions  ===
#pragma mark ---------------------------------------------------------
		
#pragma mark ---------------------------------------------------------
#pragma mark === Private Data  ===
#pragma mark ---------------------------------------------------------
	private: // Data
		
		NSString *				m_name;
		
		float					m_fov;
		float					m_near;
		float					m_far;
		CGRect					m_viewport;
		CGMaths::CGMatrix4x4	m_transform;
		
#pragma mark ---------------------------------------------------------
#pragma mark === End Private Data  ===
#pragma mark ---------------------------------------------------------	
	};
	
};

#endif