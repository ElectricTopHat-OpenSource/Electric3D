//
//  GLModelStatic.h
//  Electric3D
//
//  Created by Robert McDowell on 27/09/2010.
//  Copyright 2010 Electric TopHat Ltd. All rights reserved.
//

#if !defined(__GLModelStatic_h__)
#define __GLModelStatic_h__

#import "GLModelTypes.h"
#import "GLModel.h"
#import "GLVertexTypes.h"

namespace GLMeshes		{ class GLMesh; };

namespace GLObjects
{
	class GLModelStatic : public GLModel
	{
#pragma mark ---------------------------------------------------------
#pragma mark Constructor / Destructor
#pragma mark ---------------------------------------------------------
	public: // Functions
		
		GLModelStatic( NSString * _name = nil );
		virtual ~GLModelStatic();
		
#pragma mark ---------------------------------------------------------
#pragma mark End Constructor / Destructor
#pragma mark ---------------------------------------------------------
		
#pragma mark ---------------------------------------------------------
#pragma mark === Public Functions  ===
#pragma mark ---------------------------------------------------------
	public: // Functions
		
		inline eGLModelType subtype() const { return eGLModelType_Static; };
		
		virtual void setMesh(const GLMeshes::GLMesh * _mesh) { m_mesh = _mesh; };
		virtual const GLMeshes::GLMesh * mesh() const { return m_mesh; };
		
		virtual NSUInteger numverts() const;
		virtual const GLInterleavedVert3D* verts() const;
		
#pragma mark ---------------------------------------------------------
#pragma mark === End Public Functions  ===
#pragma mark ---------------------------------------------------------
		
#pragma mark ---------------------------------------------------------
#pragma mark === Private Data  ===
#pragma mark ---------------------------------------------------------
	private: // Data
		
		const GLMeshes::GLMesh *	m_mesh;
		
#pragma mark ---------------------------------------------------------
#pragma mark === Private Data  ===
#pragma mark ---------------------------------------------------------
	};	
};

#endif
