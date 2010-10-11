//
//  DeltaTimer.h
//  Electric3D
//
//  Created by Robert McDowell on 11/10/2010.
//  Copyright 2010 Electric TopHat Ltd. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface DeltaTimer : NSObject 
{
@private
	NSTimeInterval	lastInterval;
	NSTimeInterval	delta;
}

@property (nonatomic,readonly) NSTimeInterval delta;

- (void)			reset;	
- (NSTimeInterval)	update;

@end
