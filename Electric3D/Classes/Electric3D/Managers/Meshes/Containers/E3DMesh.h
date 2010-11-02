/*
 *  E3DMesh.h
 *  Electric3D
 *
 *  Created by Robert McDowell on 23/09/2010.
 *  Copyright 2010 Electric TopHat Ltd. All rights reserved.
 *
 */

#if !defined(__E3DMesh_h__)
#define __E3DMesh_h__

#import "E3DMeshTypes.h"
#import "CGMaths.h"
#import "GLVertexTypes.h"

namespace E3D { class E3DMeshManager; };

namespace E3D 
{	
	class E3DMesh 
	{
#pragma mark ---------------------------------------------------------
#pragma mark Friend
#pragma mark ---------------------------------------------------------
		
		friend class E3DMeshManager;
		
#pragma mark ---------------------------------------------------------
#pragma mark End Friend
#pragma mark ---------------------------------------------------------
		
#pragma mark ---------------------------------------------------------
#pragma mark Constructor / Destructor
#pragma mark ---------------------------------------------------------
	public: // Functions
		
		E3DMesh( NSString * _name = nil ) 
		{ 
			m_name = [_name copy]; 
			m_hash = [m_name hash]; 
			m_referenceCount=1; 
		};
		virtual ~E3DMesh() {};
		
#pragma mark ---------------------------------------------------------
#pragma mark End Constructor / Destructor
#pragma mark ---------------------------------------------------------
		
#pragma mark ---------------------------------------------------------
#pragma mark === Public Functions  ===
#pragma mark ---------------------------------------------------------
	public: // Functions
		
		virtual eE3DMeshType		type() const = 0;
		virtual BOOL			isValid() const = 0;
		virtual const NSData *	data() const = 0;
		
		inline const NSString *				name() const { return [m_name lastPathComponent]; };
		inline const NSUInteger				hash() const { return m_hash; };
		
		virtual const NSUInteger			numverts() const = 0;
		virtual const NSUInteger			numindices() const = 0;
		
		virtual const CGMaths::CGAABB &		aabb() const = 0;
		virtual const CGMaths::CGSphere 	sphere() const = 0;
		
		virtual const GLInterleavedVert3D *	verts() const = 0;
		virtual const GLVertIndice *		indices() const = 0;
		
#pragma mark ---------------------------------------------------------
#pragma mark === End Public Functions  ===
#pragma mark ---------------------------------------------------------
		
#pragma mark ---------------------------------------------------------
#pragma mark Private Functions
#pragma mark ---------------------------------------------------------
	private: // Functions
		
		inline NSInteger referenceCount() const { return m_referenceCount; };
		inline void incrementReferenceCount() { m_referenceCount++; };
		inline void decrementReferenceCount() { m_referenceCount--; };
		
#pragma mark ---------------------------------------------------------
#pragma mark End Private Functions
#pragma mark ---------------------------------------------------------
		
#pragma mark ---------------------------------------------------------
#pragma mark Private Data
#pragma mark ---------------------------------------------------------
	private: // Data
		
		NSString *		m_name;
		NSUInteger		m_hash;
		NSInteger		m_referenceCount;
		
#pragma mark ---------------------------------------------------------
#pragma mark End Private Data
#pragma mark ---------------------------------------------------------
	};
};

#endif