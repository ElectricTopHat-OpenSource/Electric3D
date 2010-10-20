//
//  E3DModelStatic.h
//  Electric3D
//
//  Created by Robert McDowell on 19/10/2010.
//  Copyright 2010 Electric TopHat Ltd. All rights reserved.
//

#if !defined(__E3DModelStatic_h__)
#define __E3DModelStatic_h__

#import "E3DModel.h"

namespace GLMeshes		{ class GLMesh; };

namespace E3D  
{
	class E3DModelStatic : public E3DModel
	{
#pragma mark ---------------------------------------------------------
#pragma mark Constructor / Destructor
#pragma mark ---------------------------------------------------------
	public: // Functions
		
		E3DModelStatic( NSString * _name, const GLMeshes::GLMesh * _mesh, const GLTextures::GLTexture * _texture = nil );
		virtual ~E3DModelStatic();
		
#pragma mark ---------------------------------------------------------
#pragma mark End Constructor / Destructor
#pragma mark ---------------------------------------------------------
		
#pragma mark ---------------------------------------------------------
#pragma mark === Public Functions  ===
#pragma mark ---------------------------------------------------------
	public: // Functions
		
		inline eE3DSceneNodeType type() const { return eE3DSceneNodeType_ModelStatic; };
		
		inline const GLMeshes::GLMesh * mesh() const { return m_mesh; }
		
		virtual const CGMaths::CGAABB aabb() const;
		virtual const CGMaths::CGSphere sphere() const;
		
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