/*
 *  GLUITypes.h
 *  Electric3D
 *
 *  Created by Robert McDowell on 21/09/2010.
 *  Copyright 2010 Electric TopHat Ltd. All rights reserved.
 *
 */

#if !defined(__GLUITypes_h__)
#define __GLUITypes_h__

namespace UI
{
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