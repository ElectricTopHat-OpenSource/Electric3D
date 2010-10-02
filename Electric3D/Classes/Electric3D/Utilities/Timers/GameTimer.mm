//
//  GameTimer.m
//  Electric3D
//
//  Created by Robert McDowell on 25/09/2010.
//  Copyright 2010 Electric TopHat Ltd. All rights reserved.
//

#import "GameTimer.h"


@implementation GameTimer

#pragma mark ---------------------------------------------------------
#pragma mark === Properties  ===
#pragma mark ---------------------------------------------------------

@synthesize running;
@synthesize delegate;
@synthesize selector;

@synthesize normalTimerTiming;

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
		normalTimerTiming	= 1.0f / 60.0f;
		
		running = FALSE;
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
#pragma mark === Public  ===
#pragma mark ---------------------------------------------------------

// -----------------------------------------------------
// start the Timer
// -----------------------------------------------------
- (void) startTimer
{
    if ( !running && delegate && selector )
    {
		normalTimer = [NSTimer scheduledTimerWithTimeInterval:normalTimerTiming target:delegate selector:selector userInfo:nil repeats:TRUE];
		[[NSRunLoop mainRunLoop] addTimer:normalTimer forMode:NSRunLoopCommonModes];	
		
        running = TRUE;
    }
}

// -----------------------------------------------------
// stop the Timer
// -----------------------------------------------------
- (void) stopTimer
{
    if (running)
    {
		[normalTimer invalidate];
		normalTimer = nil;
		
        running = FALSE;
    }
}

#pragma mark ---------------------------------------------------------
#pragma mark === End Public  ===
#pragma mark ---------------------------------------------------------

@end
