//
//  E3DManagers.h
//  Electric3D
//
//  Created by Robert McDowell on 28/10/2010.
//  Copyright 2010 Electric TopHat Ltd. All rights reserved.
//


#if !defined(__E3DManagers_h__)
#define __E3DManagers_h__

namespace E3D			{ class E3DMeshManager; };
namespace E3D			{ class E3DTextureManager; };
namespace E3D		{ class E3DSpriteManager; };
namespace E3D			{ class E3DSplineManager; };

namespace E3D
{
	class E3DManagers
	{
#pragma mark ---------------------------------------------------------
#pragma mark Constructor / Destructor
#pragma mark ---------------------------------------------------------
	public: // Functions
		
		E3DManagers();
		virtual ~E3DManagers();
		
#pragma mark ---------------------------------------------------------
#pragma mark End Constructor / Destructor
#pragma mark ---------------------------------------------------------	
		
#pragma mark ---------------------------------------------------------
#pragma mark === Public Functions  ===
#pragma mark ---------------------------------------------------------
	public: // Functions
		
		inline E3D::E3DMeshManager *			meshes()	{ return m_meshManager; };
		inline E3D::E3DTextureManager *			textures()	{ return m_textureManager; };
		inline E3D::E3DSpriteManager *		sprites()	{ return m_spriteManager; };
		inline E3D::E3DSplineManager *			splines()	{ return m_splineManager; };
		
#pragma mark ---------------------------------------------------------
#pragma mark === End Public Functions  ===
#pragma mark ---------------------------------------------------------
		
#pragma mark ---------------------------------------------------------
#pragma mark Private Data
#pragma mark ---------------------------------------------------------
	private: // Data
		
		E3D::E3DMeshManager *			m_meshManager;
		E3D::E3DTextureManager *	m_textureManager;
		E3D::E3DSpriteManager *	m_spriteManager;
		E3D::E3DSplineManager *			m_splineManager;
		
#pragma mark ---------------------------------------------------------
#pragma mark End Private Data
#pragma mark ---------------------------------------------------------
	};
};

#endif
