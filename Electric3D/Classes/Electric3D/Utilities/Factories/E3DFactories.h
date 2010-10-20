/*
 *  E3DFactories.h
 *  Electric3D
 *
 *  Created by Robert McDowell on 19/10/2010.
 *  Copyright 2010 Electric TopHat Ltd. All rights reserved.
 *
 */

#if !defined(__E3DFactories_h__)
#define __E3DFactories_h__

#import "GLMeshFactory.h"
#import "GLTextureFactory.h"
#import "GLSpriteFactory.h"
#import "E3DSplineFactory.h"

namespace E3D
{
	class E3DFactories
	{
#pragma mark ---------------------------------------------------------
#pragma mark Constructor / Destructor
#pragma mark ---------------------------------------------------------
	public: // Functions
		
		E3DFactories()
		{
			// --------------------------------------
			// Create the container objects
			// --------------------------------------
			m_meshFactory		= new GLMeshes::GLMeshFactory();
			m_textureFactory	= new GLTextures::GLTextureFactory();
			m_spriteFactory		= new GLSprites::GLSpriteFactory( m_textureFactory );
			m_splineFactory		= new E3D::E3DSplineFactory();
			// --------------------------------------
		}
		virtual ~E3DFactories()
		{
			// --------------------------------------
			// Teardown the container classes
			// --------------------------------------
			SAFE_DELETE( m_splineFactory );
			SAFE_DELETE( m_spriteFactory );
			SAFE_DELETE( m_textureFactory );
			SAFE_DELETE( m_meshFactory );
			// --------------------------------------
		}
		
#pragma mark ---------------------------------------------------------
#pragma mark End Constructor / Destructor
#pragma mark ---------------------------------------------------------	
		
#pragma mark ---------------------------------------------------------
#pragma mark === Public Functions  ===
#pragma mark ---------------------------------------------------------
	public: // Functions

		inline GLMeshes::GLMeshFactory *		meshes()	{ return m_meshFactory; };
		inline GLTextures::GLTextureFactory *	textures()	{ return m_textureFactory; };
		inline GLSprites::GLSpriteFactory *		sprites()	{ return m_spriteFactory; };
		inline E3D::E3DSplineFactory *			splines()	{ return m_splineFactory; };
		
#pragma mark ---------------------------------------------------------
#pragma mark === End Public Functions  ===
#pragma mark ---------------------------------------------------------
		
#pragma mark ---------------------------------------------------------
#pragma mark Private Data
#pragma mark ---------------------------------------------------------
	private: // Data
		
		GLMeshes::GLMeshFactory *		m_meshFactory;
		GLTextures::GLTextureFactory *	m_textureFactory;
		GLSprites::GLSpriteFactory *	m_spriteFactory;
		E3D::E3DSplineFactory *			m_splineFactory;

#pragma mark ---------------------------------------------------------
#pragma mark End Private Data
#pragma mark ---------------------------------------------------------
	};
};

#endif