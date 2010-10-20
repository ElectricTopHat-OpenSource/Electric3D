//
//  TestSplineLoader.h
//  Electric3D
//
//  Created by Robert McDowell on 18/10/2010.
//  Copyright 2010 Electric TopHat Ltd. All rights reserved.
//

#import <Foundation/Foundation.h>

namespace E3D { class E3DSplineFactory; };

@interface TestSplineLoader : UIView
{
@private
	UITextView *					display;
	
	NSInteger						state;
	
	E3D::E3DSplineFactory *		factory;
}

- (BOOL) canRotate;

- (void) update:(id)_sender;

@end
