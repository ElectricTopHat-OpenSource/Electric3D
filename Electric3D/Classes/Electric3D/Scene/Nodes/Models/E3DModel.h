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

namespace E3D	{ class E3DTexture; };
namespace E3D		{ class E3DMesh; };

namespace E3D 
{
	class E3DModel : public E3DSceneNode
	{
#pragma mark ---------------------------------------------------------
#pragma mark Constructor / Destructor
#pragma mark ---------------------------------------------------------
	public: // Functions
		
		E3DModel( NSString * _name, const E3D::E3DTexture * _texture )
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
		
		inline const BOOL isGeometry() const { return TRUE; };
		
		inline  const E3D::E3DTexture * texture() const			{ return m_texture; };
		virtual const E3D::E3DMesh * mesh() const = 0;
		
#pragma mark ---------------------------------------------------------
#pragma mark === End Public Functions  ===
#pragma mark ---------------------------------------------------------
		
#pragma mark ---------------------------------------------------------
#pragma mark === Protected Data  ===
#pragma mark ---------------------------------------------------------
	protected: // Data
		
		const E3D::E3DTexture *	m_texture;
		
#pragma mark ---------------------------------------------------------
#pragma mark === End Protected Data  ===
#pragma mark ---------------------------------------------------------
	};
};

#endif