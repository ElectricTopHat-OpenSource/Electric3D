//
//  GameTimer.m
//  Electric3D
//
//  Created by Robert McDowell on 25/09/2010.
//  Copyright 2010 Electric TopHat Ltd. All rights reserved.
//

#import "GameTimer.h"

@interface GameTimer (PrivateMethods)

- (NSTimeInterval) updateRate;

@end


@implementation GameTimer

#pragma mark ---------------------------------------------------------
#pragma mark === Properties  ===
#pragma mark ---------------------------------------------------------

@synthesize running;
@synthesize delegate;
@synthesize selector;

@synthesize timeInterval;

#pragma mark ---------------------------------------------------------
#pragma mark === End Properties  ===
#pragma mark ---------------------------------------------------------

#pragma mark ---------------------------------------------------------
#pragma mark === Constructor / Destructor  ===
#pragma mark ---------------------------------------------------------

// -----------------------------------------------------
// init
// -----------------------------------------------------
- (id) init
{
	if ( self = [super init] )
	{
		timeInterval	= eTimeInterval_60hz;
		running			= FALSE;
	}
	return self;
}

// -----------------------------------------------------
// dealloc
// -----------------------------------------------------
- (void) dealloc
{
	[self stopTimer];
	
	[super dealloc];
}

#pragma mark ---------------------------------------------------------
#pragma mark === End Constructor / Destructor  ===
#pragma mark ---------------------------------------------------------

#pragma mark ---------------------------------------------------------
#pragma mark === Public Functions ===
#pragma mark ---------------------------------------------------------

// -----------------------------------------------------
// start the Timer
// -----------------------------------------------------
- (void) startTimer
{
    if ( !running && delegate && selector )
    {
		timer = [NSTimer scheduledTimerWithTimeInterval:[self updateRate] target:delegate selector:selector userInfo:nil repeats:TRUE];
		[[NSRunLoop mainRunLoop] addTimer:timer forMode:NSRunLoopCommonModes];
		
        running = TRUE;
    }
}

// -----------------------------------------------------
// stop the Timer
// -----------------------------------------------------
- (void) stopTimer
{
    if ( running )
    {
		[timer invalidate];
		timer = nil;
		
        running = FALSE;
    }
}

#pragma mark ---------------------------------------------------------
#pragma mark === End Public Functions ===
#pragma mark ---------------------------------------------------------

#pragma mark ---------------------------------------------------------
#pragma mark === Private Functions  ===
#pragma mark ---------------------------------------------------------

// -----------------------------------------------------
// return the update time interval
// -----------------------------------------------------
- (NSTimeInterval) updateRate
{
	switch (timeInteval) 
	{
		default:
		case eTimeInterval_60hz:
			return 1.0f / 60.0f;
		case eTimeInterval_30hz:
			return 1.0f / 30.0f;
		case eTimeInterval_24hz:
			return 1.0f / 24.0f;
		case eTimeInterval_15hz:
			return 1.0f / 15.0f;
	}
}

#pragma mark ---------------------------------------------------------
#pragma mark === End Private Functions  ===
#pragma mark ---------------------------------------------------------

@end
