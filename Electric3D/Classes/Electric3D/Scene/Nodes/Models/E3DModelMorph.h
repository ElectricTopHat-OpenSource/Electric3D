//
//  E3DModelMorph.h
//  Electric3D
//
//  Created by Robert McDowell on 19/10/2010.
//  Copyright 2010 Electric TopHat Ltd. All rights reserved.
//

#if !defined(__E3DModelMorph_h__)
#define __E3DModelMorph_h__

#import "E3DModel.h"

namespace E3D		{ class E3DMeshMorph; };

namespace E3D  
{
	class E3DModelMorph : public E3DModel
	{
#pragma mark ---------------------------------------------------------
#pragma mark Constructor / Destructor
#pragma mark ---------------------------------------------------------
	public: // Functions
		
		E3DModelMorph( NSString * _name, const E3D::E3DMeshMorph * _mesh, const E3D::E3DTexture * _texture = nil );
		virtual ~E3DModelMorph();
		
#pragma mark ---------------------------------------------------------
#pragma mark End Constructor / Destructor
#pragma mark ---------------------------------------------------------
		
#pragma mark ---------------------------------------------------------
#pragma mark === Public Functions  ===
#pragma mark ---------------------------------------------------------
	public: // Functions
		
		inline eE3DSceneNodeType type() const { return eE3DSceneNodeType_ModelMorph; };
		
		const CGMaths::CGAABB aabb() const;
		const CGMaths::CGAABB aabb( NSUInteger _frame = 0 ) const;
		
		const CGMaths::CGSphere sphere() const;
		const CGMaths::CGSphere sphere( NSUInteger _frame = 0 ) const;
		
		inline const E3D::E3DMesh * mesh() const { return (E3D::E3DMesh*)m_mesh; }
		inline const E3D::E3DMeshMorph * meshVA() const { return m_mesh; };
		
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
		
		const E3D::E3DMeshMorph *	m_mesh;
		
		NSUInteger								m_startFrame;
		NSUInteger								m_targetFrame;
		float									m_blend;
		
#pragma mark ---------------------------------------------------------
#pragma mark === Private Data  ===
#pragma mark ---------------------------------------------------------
	};
};

#endif
