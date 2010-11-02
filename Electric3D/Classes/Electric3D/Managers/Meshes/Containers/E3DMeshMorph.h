//
//  E3DMeshMorph.h
//  Electric3D
//
//  Created by Robert McDowell on 23/09/2010.
//  Copyright 2010 Electric TopHat Ltd. All rights reserved.
//

#if !defined(__E3DMeshMorph_h__)
#define __E3DMeshMorph_h__

#import "E3DMesh.h"
#import "CGMaths.h"
#import "GLVertexTypes.h"

namespace E3D 
{
#pragma mark ---------------------------------------------------------
#pragma mark Internal Consts 
#pragma mark ---------------------------------------------------------

	extern const int _MMFileIdent;
	extern const int _MMFileVersion;
	
#pragma mark ---------------------------------------------------------
#pragma mark End Internal Consts 
#pragma mark ---------------------------------------------------------
	
#pragma mark ---------------------------------------------------------
#pragma mark File Header
#pragma mark ---------------------------------------------------------
	
	typedef struct
	{
		unsigned int	numframes;
		unsigned int	numverts;
		unsigned int	numindices;
		CGMaths::CGAABB aabb;
		
	} E3DMeshMorphInfo;
	
#pragma mark ---------------------------------------------------------
#pragma mark End File Header
#pragma mark ---------------------------------------------------------
	
	class E3DMeshMorph : public E3DMesh
	{
		friend class E3DMeshManager;
		
#pragma mark ---------------------------------------------------------
#pragma mark Constructor / Destructor
#pragma mark ---------------------------------------------------------
	public: // Functions
		
		E3DMeshMorph( void * _buffer, unsigned int _length, NSString * _name = nil );
		E3DMeshMorph( NSData *	_data, NSString * _name = nil );
		E3DMeshMorph( const E3DMeshMorphInfo & _info, NSString * _name = nil );
		virtual ~E3DMeshMorph();

#pragma mark ---------------------------------------------------------
#pragma mark End Constructor / Destructor
#pragma mark ---------------------------------------------------------
		
#pragma mark ---------------------------------------------------------
#pragma mark === Public Functions  ===
#pragma mark ---------------------------------------------------------
	public: // Functions
		
		inline eE3DMeshType		type() const	{ return eE3DMeshType_Morph; };
		inline const NSData *	data() const	{ return m_data; };
		inline BOOL				isValid() const	{ return m_data != nil; };
		
		inline const NSUInteger				numverts() const		{ return m_info->numverts; };
		inline const NSUInteger				numindices() const		{ return m_info->numindices; };
		inline const NSUInteger				numframes() const		{ return m_info->numframes; };
		
		inline const CGMaths::CGAABB &		aabb() const						{ return m_info->aabb; };
		inline const CGMaths::CGAABB &		aabb( unsigned int _frame )	const	{ return m_vertsaabb[_frame]; }
		const CGMaths::CGAABB &				aabb( unsigned int _frame1, unsigned int _frame2, float _interp ) const;
		
		inline const CGMaths::CGSphere		sphere() const						{ return CGMaths::CGSphereMake(aabb()); };
		inline const CGMaths::CGSphere		sphere( unsigned int _frame ) const	{ return CGMaths::CGSphereMake(aabb(_frame)); };
		inline const CGMaths::CGSphere		sphere( unsigned int _frame1, unsigned int _frame2, float _interp ) const { return CGMaths::CGSphereMake(aabb(_frame1,_frame2,_interp)); };
		
		inline const GLInterleavedVert3D *	verts() const						{ return m_iterpverts; };
		
		inline const GLVertIndice *			indices() const						{ return m_indices; };
		
		// get a vert buffer with the interped verts
		const GLInterleavedVert3D *					interpverts( unsigned int _frame ) const;
		const GLInterleavedVert3D *					interpverts( unsigned int _frame1, unsigned int _frame2, float _interp ) const;
		
		inline const _GLVert3D *					frameverts( unsigned int _frame ) const						{ return m_verts[_frame]; };
		inline const _GLVert3D *					framevert( unsigned int _frame, unsigned int _index ) const	{ return &m_verts[_frame][_index]; };
		
#pragma mark ---------------------------------------------------------
#pragma mark === End Public Functions  ===
#pragma mark ---------------------------------------------------------
		
#pragma mark ---------------------------------------------------------
#pragma mark === Private Functions  ===
#pragma mark ---------------------------------------------------------
	private:

		BOOL setup();
					 
		inline void							setaabb( CGMaths::CGAABB & _aabb )	{ m_info->aabb = _aabb; };
		inline void							setaabb( unsigned int _frame, CGMaths::CGAABB & _aabb )	{ m_vertsaabb[_frame] = _aabb; };
		
		// get a writeable version of the vert buffer
		inline GLInterleavedVert3D *	interpverts()						{ return m_iterpverts; };
		inline GLVertIndice *			indices()							{ return m_indices; };
		inline _GLVert3D *				frameverts( unsigned int _frame )	{ return m_verts[_frame]; };

#pragma mark ---------------------------------------------------------
#pragma mark === End Private Functions  ===
#pragma mark ---------------------------------------------------------
		
#pragma mark ---------------------------------------------------------
#pragma mark Private Data
#pragma mark ---------------------------------------------------------
	private: // Data
		
		NSData *						m_data;
		
		E3DMeshFileHeader *				m_header;
		E3DMeshMorphInfo *				m_info;
		GLInterleavedVert3D *			m_iterpverts;
		GLVertIndice *					m_indices;
		
		_GLVert3D *						m_verts[256];
		CGMaths::CGAABB *				m_vertsaabb;
		
#pragma mark ---------------------------------------------------------
#pragma mark End Private Data
#pragma mark ---------------------------------------------------------
	};

};

#endif