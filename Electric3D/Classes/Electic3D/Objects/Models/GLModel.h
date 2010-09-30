//
//  GLModel.h
//  Electric3D
//
//  Created by Robert McDowell on 22/09/2010.
//  Copyright 2010 Electric TopHat Ltd. All rights reserved.
//

#if !defined(__GLModel_h__)
#define __GLModel_h__

#import "GLObject.h"
#import "GLVertexTypes.h"
#import "GLModelTypes.h"
#import "CGMaths.h"
#import "GLColors.h"

namespace GLMeshes		{ class GLMesh; };
namespace GLTextures	{ class GLTexture; };

namespace GLObjects
{
	class GLModel : public GLObject
	{
#pragma mark ---------------------------------------------------------
#pragma mark Constructor / Destructor
#pragma mark ---------------------------------------------------------
	public: // Functions
		
		GLModel( NSString * _name = nil );
		virtual ~GLModel();
		
#pragma mark ---------------------------------------------------------
#pragma mark End Constructor / Destructor
#pragma mark ---------------------------------------------------------
		
#pragma mark ---------------------------------------------------------
#pragma mark === Public Functions  ===
#pragma mark ---------------------------------------------------------
	public: // Functions
		
		virtual eGLObjectType type() const { return eGLObjectType_Model; };
		virtual eGLModelType  subtype() const = 0;
		
		inline void setTexture(const GLTextures::GLTexture * _texture) { m_texture = _texture; };
		inline const GLTextures::GLTexture * texture() const { return m_texture; };
		
		virtual void setMesh(const GLMeshes::GLMesh * _mesh) = 0;
		virtual const GLMeshes::GLMesh * mesh() const = 0;
		
		virtual NSUInteger numverts() const = 0;
		virtual const GLInterleavedVert3D* verts() const = 0;
		
		inline BOOL isHidden() const { return m_hidden; };
		inline void setHidden( BOOL _hidden ) { m_hidden = _hidden; };
		
		inline GLColors::GLColor & color()										{ return m_color; };
		inline const GLColors::GLColor & color() const							{ return m_color; };
		inline void setColor( const GLColors::GLColor & _color )				{ return m_color.setColor(_color); };
		
		inline CGMaths::CGMatrix4x4 & transform()								{ return m_transform; };
		inline const CGMaths::CGMatrix4x4 & transform() const					{ return m_transform; };
		inline void setTransform( const CGMaths::CGMatrix4x4 & _transform )		{ m_transform = _transform; };
		
		inline CGMaths::CGVector3D postion() const								{ return CGMaths::CGMatrix4x4GetTranslation( m_transform ); };
		inline void setPostion( const CGMaths::CGVector3D & _pos )				{ CGMaths::CGMatrix4x4SetTranslation( m_transform, _pos ); };
		
#pragma mark ---------------------------------------------------------
#pragma mark === End Public Functions  ===
#pragma mark ---------------------------------------------------------
		
#pragma mark ---------------------------------------------------------
#pragma mark === Private Data  ===
#pragma mark ---------------------------------------------------------
	private: // Data
		
		GLColors::GLColor				m_color;
		CGMaths::CGMatrix4x4			m_transform;
		
		const GLTextures::GLTexture *	m_texture;
		
		BOOL							m_hidden;
		
#pragma mark ---------------------------------------------------------
#pragma mark === Private Data  ===
#pragma mark ---------------------------------------------------------
	};	
};

#endif