//
//  E3DSceneNode.h
//  Electric3D
//
//  Created by Robert McDowell on 19/10/2010.
//  Copyright 2010 Electric TopHat Ltd. All rights reserved.
//

#if !defined(__E3DSceneNode_h__)
#define __E3DSceneNode_h__

#import "E3DSceneNodeTypes.h"
#import "E3DColorComponent.h"
#import "E3DTransformComponent.h"

namespace E3D { class E3DScene; };

namespace E3D  
{
	class E3DSceneNode
	: public E3DColorComponent
	, public E3DTransformComponent
	{
		friend class E3DScene;
#pragma mark ---------------------------------------------------------
#pragma mark Constructor / Destructor
#pragma mark ---------------------------------------------------------
	public: // Functions
		
		E3DSceneNode( NSString * _name = nil );
		virtual ~E3DSceneNode();
		
#pragma mark ---------------------------------------------------------
#pragma mark End Constructor / Destructor
#pragma mark ---------------------------------------------------------
		
#pragma mark ---------------------------------------------------------
#pragma mark === Public Functions  ===
#pragma mark ---------------------------------------------------------
	public: // Functions
		
		virtual eE3DSceneNodeType		  type() const { return eE3DSceneNodeType_Unknown; };
		
		virtual const BOOL			isGeometry() const { return FALSE; };
		virtual const CGMaths::CGAABB	  aabb() const = 0;
		virtual const CGMaths::CGSphere sphere() const = 0;
		
		inline const NSString *	name() const						{ return m_name; };
		inline const NSUInteger hash() const						{ return m_hash; };
		
		inline BOOL isVisible() const								{ return !m_hidden && ( alpha() > 0.001f ); };
		inline BOOL isHidden() const								{ return m_hidden; };
		inline void setHidden( BOOL _hidden )						{ m_hidden = _hidden; };
		
		virtual void addChild( E3DSceneNode * _child );
		virtual void removeChild( E3DSceneNode * _child );
		virtual void removeAllChildren();
		
		inline NSUInteger			identifier() const				{ return m_identifier; };
		inline void					setIdentifier(NSUInteger _id)	{ m_identifier = _id; };
		
		inline E3DScene *			scene()							{ return m_scene; };
		inline const E3DScene *		scene() const					{ return m_scene; };
		
		inline E3DSceneNode *		parent()						{ return m_parent; };
		inline const E3DSceneNode *	parent() const					{ return m_parent; };
		
		inline NSUInteger			numchildren() const				{ return m_children.size(); };
		inline const sceneNodes &	children() const				{ return m_children; };
		inline E3DSceneNode *		child( NSInteger _index )		{ return m_children[_index]; };
		inline const E3DSceneNode *	child( NSInteger _index ) const	{ return m_children[_index]; };
		
		
		
		
#pragma mark ---------------------------------------------------------
#pragma mark === End Public Functions  ===
#pragma mark ---------------------------------------------------------
		
#pragma mark ---------------------------------------------------------
#pragma mark Private Data
#pragma mark ---------------------------------------------------------
	private: // Data
		
		NSString *		m_name;
		NSUInteger		m_hash;
		NSUInteger		m_identifier;
		
		E3DScene *		m_scene;
		E3DSceneNode *	m_parent;
		sceneNodes		m_children;
		
		BOOL			m_hidden;
		
#pragma mark ---------------------------------------------------------
#pragma mark End Private Data
#pragma mark ---------------------------------------------------------
	};	
};

#endif
