/*
 *  E3DSceneNodeTypes.h
 *  Electric3D
 *
 *  Created by Robert McDowell on 19/10/2010.
 *  Copyright 2010 Electric TopHat Ltd. All rights reserved.
 *
 */

#if !defined(__E3DSceneNodeTypes_h__)
#define __E3DSceneNodeTypes_h__

#import <vector>

namespace E3D { class E3DSceneNode; };
namespace E3D 
{
	typedef std::vector<E3DSceneNode*>					sceneNodes;
	typedef std::vector<E3DSceneNode*>::iterator		sceneNodesIterator;
	typedef std::vector<E3DSceneNode*>::const_iterator	sceneNodesConstIterator;	
	
	typedef enum
	{
		eE3DSceneNodeType_Unknown = -1,
		
		eE3DSceneNodeType_Root,
		eE3DSceneNodeType_Group,
		
		eE3DSceneNodeType_ModelStatic,
		eE3DSceneNodeType_ModelMorph,
		
	} eE3DSceneNodeType;
};


#endif