//
//  GLTestTextureFactory.h
//  Electric3D
//
//  Created by Robert McDowell on 23/09/2010.
//  Copyright 2010 Electric TopHat Ltd. All rights reserved.
//

#import <Foundation/Foundation.h>

namespace GLTextures { class GLTextureFactory; };

@interface GLTestTextureFactory : UIView 
{
@private

	UITextView *				display;
	
	GLTextures::GLTextureFactory * factory;
}

- (BOOL) canRotate;

- (void) update;

@end
