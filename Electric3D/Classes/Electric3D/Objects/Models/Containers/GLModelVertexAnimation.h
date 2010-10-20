//
//  GLModelVertexAnimation.h
//  Electric3D
//
//  Created by Robert McDowell on 27/09/2010.
//  Copyright 2010 Electric TopHat Ltd. All rights reserved.
//

#if !defined(__GLModelVertexAnimation_h__)
#define __GLModelVertexAnimation_h__

#import "GLModelTypes.h"
#import "GLModel.h"

namespace GLMeshes		{ class GLMeshVertexAnimation; };

namespace GLObjects
{
	class GLModelVertexAnimation : public GLModel
	{
#pragma mark ---------------------------------------------------------
#pragma mark Constructor / Destructor
#pragma mark ---------------------------------------------------------
	public: // Functions
		
		GLModelVertexAnimation( NSString * _name = nil );
		virtual ~GLModelVertexAnimation();
		
#pragma mark ---------------------------------------------------------
#pragma mark End Constructor / Destructor
#pragma mark ---------------------------------------------------------
		
#pragma mark ---------------------------------------------------------
#pragma mark === Public Functions  ===
#pragma mark ---------------------------------------------------------
	public: // Functions
		
		inline eGLModelType subtype() const { return eGLModelType_VertexAnimation; };
		
		void setStartFrame( NSUInteger _startFrame );
		void setTargetFrame( NSUInteger _targetFrame );
		void setBlendValue( float _blend );
		
		NSUInteger numFrames() const;
		inline NSUInteger startFrame() const		{ return m_startFrame; };
		inline NSUInteger targetFrame() const		{ return m_targetFrame; };
		inline float blendValue() const				{ return m_blend; };
		
		virtual const CGMaths::CGAABB aabb() const;
		virtual const CGMaths::CGSphere sphere() const;
		
		virtual void setMesh(const GLMeshes::GLMesh * _mesh);
		virtual const GLMeshes::GLMesh * mesh() const;
		
		virtual NSUInteger numverts() const;
		virtual NSUInteger numindices() const;
		virtual const eGLVertListType vertListType() const;
		virtual const GLInterleavedVert3D * verts() const;
		virtual const GLVertIndice * indices() const;
		
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