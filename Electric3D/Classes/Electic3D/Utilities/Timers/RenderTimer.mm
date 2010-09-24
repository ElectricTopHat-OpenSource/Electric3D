//
//  RenderTimer.m
//  Electric3D
//
//  Created by Robert McDowell on 21/09/2010.
//  Copyright 2010 Electric TopHat Ltd. All rights reserved.
//

#import "RenderTimer.h"
#import <QuartzCore/QuartzCore.h>

@implementation RenderTimer

#pragma mark ---------------------------------------------------------
#pragma mark === Properties  ===
#pragma mark ---------------------------------------------------------

@synthesize running;
@synthesize delegate;
@synthesize selector;

@synthesize displayLinkTiming;
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
		// A system version of 3.1 or greater is required to use CADisplayLink. The NSTimer
		// class is used as fallback when it isn't available.
		NSString *reqSysVer = @"3.1";
		NSString *currSysVer = [[UIDevice currentDevice] systemVersion];
		if ([currSysVer compare:reqSysVer options:NSNumericSearch] != NSOrderedAscending)
		{
			displayLinkSupported = TRUE;
		}
		else
		{
			displayLinkSupported = FALSE;
		}
		
		displayLinkTiming	= 1;
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
        if (displayLinkSupported)
        {
            // CADisplayLink is API new to iPhone SDK 3.1. Compiling against earlier versions will result in a warning, but can be dismissed
            // if the system version runtime check for CADisplayLink exists in -initWithCoder:. The runtime check ensures this code will
            // not be called in system versions earlier than 3.1.
            displayLink = [NSClassFromString(@"CADisplayLink") displayLinkWithTarget:delegate selector:selector];
            [displayLink setFrameInterval:displayLinkTiming];
            [displayLink addToRunLoop:[NSRunLoop currentRunLoop] forMode:NSDefaultRunLoopMode];
        }
        else
		{
            normalTimer = [NSTimer scheduledTimerWithTimeInterval:normalTimerTiming target:delegate selector:selector userInfo:nil repeats:TRUE];
		}
		
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
        if (displayLinkSupported)
        {
            [displayLink invalidate];
            displayLink = nil;
        }
        else
        {
            [normalTimer invalidate];
            normalTimer = nil;
        }
		
        running = FALSE;
    }
}

#pragma mark ---------------------------------------------------------
#pragma mark === End Public  ===
#pragma mark ---------------------------------------------------------

@end
