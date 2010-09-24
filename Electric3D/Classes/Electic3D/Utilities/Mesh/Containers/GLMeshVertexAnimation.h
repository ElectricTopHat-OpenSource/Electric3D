//
//  GLMeshVertexAnimation.h
//  Electric3D
//
//  Created by Robert McDowell on 23/09/2010.
//  Copyright 2010 Electric TopHat Ltd. All rights reserved.
//

#if !defined(__GLMeshVertexAnimation_h__)
#define __GLMeshVertexAnimation_h__

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
		unsigned int numframes;
		unsigned int numverts;
		
	} GLMeshVertexAnimationHeader;
	
#pragma mark ---------------------------------------------------------
#pragma mark End File Header
#pragma mark ---------------------------------------------------------
	
	class GLMeshVertexAnimation : public GLMesh
	{
#pragma mark ---------------------------------------------------------
#pragma mark Constructor / Destructor
#pragma mark ---------------------------------------------------------
	public: // Functions
		
		GLMeshVertexAnimation( NSString * _filePath = nil );
		GLMeshVertexAnimation( unsigned int _numverts, unsigned int _numframes, NSString * _name = nil );
		virtual ~GLMeshVertexAnimation();

#pragma mark ---------------------------------------------------------
#pragma mark End Constructor / Destructor
#pragma mark ---------------------------------------------------------
		
#pragma mark ---------------------------------------------------------
#pragma mark === Public Functions  ===
#pragma mark ---------------------------------------------------------
	public: // Functions
		
		inline eGLMeshType	type() const	{ return eGLMeshType_VertexAnimation; };
		inline BOOL valid() const			{ return m_data != nil; };
		
		// read and write the data
		BOOL read( NSString * _filePath );
		BOOL write( NSString * _filePath ) const;
		
		inline const unsigned int			numframes() const											{ return m_header->numframes; };
		inline const unsigned int			numverts() const											{ return m_header->numverts; };
	
		// get a writeable version of the vert buffer
		inline GLInterleavedVertNormal3D *			frameverts( unsigned int _frame ) { return m_verts[_frame]; };
		
		inline const GLInterleavedVertNormal3D *	frameverts( unsigned int _frame ) const						{ return m_verts[_frame]; };
		inline const GLInterleavedVertNormal3D *	framevert( unsigned int _frame, unsigned int _index ) const	{ return &m_verts[_frame][_index]; };
		
		
		// get a vert buffer with the interped verts
		const GLInterleavedVert3D *					interpverts( unsigned int _frame1, unsigned int _frame2, float _interp ) const;
		inline const GLInterleavedVert3D *			interpverts() const { return m_iterpverts; };
		inline GLInterleavedVert3D *				interpverts() { return m_iterpverts; };
		
		
#pragma mark ---------------------------------------------------------
#pragma mark === End Public Functions  ===
#pragma mark ---------------------------------------------------------
		
#pragma mark ---------------------------------------------------------
#pragma mark Private Data
#pragma mark ---------------------------------------------------------
	private: // Data
		
		NSData *						m_data;
		
		GLMeshVertexAnimationHeader *	m_header;
		GLInterleavedVert3D *			m_iterpverts;
		GLInterleavedVertNormal3D	*	m_verts[256];
		
#pragma mark ---------------------------------------------------------
#pragma mark End Private Data
#pragma mark ---------------------------------------------------------
	};

};

#endif