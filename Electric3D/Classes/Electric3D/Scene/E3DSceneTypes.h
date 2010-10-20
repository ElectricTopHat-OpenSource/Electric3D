/*
 *  E3DSceneTypes.h
 *  Electric3D
 *
 *  Created by Robert McDowell on 19/10/2010.
 *  Copyright 2010 Electric TopHat Ltd. All rights reserved.
 *
 */

#if !defined(__E3DSceneTypes_h__)
#define __E3DSceneTypes_h__

namespace E3D
{
	// tell the scene how 
	// camera is setup
	typedef enum 
	{
		eE3DSceneType_World = 0,
		eE3DSceneType_Screen,
	
	} eE3DSceneType;
};

#endif