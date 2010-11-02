//
//  E3DMeshStatic.h
//  Electric3D
//
//  Created by Robert McDowell on 23/09/2010.
//  Copyright 2010 Electric TopHat Ltd. All rights reserved.
//

#if !defined(__E3DMeshStatic_h__)
#define __E3DMeshStatic_h__

#import "E3DMesh.h"
#import "CGMaths.h"
#import "GLVertexTypes.h"

namespace E3D 
{
#pragma mark ---------------------------------------------------------
#pragma mark Internal Consts 
#pragma mark ---------------------------------------------------------
	
	// MeshStatic Identifyer
	extern const int _MSFileIdent;
	// MeshStatic format version
	extern const int _MSFileVersion;
	
#pragma mark ---------------------------------------------------------
#pragma mark End Internal Consts 
#pragma mark ---------------------------------------------------------
	
#pragma mark ---------------------------------------------------------
#pragma mark File Header
#pragma mark ---------------------------------------------------------
	
	typedef struct
	{
		unsigned int	numindices;
		unsigned int	numverts;
		CGMaths::CGAABB aabb;
		
	} E3DMeshStaticInfo;
	
#pragma mark ---------------------------------------------------------
#pragma mark End File Header
#pragma mark ---------------------------------------------------------
	
	class E3DMeshStatic : public E3DMesh
	{
		friend class E3DMeshManager;
		
#pragma mark ---------------------------------------------------------
#pragma mark Constructor / Destructor
#pragma mark ---------------------------------------------------------
	public: // Functions
		
		E3DMeshStatic( void * _buffer, unsigned int _length, NSString * _name = nil );
		E3DMeshStatic( NSData *	_data, NSString * _name = nil );
		E3DMeshStatic( const E3DMeshStaticInfo & _info, NSString * _name = nil );
		virtual ~E3DMeshStatic();
		
#pragma mark ---------------------------------------------------------
#pragma mark End Constructor / Destructor
#pragma mark ---------------------------------------------------------

#pragma mark ---------------------------------------------------------
#pragma mark === Public Functions  ===
#pragma mark ---------------------------------------------------------
	public: // Functions
		
		inline eE3DMeshType		type() const	{ return eE3DMeshType_Static; };
		inline const NSData *	data() const	{ return m_data; };
		inline BOOL				isValid() const	{ return m_data != nil; };
				
		inline const NSUInteger				numverts() const					{ return m_info->numverts; };
		inline const NSUInteger				numindices() const					{ return m_info->numindices; };
		
		inline const CGMaths::CGAABB &		aabb() const						{ return m_info->aabb; };
		inline const CGMaths::CGSphere		sphere() const						{ return CGMaths::CGSphereMake(m_info->aabb); };
		
		inline const GLInterleavedVert3D *	verts() const						{ return m_verts; };
		inline const GLVertIndice *			indices() const						{ return m_indices; };
		inline const GLInterleavedVert3D *	vert( unsigned int _index ) const	{ return &m_verts[_index]; };
		
#pragma mark ---------------------------------------------------------
#pragma mark === End Public Functions  ===
#pragma mark ---------------------------------------------------------
		
#pragma mark ---------------------------------------------------------
#pragma mark === Private Functions  ===
#pragma mark ---------------------------------------------------------
	private:
		
		BOOL setup();
		
		inline void							setaabb( CGMaths::CGAABB & _aabb )	{ m_info->aabb = _aabb; };
		
		inline GLInterleavedVert3D *		verts()								{ return m_verts; };
		inline GLVertIndice *				indices()							{ return m_indices; };

#pragma mark ---------------------------------------------------------
#pragma mark === End Private Functions  ===
#pragma mark ---------------------------------------------------------

#pragma mark ---------------------------------------------------------
#pragma mark Private Data
#pragma mark ---------------------------------------------------------
	private: // Data
		
		NSData *				m_data;
		
		E3DMeshFileHeader *		m_header;
		E3DMeshStaticInfo *		m_info;
		GLInterleavedVert3D	*	m_verts;
		GLVertIndice *			m_indices;

#pragma mark ---------------------------------------------------------
#pragma mark End Private Data
#pragma mark ---------------------------------------------------------
	};

};

#endif