//
//  GLModel.h
//  Electric3D
//
//  Created by Robert McDowell on 22/09/2010.
//  Copyright 2010 Electric TopHat Ltd. All rights reserved.
//

#if !defined(__GLModel_h__)
#define __GLModel_h__

#include "GLObject.h"

namespace GLMeshes		{ class GLMesh; };
namespace GLTextures	{ class GLTexture; };

namespace GLObjects
{
	class GLModel : GLObject
	{
#pragma mark ---------------------------------------------------------
#pragma mark Constructor / Destructor
#pragma mark ---------------------------------------------------------
	public: // Functions
		
		GLModel();
		virtual ~GLModel();
		
#pragma mark ---------------------------------------------------------
#pragma mark End Constructor / Destructor
#pragma mark ---------------------------------------------------------
		
#pragma mark ---------------------------------------------------------
#pragma mark === Public Functions  ===
#pragma mark ---------------------------------------------------------
	public: // Functions
		
		eGLObjectType type() const { return eGLObjectType_Model; };
		
		// set the texture object
		inline void setTexture(const GLTextures::GLTexture * _texture) { m_texture = _texture; };
		// access the texture object
		inline const GLTextures::GLTexture * texture() const { return m_texture; };
		
		// set the mesh object
		inline void setMesh(const GLMeshes::GLMesh * _mesh) { m_mesh = _mesh; };
		// access the mesh object
		inline const GLMeshes::GLMesh * mesh() const { return m_mesh; };
		
#pragma mark ---------------------------------------------------------
#pragma mark === End Public Functions  ===
#pragma mark ---------------------------------------------------------
		
#pragma mark ---------------------------------------------------------
#pragma mark === Private Data  ===
#pragma mark ---------------------------------------------------------
	private: // Data
		
		const GLTextures::GLTexture *	m_texture;
		const GLMeshes::GLMesh *		m_mesh;
		
		
#pragma mark ---------------------------------------------------------
#pragma mark === Private Data  ===
#pragma mark ---------------------------------------------------------
	};	
};

#endif