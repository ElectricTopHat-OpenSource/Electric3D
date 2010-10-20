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

namespace E3D  
{
	class E3DSceneNode
	: public E3DColorComponent
	, public E3DTransformComponent
	{
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
		
		virtual eE3DSceneNodeType type() const = 0;
		
		inline const NSString *	name() const { return m_name; };
		inline const NSUInteger hash() const { return m_hash; };
		
		inline BOOL isVisible() const		 { return !m_hidden && ( alpha() > 0.001f ); };
		inline BOOL isHidden() const		 { return m_hidden; };
		inline void setHidden( BOOL _hidden ){ m_hidden = _hidden; };
		
		void addChild( E3DSceneNode * _child );
		void removeChild( E3DSceneNode * _child );
		void removeAllChildren();
		
		inline NSUInteger			numchildren() const			{ return m_children.size(); };
		inline const sceneNodes &	children() const			{ return m_children; };
		inline E3DSceneNode *		child( NSInteger _index )	{ return m_children[_index]; };
		
#pragma mark ---------------------------------------------------------
#pragma mark === End Public Functions  ===
#pragma mark ---------------------------------------------------------
		
#pragma mark ---------------------------------------------------------
#pragma mark Private Data
#pragma mark ---------------------------------------------------------
	private: // Data
		
		NSString *	m_name;
		NSInteger	m_hash;
		
		sceneNodes	m_children;
		
		BOOL		m_hidden;
		
#pragma mark ---------------------------------------------------------
#pragma mark End Private Data
#pragma mark ---------------------------------------------------------
	};	
};

#endif
