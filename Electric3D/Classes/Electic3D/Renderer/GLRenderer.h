//
//  GLRenderer.h
//  Electric3D
//
//  Created by Robert McDowell on 22/09/2010.
//  Copyright 2010 Electric TopHat Ltd. All rights reserved.
//

#import <Foundation/Foundation.h>

// ----------------------------------
// Forward Declaration
// ----------------------------------
@class CAEAGLLayer;
@class EAGLContext;
class IRenderEngine;
// ----------------------------------

@interface GLRenderer : NSObject 
{
@private
	// render layer
	CAEAGLLayer * m_layer;
	
	// GL Context
	EAGLContext *		m_context;
	
	// GL Render
	IRenderEngine *		m_renderer;
}

- (id) initWithLayer:(CAEAGLLayer*)_layer withClearColor:(UIColor*)_clearColor;

- (void) rebindContext;
- (void) render:(id)_sender;


@end
