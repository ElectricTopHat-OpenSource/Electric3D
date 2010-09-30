//
//  GLView.h
//  Electric3D
//
//  Created by Robert McDowell on 22/09/2010.
//  Copyright 2010 Electric TopHat Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>

@class GLRenderer;

namespace GLObjects		{ class GLSceneFactory; };
namespace GLMeshes		{ class GLMeshFactory; };
namespace GLTextures	{ class GLTextureFactory; };
namespace GLSprites		{ class GLSpriteFactory; };

namespace GLCameras		{ class GLCamera; };
namespace GLCameras		{ class GLPerspective; };
namespace GLObjects		{ class GLScene; };

// ----------------------------------
// GLView 
// ----------------------------------
@interface GLView : UIView
{
@private	
	// GL Render
	GLRenderer *		m_renderer;
}

@property (nonatomic,readonly) GLCameras::GLCamera *			camera;
@property (nonatomic,readonly) GLCameras::GLPerspective *		perspective;

@property (nonatomic,readonly) GLMeshes::GLMeshFactory *		meshes;
@property (nonatomic,readonly) GLTextures::GLTextureFactory *	textures;
@property (nonatomic,readonly) GLSprites::GLSpriteFactory *		sprites;

- (void) drawView:(id)_sender;
- (void) didRotate:(NSNotification*)_notification;

- (BOOL) containsScene:(GLObjects::GLScene*)_scene;
- (void) addScene:(GLObjects::GLScene*)_scene;
- (void) removeScene:(GLObjects::GLScene*)_scene;

@end
