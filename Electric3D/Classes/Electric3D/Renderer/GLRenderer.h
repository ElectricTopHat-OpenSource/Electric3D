//
//  GLRenderer.h
//  Electric3D
//
//  Created by Robert McDowell on 22/09/2010.
//  Copyright 2010 Electric TopHat Ltd. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CGMaths.h"

#pragma mark ---------------------------------------------------------
#pragma mark === Forward Declaration  ===
#pragma mark ---------------------------------------------------------

@class CAEAGLLayer;
@class EAGLContext;

namespace GLRenderers	{ class IRenderEngine; };

namespace E3D		{ class E3DScene; };

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
}

- (id) initWithLayer:(CAEAGLLayer*)_layer withClearColor:(UIColor*)_clearColor;

- (void) rebindContext;
- (void) render:(id)_sender;

- (void) setClearColor:(UIColor*)_color;

- (BOOL) containsScene:(E3D::E3DScene*)_scene;
- (void) addScene:(E3D::E3DScene*)_scene;
- (void) removeScene:(E3D::E3DScene*)_scene;

@end
