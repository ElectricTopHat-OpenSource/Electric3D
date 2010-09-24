//
//  GLObjectTypes.h
//  Electric3D
//
//  Created by Robert McDowell on 22/09/2010.
//  Copyright 2010 Electric TopHat Ltd. All rights reserved.
//

#if !defined(__GLObjectTypes_h__)
#define __GLObjectTypes_h__

namespace GLObjects
{
	typedef enum 
	{
		eGLObjectType_Model = 0,
		
	} eGLObjectType;
	
	typedef enum 
	{
		eGLUIImage = 0,
		eGLUISprite,
		eGLUILabel,
		
	} eGLUITypes;
	
	typedef enum
	{
		eGLUICoordinatesLayout_LeftToRight_TopToBottom = 0,  /// Normal
		eGLUICoordinatesLayout_RightToLeft_TopToBottom,      /// Flip Horizontally
		eGLUICoordinatesLayout_LeftToRight_BottomToTop,	  /// Flip Vertically
		eGLUICoordinatesLayout_RightToLeft_BottomToTop,	  /// Flip Both Axis
		
	} eGLUICoordinatesLayout;
};

#endif
