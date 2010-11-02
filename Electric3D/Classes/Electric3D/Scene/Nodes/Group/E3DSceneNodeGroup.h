/*
 *  E3DSceneNodeGroup.h
 *  Electric3D
 *
 *  Created by Robert McDowell on 19/10/2010.
 *  Copyright 2010 Electric TopHat Ltd. All rights reserved.
 *
 */

#if !defined(__E3DSceneNodeGroup_h__)
#define __E3DSceneNodeGroup_h__

#import "E3DSceneNodeTypes.h"
#import "E3DSceneNode.h"

namespace E3D 
{
	class E3DSceneNodeGroup : public E3DSceneNode
	{
#pragma mark ---------------------------------------------------------
#pragma mark Constructor / Destructor
#pragma mark ---------------------------------------------------------
	public: // Functions
		
		E3DSceneNodeGroup( NSString * _name )
		: E3DSceneNode( _name )
		{};
		virtual ~E3DSceneNodeGroup() {};
		
#pragma mark ---------------------------------------------------------
#pragma mark End Constructor / Destructor
#pragma mark ---------------------------------------------------------
		
#pragma mark ---------------------------------------------------------
#pragma mark === Public Functions  ===
#pragma mark ---------------------------------------------------------
	public: // Functions
		
		inline eE3DSceneNodeType type() const { return eE3DSceneNodeType_Group; };
		
		inline const CGMaths::CGAABB	  aabb() const { return CGMaths::CGAABBZero; };
		inline const CGMaths::CGSphere	sphere() const { return CGMaths::CGSphereZero; };
		
#pragma mark ---------------------------------------------------------
#pragma mark === Public Functions  ===
#pragma mark ---------------------------------------------------------		
	};
};

#endif