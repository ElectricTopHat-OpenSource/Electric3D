//
//  CGTestMathsAABB.h
//  Electric3D
//
//  Created by Robert McDowell on 30/09/2010.
//  Copyright 2010 Electric TopHat Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface CGTestMathsAABB : UIView 
{
@private
	UITextView *		display;
	
	NSInteger			state;
}

- (BOOL) canRotate;

- (void) update:(id)_sender;

@end
