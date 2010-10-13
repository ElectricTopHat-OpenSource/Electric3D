//
//  GLMeshVertexAnimation.h
//  Electric3D
//
//  Created by Robert McDowell on 23/09/2010.
//  Copyright 2010 Electric TopHat Ltd. All rights reserved.
//

#if !defined(__GLMeshVertexAnimation_h__)
#define __GLMeshVertexAnimation_h__

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
		unsigned int	numframes;
		unsigned int	numverts;
		unsigned int	numindices;
		CGMaths::CGAABB aabb;
		
	} GLMeshVertexAnimationInfo;
	
	typedef struct 
	{
		unsigned int				ident;
		unsigned int				version; 
		GLMeshVertexAnimationInfo	info;
		
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
		GLMeshVertexAnimation( const GLMeshVertexAnimationInfo & _info, NSString * _name = nil );
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
		
		inline const NSUInteger				numverts() const		{ return m_header->info.numverts; };
		inline const NSUInteger				numindices() const		{ return m_header->info.numindices; };
		inline const NSUInteger				numframes() const		{ return m_header->info.numframes; };
		
		inline const CGMaths::CGAABB &		aabb() const						{ return m_header->info.aabb; };
		inline const CGMaths::CGAABB &		aabb( unsigned int _frame )	const	{ return m_vertsaabb[_frame]; }
		const CGMaths::CGAABB &				aabb( unsigned int _frame1, unsigned int _frame2, float _interp ) const;
		inline void							setaabb( CGMaths::CGAABB & _aabb )	{ m_header->info.aabb = _aabb; };
		inline void							setaabb( unsigned int _frame, CGMaths::CGAABB & _aabb )	{ m_vertsaabb[_frame] = _aabb; };
		
		inline const eGLVertListType		vertListType() const				{ return ( m_indices ) ? eGLVertListType_Indexed : eGLVertListType_NonIndexed; };
		inline const GLInterleavedVert3D *	verts() const						{ return m_iterpverts; };
		
		inline const GLVertIndice *			indices() const						{ return m_indices; };
		inline GLVertIndice *				indices()							{ return m_indices; };
		
		// get a vert buffer with the interped verts
		const GLInterleavedVert3D *					interpverts( unsigned int _frame ) const;
		const GLInterleavedVert3D *					interpverts( unsigned int _frame1, unsigned int _frame2, float _interp ) const;
		inline GLInterleavedVert3D *				interpverts() { return m_iterpverts; };
		
		// get a writeable version of the vert buffer
		inline GLInterleavedVertNormal3D *			frameverts( unsigned int _frame ) { return m_verts[_frame]; };
		
		inline const GLInterleavedVertNormal3D *	frameverts( unsigned int _frame ) const						{ return m_verts[_frame]; };
		inline const GLInterleavedVertNormal3D *	framevert( unsigned int _frame, unsigned int _index ) const	{ return &m_verts[_frame][_index]; };
		
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
		GLVertIndice *					m_indices;
		
		GLInterleavedVertNormal3D	*	m_verts[256];
		CGMaths::CGAABB *				m_vertsaabb;
		
#pragma mark ---------------------------------------------------------
#pragma mark End Private Data
#pragma mark ---------------------------------------------------------
	};

};

#endif