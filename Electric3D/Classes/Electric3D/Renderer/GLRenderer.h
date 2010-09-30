//
//  GLRenderer.h
//  Electric3D
//
//  Created by Robert McDowell on 22/09/2010.
//  Copyright 2010 Electric TopHat Ltd. All rights reserved.
//

#import <Foundation/Foundation.h>


#pragma mark ---------------------------------------------------------
#pragma mark === Forward Declaration  ===
#pragma mark ---------------------------------------------------------

@class CAEAGLLayer;
@class EAGLContext;

namespace GLRenderers	{ class IRenderEngine; };
namespace GLScene		{ class GLSceneFactory; };
namespace GLMeshes		{ class GLMeshFactory; };
namespace GLTextures	{ class GLTextureFactory; };
namespace GLSprites		{ class GLSpriteFactory; };

namespace GLCameras		{ class GLCamera; };
namespace GLCameras		{ class GLPerspective; };

namespace GLObjects		{ class GLScene; };

#pragma mark ---------------------------------------------------------
#pragma mark === End Forward Declaration  ===
#pragma mark ---------------------------------------------------------


@interface GLRenderer : NSObject 
{
@private
	// render layer
	CAEAGLLayer *					m_layer;
	
	// GL Context
	EAGLContext *					m_context;
	
	// GL Render
	GLRenderers::IRenderEngine *	m_renderer;
	
	// Container classes
	GLMeshes::GLMeshFactory *		m_meshFactory;
	GLTextures::GLTextureFactory *	m_textureFactory;
	GLSprites::GLSpriteFactory *	m_spriteFactory;
}

@property (nonatomic,readonly) GLCameras::GLCamera *			camera;
@property (nonatomic,readonly) GLCameras::GLPerspective *		perspective;

@property (nonatomic,readonly) GLMeshes::GLMeshFactory *		meshes;
@property (nonatomic,readonly) GLTextures::GLTextureFactory *	textures;
@property (nonatomic,readonly) GLSprites::GLSpriteFactory *		sprites;

- (id) initWithLayer:(CAEAGLLayer*)_layer withClearColor:(UIColor*)_clearColor;

- (void) rebindContext;
- (void) render:(id)_sender;

- (BOOL) containsScene:(GLObjects::GLScene*)_scene;
- (void) addScene:(GLObjects::GLScene*)_scene;
- (void) removeScene:(GLObjects::GLScene*)_scene;

@end
