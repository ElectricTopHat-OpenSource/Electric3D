//
//  E3DScene.h
//  Electric3D
//
//  Created by Robert McDowell on 19/10/2010.
//  Copyright 2010 Electric TopHat Ltd. All rights reserved.
//

#if !defined(__E3DScene_h__)
#define __E3DScene_h__

#import "E3DSceneTypes.h"
#import "E3DCamera.h"
#import "E3DSceneNodeRoot.h"



namespace E3D  
{
	class E3DScene
	{
#pragma mark ---------------------------------------------------------
#pragma mark Constructor / Destructor
#pragma mark ---------------------------------------------------------
	public: // Functions
		
		E3DScene( NSString * _name = nil, eE3DSceneType _type = eE3DSceneType_World );
		virtual ~E3DScene();
		
#pragma mark ---------------------------------------------------------
#pragma mark End Constructor / Destructor
#pragma mark ---------------------------------------------------------
		
#pragma mark ---------------------------------------------------------
#pragma mark === Public Functions  ===
#pragma mark ---------------------------------------------------------
	public: // Functions
		
		inline eE3DSceneType type() const				{ return m_header.type; };
		inline const NSString *	name() const			{ return m_root.name(); };
		inline const NSUInteger hash() const			{ return m_root.hash(); };
		
		inline BOOL isVisible() const					{ return m_root.isVisible(); };
		inline BOOL isHidden() const					{ return m_root.isHidden(); };
		inline void setHidden( BOOL _hidden )			{ m_root.setHidden(_hidden); };
		
		inline E3DCamera *		 camera()				{ return &m_camera; };
		inline const E3DCamera * camera() const			{ return &m_camera; };
		
		inline NSUInteger numchildren() const			{ return m_root.numchildren(); };
		inline E3DSceneNode * child( NSInteger _index )	{ return m_root.child(_index); };
		
		inline void addChild( E3DSceneNode * _child )	{ m_root.addChild(_child); };
		inline void removeChild( E3DSceneNode * _child ){ m_root.removeChild(_child); };
		inline void removeAllChildren()					{ m_root.removeAllChildren(); };		
		
		inline E3DSceneNode &		root()				{ return m_root; };
		inline const E3DSceneNode & root() const		{ return m_root; };
		
#pragma mark ---------------------------------------------------------
#pragma mark === End Public Functions  ===
#pragma mark ---------------------------------------------------------
		
#pragma mark ---------------------------------------------------------
#pragma mark Private Data
#pragma mark ---------------------------------------------------------
	private: // Data
		
		// scene header
		E3DSceneHeader		m_header;
		
		// cameras
		E3DCamera			m_camera;
		
		// lights
		
		// the root node for models
		E3DSceneNodeRoot	m_root;
		
#pragma mark ---------------------------------------------------------
#pragma mark End Private Data
#pragma mark ---------------------------------------------------------
	};
	
};

#endif