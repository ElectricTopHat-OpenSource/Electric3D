//
//  FPSTimer.h
//  Electric3D
//
//  Created by Robert McDowell on 11/10/2010.
//  Copyright 2010 Electric TopHat Ltd. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface FPSTimer : NSObject 
{
@private
	NSTimeInterval	lastInterval;
	NSUInteger		numFrames;
	NSUInteger		fps;
}

@property (nonatomic,readonly) NSUInteger fps;

- (void)		reset;	
- (NSInteger)	update;

@end
