/*
 *  E3DSceneNodeRoot.h
 *  Electric3D
 *
 *  Created by Robert McDowell on 19/10/2010.
 *  Copyright 2010 Electric TopHat Ltd. All rights reserved.
 *
 */

#if !defined(__E3DSceneNodeRoot_h__)
#define __E3DSceneNodeRoot_h__

#import "E3DSceneNodeTypes.h"
#import "E3DSceneNode.h"

namespace E3D 
{
	class E3DSceneNodeRoot : public E3DSceneNode
	{
#pragma mark ---------------------------------------------------------
#pragma mark Constructor / Destructor
#pragma mark ---------------------------------------------------------
	public: // Functions
		
		E3DSceneNodeRoot( NSString * _name )
		: E3DSceneNode( _name )
		{};
		virtual ~E3DSceneNodeRoot() {};
		
#pragma mark ---------------------------------------------------------
#pragma mark End Constructor / Destructor
#pragma mark ---------------------------------------------------------
		
#pragma mark ---------------------------------------------------------
#pragma mark === Public Functions  ===
#pragma mark ---------------------------------------------------------
	public: // Functions
		
		inline eE3DSceneNodeType type() const { return eE3DSceneNodeType_Root; };
		
#pragma mark ---------------------------------------------------------
#pragma mark === Public Functions  ===
#pragma mark ---------------------------------------------------------		
	};
};

#endif