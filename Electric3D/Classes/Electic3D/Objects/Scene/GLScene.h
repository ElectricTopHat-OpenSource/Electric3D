/*
 *  GLScene.h
 *  Electric3D
 *
 *  Created by Robert McDowell on 25/09/2010.
 *  Copyright 2010 Electric TopHat Ltd. All rights reserved.
 *
 */

#if !defined(__GLScene_h__)
#define __GLScene_h__

#import "GLObject.h"
#import "CGMaths.h"
#import "GLColors.h"
#import <map>

//namespace GLObjects	{ class GLSceneFactory; };

namespace GLObjects 
{
#pragma mark ---------------------------------------------------------
#pragma mark Type Defines
#pragma mark ---------------------------------------------------------
	
	typedef std::map<NSUInteger,GLObjects::GLObject*>					_SceneList;
	typedef std::map<NSUInteger,GLObjects::GLObject*>::iterator			_SceneListIterator;
	typedef std::map<NSUInteger,GLObjects::GLObject*>::const_iterator	_SceneListConstIterator;
	
#pragma mark ---------------------------------------------------------
#pragma mark End Type Defines
#pragma mark ---------------------------------------------------------
	
	class GLScene : public GLObject
	{
#pragma mark ---------------------------------------------------------
#pragma mark Friend
#pragma mark ---------------------------------------------------------
		
		//friend class GLSceneFactory;
		
#pragma mark ---------------------------------------------------------
#pragma mark End Friend
#pragma mark ---------------------------------------------------------
		
#pragma mark ---------------------------------------------------------
#pragma mark Constructor / Destructor
#pragma mark ---------------------------------------------------------
	public: // Functions
		
		GLScene( NSString * _name = nil );
		virtual ~GLScene();
		
#pragma mark ---------------------------------------------------------
#pragma mark End Constructor / Destructor
#pragma mark ---------------------------------------------------------
		
#pragma mark ---------------------------------------------------------
#pragma mark === Public Functions  ===
#pragma mark ---------------------------------------------------------
	public: // Functions
		
		inline eGLObjectType type() const { return eGLObjectType_Scene; }
		
		BOOL contains( const GLObjects::GLObject * _object ) const;
		
		BOOL add( GLObjects::GLObject * _object );
		void remove( GLObjects::GLObject * _object );
		void clear();
		
		inline GLColors::GLColor & color()										{ return m_color; };
		inline const GLColors::GLColor & color() const							{ return m_color; };
		inline void setColor( const GLColors::GLColor & _color )				{ return m_color.setColor(_color); };
		
		inline CGMaths::CGMatrix4x4 & transform()								{ return m_transform; };
		inline const CGMaths::CGMatrix4x4 & transform() const					{ return m_transform; };
		inline void setTransform( const CGMaths::CGMatrix4x4 & _transform )		{ m_transform = _transform; };
		
		inline CGMaths::CGVector3D postion() const								{ return CGMaths::CGMatrix4x4GetTranslation( m_transform ); };
		inline void setPostion( const CGMaths::CGVector3D & _pos )				{ CGMaths::CGMatrix4x4SetTranslation( m_transform, _pos ); };
		
		inline const _SceneList & objects() const { return m_objects; };
		
#pragma mark ---------------------------------------------------------
#pragma mark === End Public Functions  ===
#pragma mark ---------------------------------------------------------
		
#pragma mark ---------------------------------------------------------
#pragma mark Private Functions
#pragma mark ---------------------------------------------------------
	private: // Functions
		
		inline NSInteger referenceCount() const { return m_referenceCount; };
		inline void incrementReferenceCount() { m_referenceCount++; };
		inline void decrementReferenceCount() { m_referenceCount--; };
		
#pragma mark ---------------------------------------------------------
#pragma mark End Private Functions
#pragma mark ---------------------------------------------------------
		
#pragma mark ---------------------------------------------------------
#pragma mark Private Data
#pragma mark ---------------------------------------------------------
	private: // Data
		
		NSInteger						m_referenceCount;
		
		GLColors::GLColor				m_color;
		CGMaths::CGMatrix4x4			m_transform;
		
		_SceneList						m_objects;
		
#pragma mark ---------------------------------------------------------
#pragma mark End Private Data
#pragma mark ---------------------------------------------------------
	};
	
};

#endif
