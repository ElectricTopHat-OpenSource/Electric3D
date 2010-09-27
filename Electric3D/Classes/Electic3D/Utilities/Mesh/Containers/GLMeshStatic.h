//
//  GLMeshStatic.h
//  Electric3D
//
//  Created by Robert McDowell on 23/09/2010.
//  Copyright 2010 Electric TopHat Ltd. All rights reserved.
//

#if !defined(__GLMeshStatic_h__)
#define __GLMeshStatic_h__

#import "GLMesh.h"
#import "GLVertexTypes.h"

namespace GLMeshes 
{
	
#pragma mark ---------------------------------------------------------
#pragma mark File Header
#pragma mark ---------------------------------------------------------
	
	typedef struct 
	{
		unsigned int ident;
		unsigned int version; 
		unsigned int numverts;
		
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
		GLMeshStatic( unsigned int _numverts, NSString * _name = nil );
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
		
		inline const NSUInteger				numverts() const					{ return m_header->numverts; };
	
		inline const GLInterleavedVert3D *	verts() const						{ return m_verts; };
		inline GLInterleavedVert3D *		verts()								{ return m_verts; };
		
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

#pragma mark ---------------------------------------------------------
#pragma mark End Private Data
#pragma mark ---------------------------------------------------------
	};

};

#endif