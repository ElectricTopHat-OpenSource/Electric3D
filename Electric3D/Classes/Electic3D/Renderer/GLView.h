//
//  GLView.h
//  Electric3D
//
//  Created by Robert McDowell on 22/09/2010.
//  Copyright 2010 Electric TopHat Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>

@class GLRenderer;

// ----------------------------------
// GLView 
// ----------------------------------
@interface GLView : UIView
{
@private	
	// GL Render
	GLRenderer *		m_renderer;
}

- (void) drawView:(id)_sender;
- (void) didRotate:(NSNotification*)_notification;

@end
