/*
 *  E3DModel.h
 *  Electric3D
 *
 *  Created by Robert McDowell on 19/10/2010.
 *  Copyright 2010 Electric TopHat Ltd. All rights reserved.
 *
 */

#if !defined(__E3DModel_h__)
#define __E3DModel_h__

#import "E3DSceneNodeTypes.h"
#import "E3DSceneNode.h"

namespace GLTextures	{ class GLTexture; };
namespace GLMeshes		{ class GLMesh; };

namespace E3D 
{
	class E3DModel : public E3DSceneNode
	{
#pragma mark ---------------------------------------------------------
#pragma mark Constructor / Destructor
#pragma mark ---------------------------------------------------------
	public: // Functions
		
		E3DModel( NSString * _name, const GLTextures::GLTexture * _texture )
		: E3DSceneNode	( _name )
		, m_texture		( _texture )
		{};
		virtual ~E3DModel() {};
		
#pragma mark ---------------------------------------------------------
#pragma mark End Constructor / Destructor
#pragma mark ---------------------------------------------------------
		
#pragma mark ---------------------------------------------------------
#pragma mark === Public Functions  ===
#pragma mark ---------------------------------------------------------
	public: // Functions
				
		inline  const GLTextures::GLTexture * texture() const			{ return m_texture; };
		virtual const GLMeshes::GLMesh * mesh() const = 0;
		
		virtual const CGMaths::CGAABB aabb() const = 0;
		virtual const CGMaths::CGSphere sphere() const = 0;
		
#pragma mark ---------------------------------------------------------
#pragma mark === End Public Functions  ===
#pragma mark ---------------------------------------------------------
		
#pragma mark ---------------------------------------------------------
#pragma mark === Protected Data  ===
#pragma mark ---------------------------------------------------------
	protected: // Data
		
		const GLTextures::GLTexture *	m_texture;
		
#pragma mark ---------------------------------------------------------
#pragma mark === End Protected Data  ===
#pragma mark ---------------------------------------------------------
	};
};

#endif