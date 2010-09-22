//
//  GLUIObject.h
//  Electric3D
//
//  Created by Robert McDowell on 21/09/2010.
//  Copyright 2010 Electric TopHat Ltd. All rights reserved.
//

#if !defined(__GLUIObject_h__)
#define __GLUIObject_h__

#import "GLUITypes.h"

namespace UI
{
	// --------------------------------------
	// GLUIObject is a pure virtual base class.
	// --------------------------------------
	class GLUIObject
	{		
	#pragma mark ---------------------------------------------------------
	#pragma mark Constructor / Destructor
	#pragma mark ---------------------------------------------------------
	public: // Functions
		
		virtual ~GLUIObject(){};
		
	#pragma mark ---------------------------------------------------------
	#pragma mark End Constructor / Destructor
	#pragma mark ---------------------------------------------------------
		
	#pragma mark ---------------------------------------------------------
	#pragma mark Public Functions
	#pragma mark ---------------------------------------------------------
	public:	// Functions
		
		// Object Type via an enumerator
		virtual eGLUITypes type() const = 0;
		
	#pragma mark ---------------------------------------------------------
	#pragma mark End Public Functions
	#pragma mark ---------------------------------------------------------
	};
};
	
#endif
