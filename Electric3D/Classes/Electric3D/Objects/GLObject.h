/*
 *  GLObject.h
 *  Electric3D
 *
 *  Created by Robert McDowell on 23/09/2010.
 *  Copyright 2010 Electric TopHat Ltd. All rights reserved.
 *
 */

#if !defined(__GLObject_h__)
#define __GLObject_h__

#import "GLObjectTypes.h"

namespace GLObjects
{
	class GLObject 
	{
#pragma mark ---------------------------------------------------------
#pragma mark Constructor / Destructor
#pragma mark ---------------------------------------------------------
	public: // Functions
		
		GLObject( NSString * _name = nil ) { m_name = [_name copy]; static NSUInteger val=0; m_hash=val++; };
		virtual ~GLObject() {};
		
#pragma mark ---------------------------------------------------------
#pragma mark End Constructor / Destructor
#pragma mark ---------------------------------------------------------
		
#pragma mark ---------------------------------------------------------
#pragma mark === Public Functions  ===
#pragma mark ---------------------------------------------------------
	public: // Functions
		
		virtual eGLObjectType type() const = 0;
		
		inline const NSString *	name() const { return m_name; };
		inline const NSUInteger hash() const { return m_hash; };
		
#pragma mark ---------------------------------------------------------
#pragma mark === End Public Functions  ===
#pragma mark ---------------------------------------------------------
		
#pragma mark ---------------------------------------------------------
#pragma mark Private Data
#pragma mark ---------------------------------------------------------
	private: // Data
		
		NSString *		m_name;
		NSUInteger		m_hash;
		
#pragma mark ---------------------------------------------------------
#pragma mark End Private Data
#pragma mark ---------------------------------------------------------
	};	
};

#endif