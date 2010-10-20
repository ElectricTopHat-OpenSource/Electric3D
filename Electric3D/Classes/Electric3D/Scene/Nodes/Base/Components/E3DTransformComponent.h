/*
 *  E3DTransformComponent.h
 *  Electric3D
 *
 *  Created by Robert McDowell on 19/10/2010.
 *  Copyright 2010 Electric TopHat Ltd. All rights reserved.
 *
 */

#if !defined(__E3DTransformComponent_h__)
#define __E3DTransformComponent_h__

#import "CGMaths.h"

namespace E3D  
{
	// Color Component 
	class E3DTransformComponent 
	{
#pragma mark ---------------------------------------------------------
#pragma mark Constructor / Destructor
#pragma mark ---------------------------------------------------------
	public: // Functions
		
		E3DTransformComponent()
		{ 
			m_transform = CGMaths::CGMatrix4x4Identity; 
			m_dirty=FALSE; 
			m_identity=TRUE; 
		};
		virtual ~E3DTransformComponent()
		{
		};
		
#pragma mark ---------------------------------------------------------
#pragma mark End Constructor / Destructor
#pragma mark ---------------------------------------------------------
		
#pragma mark ---------------------------------------------------------
#pragma mark === Public Functions  ===
#pragma mark ---------------------------------------------------------
	public: // Functions
		
		// is the transform an identity matrix
		inline BOOL	isIdentity() 
		{
			if ( m_dirty )
			{
				m_dirty		= FALSE;
				m_identity	= CGMaths::CGMatrix4x4IsIdentity( m_transform );
			}
			return m_identity;
		};
		
		inline CGMaths::CGMatrix4x4 &		transform()				{ m_dirty = TRUE; return m_transform; };
		inline const CGMaths::CGMatrix4x4 & transform() const		{ return m_transform; };

		inline CGMaths::CGVector3D			position() const		{ return CGMaths::CGMatrix4x4GetTranslation( m_transform ); };
		inline CGMaths::CGVector3D			at() const				{ return CGMaths::CGMatrix4x4GetAt( m_transform ); };
		inline CGMaths::CGVector3D			up() const				{ return CGMaths::CGMatrix4x4GetUp( m_transform ); };
		inline CGMaths::CGVector3D			right() const			{ return CGMaths::CGMatrix4x4GetRight( m_transform ); };
		
		inline void setTransform (const CGMaths::CGMatrix4x4 & _transform ) { m_dirty = TRUE; m_transform = _transform; };
		inline void setPosition( const CGMaths::CGVector3D & _pos )			{ m_dirty = TRUE; CGMaths::CGMatrix4x4SetTranslation( m_transform, _pos ); };
		inline void setAt( const CGMaths::CGVector3D & _at )				{ m_dirty = TRUE; CGMaths::CGMatrix4x4SetAt( m_transform, _at ); };
		inline void setUp( const CGMaths::CGVector3D & _up )				{ m_dirty = TRUE; CGMaths::CGMatrix4x4SetUp( m_transform, _up ); };
		inline void setRight( const CGMaths::CGVector3D & _right )			{ m_dirty = TRUE; CGMaths::CGMatrix4x4SetRight( m_transform, _right ); };
		
#pragma mark ---------------------------------------------------------
#pragma mark === End Public Functions  ===
#pragma mark ---------------------------------------------------------
		
#pragma mark ---------------------------------------------------------
#pragma mark === Protected Data  ===
#pragma mark ---------------------------------------------------------
	protected: // Data
		
		CGMaths::CGMatrix4x4			m_transform;
		BOOL							m_dirty;
		BOOL							m_identity;
		
#pragma mark ---------------------------------------------------------
#pragma mark === End Protected Data  ===
#pragma mark ---------------------------------------------------------
	};
	
};


#endif