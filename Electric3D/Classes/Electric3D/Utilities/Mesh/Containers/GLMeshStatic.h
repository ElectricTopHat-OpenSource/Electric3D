//
//  GLMeshStatic.h
//  Electric3D
//
//  Created by Robert McDowell on 23/09/2010.
//  Copyright 2010 Electric TopHat Ltd. All rights reserved.
//

#if !defined(__GLMeshStatic_h__)
#define __GLMeshStatic_h__

#import "CGMaths.h"
#import "GLMesh.h"
#import "GLVertexTypes.h"

namespace GLMeshes 
{
	
#pragma mark ---------------------------------------------------------
#pragma mark File Header
#pragma mark ---------------------------------------------------------
	
	typedef struct
	{
		unsigned int	numindices;
		unsigned int	numverts;
		CGMaths::CGAABB aabb;
		
	} GLMeshStaticInfo;
	
	typedef struct 
	{
		unsigned int		ident;
		unsigned int		version; 
		GLMeshStaticInfo	info;
		
	} GLMeshStaticHeader;

#pragma mark ---------------------------------------------------------
#pragma mark End File Header
#pragma mark ---------------------------------------------------------
	
	class GLMeshStatic : public GLMesh
	{
#pragma mark ---------------------------------------------------------
#pragma mark Constructor / Destructor
#pragma mark ---------------------------------------------------------
	public: // Functions
		
		GLMeshStatic( NSString * _filePath = nil );
		GLMeshStatic( const GLMeshStaticInfo & _info, NSString * _name = nil );
		virtual ~GLMeshStatic();
		
#pragma mark ---------------------------------------------------------
#pragma mark End Constructor / Destructor
#pragma mark ---------------------------------------------------------

#pragma mark ---------------------------------------------------------
#pragma mark === Public Functions  ===
#pragma mark ---------------------------------------------------------
	public: // Functions
		
		inline eGLMeshType	type() const	{ return eGLMeshType_Static; };
		
		inline BOOL valid() const			{ return m_data != nil; };
		
		// read and write the data
		BOOL read( NSString * _filePath );
		BOOL write( NSString * _filePath ) const;
		
		inline const NSUInteger				numverts() const					{ return m_header->info.numverts; };
		inline const NSUInteger				numindices() const					{ return m_header->info.numindices; };
		
		inline const CGMaths::CGAABB &		AABB() const						{ return m_header->info.aabb; };
		inline void							setAABB( CGMaths::CGAABB & _aabb )	{ m_header->info.aabb = _aabb; };
		
		inline const eGLVertListType		vertListType() const				{ return ( m_indices ) ? eGLVertListType_Indexed : eGLVertListType_NonIndexed; };
		
		inline const GLInterleavedVert3D *	verts() const						{ return m_verts; };
		inline GLInterleavedVert3D *		verts()								{ return m_verts; };
		
		inline const GLVertIndice *			indices() const						{ return m_indices; };
		inline GLVertIndice *				indices()							{ return m_indices; };
				
		inline const GLInterleavedVert3D *	vert( unsigned int _index ) const	{ return &m_verts[_index]; };
		
#pragma mark ---------------------------------------------------------
#pragma mark === End Public Functions  ===
#pragma mark ---------------------------------------------------------
		
#pragma mark ---------------------------------------------------------
#pragma mark Private Data
#pragma mark ---------------------------------------------------------
	private: // Data
		
		NSData *				m_data;
		
		GLMeshStaticHeader *	m_header;
		GLInterleavedVert3D	*	m_verts;
		GLVertIndice *			m_indices;

#pragma mark ---------------------------------------------------------
#pragma mark End Private Data
#pragma mark ---------------------------------------------------------
	};

};

#endif