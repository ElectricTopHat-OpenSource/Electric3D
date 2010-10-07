/*
 *  CGOOBB.h
 *  Electric3D
 *
 *  Created by Robert McDowell on 07/10/2010.
 *  Copyright 2010 Electric TopHat Ltd. All rights reserved.
 *
 */

#if !defined(__CGOOBB_h__)
#define __CGOOBB_h__

#import "CGMathsConstants.h"
#import "CGVector3D.h"

namespace CGMaths 
{
	
#pragma mark ---------------------------------------------------------
#pragma mark CGAABB typedef
#pragma mark ---------------------------------------------------------
	
	typedef struct 
	{ 
		CGMatrix4x4 transform;
		CGVector3D	extents;
	} CGOOBB;
	
#pragma mark ---------------------------------------------------------
#pragma mark End CGAABB typedef
#pragma mark ---------------------------------------------------------

};

#endif