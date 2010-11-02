/*
 *  E3DMeshTypes.h
 *  Electric3D
 *
 *  Created by Robert McDowell on 23/09/2010.
 *  Copyright 2010 Electric TopHat Ltd. All rights reserved.
 *
 */

#if !defined(__E3DMeshTypes_h__)
#define __E3DMeshTypes_h__

namespace E3D 
{
	typedef enum 
	{
		eE3DMeshType_Invalid = 0,
		eE3DMeshType_Static,
		eE3DMeshType_Morph,
		
	} eE3DMeshType;
		
	typedef struct
	{
		unsigned int		ident;
		unsigned int		version; 
		
	} E3DMeshFileHeader;
};

#endif