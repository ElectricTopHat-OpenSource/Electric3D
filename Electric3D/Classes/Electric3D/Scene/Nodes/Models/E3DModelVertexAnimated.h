//
//  E3DModelVertexAnimated.h
//  Electric3D
//
//  Created by Robert McDowell on 19/10/2010.
//  Copyright 2010 Electric TopHat Ltd. All rights reserved.
//

#if !defined(__E3DModelVertexAnimated_h__)
#define __E3DModelVertexAnimated_h__

#import "E3DModel.h"

namespace GLMeshes		{ class GLMeshVertexAnimation; };

namespace E3D  
{
	class E3DModelVertexAnimated : public E3DModel
	{
#pragma mark ---------------------------------------------------------
#pragma mark Constructor / Destructor
#pragma mark ---------------------------------------------------------
	public: // Functions
		
		E3DModelVertexAnimated( NSString * _name, const GLMeshes::GLMeshVertexAnimation * _mesh, const GLTextures::GLTexture * _texture = nil );
		virtual ~E3DModelVertexAnimated();
		
#pragma mark ---------------------------------------------------------
#pragma mark End Constructor / Destructor
#pragma mark ---------------------------------------------------------
		
#pragma mark ---------------------------------------------------------
#pragma mark === Public Functions  ===
#pragma mark ---------------------------------------------------------
	public: // Functions
		
		inline eE3DSceneNodeType type() const { return eE3DSceneNodeType_ModelVertexAnimated; };
		
		virtual const CGMaths::CGAABB aabb() const;
		virtual const CGMaths::CGSphere sphere() const;
		
		inline const GLMeshes::GLMesh * mesh() const { return (GLMeshes::GLMesh*)m_mesh; }
		inline const GLMeshes::GLMeshVertexAnimation * meshVA() const { return m_mesh; };
		
		inline NSUInteger startFrame() const		{ return m_startFrame; };
		inline NSUInteger targetFrame() const		{ return m_targetFrame; };
		inline float blendValue() const				{ return m_blend; };
		NSUInteger numFrames() const;
		
		void setStartFrame( NSUInteger _startFrame );
		void setTargetFrame( NSUInteger _targetFrame );
		void setBlendValue( float _blend );
				
#pragma mark ---------------------------------------------------------
#pragma mark === End Public Functions  ===
#pragma mark ---------------------------------------------------------
		
#pragma mark ---------------------------------------------------------
#pragma mark === Private Data  ===
#pragma mark ---------------------------------------------------------
	private: // Data
		
		const GLMeshes::GLMeshVertexAnimation *	m_mesh;
		
		NSUInteger								m_startFrame;
		NSUInteger								m_targetFrame;
		float									m_blend;
		
#pragma mark ---------------------------------------------------------
#pragma mark === Private Data  ===
#pragma mark ---------------------------------------------------------
	};
};

#endif
