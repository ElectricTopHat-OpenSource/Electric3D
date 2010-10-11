//
//  FPSTimer.m
//  Electric3D
//
//  Created by Robert McDowell on 11/10/2010.
//  Copyright 2010 Electric TopHat Ltd. All rights reserved.
//

#import "FPSTimer.h"


@implementation FPSTimer

#pragma mark ---------------------------------------------------------
#pragma mark === Properties  ===
#pragma mark ---------------------------------------------------------

@synthesize fps;

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
		[self reset];
	}
	return self;
}

// -----------------------------------------------------
// dealloc
// -----------------------------------------------------
- (void) dealloc
{	
	[super dealloc];
}

#pragma mark ---------------------------------------------------------
#pragma mark === End Constructor / Destructor  ===
#pragma mark ---------------------------------------------------------

#pragma mark ---------------------------------------------------------
#pragma mark === Public Functions ===
#pragma mark ---------------------------------------------------------

// -------------------------------------
// reset the FPS value
// -------------------------------------
- (void) reset
{
	lastInterval	= [NSDate timeIntervalSinceReferenceDate];
	numFrames		= 0;
	fps			= 0;
}

// -------------------------------------
// update the FPS value
// -------------------------------------
- (NSInteger) update
{
	NSTimeInterval current = [NSDate timeIntervalSinceReferenceDate];
	NSTimeInterval delta = -lastInterval - -current;
	numFrames++;
	if (delta >= 1.0)
	{
		fps				= (numFrames/delta);
		numFrames		= 0;
		lastInterval	= current;
	}
	return fps;
}

#pragma mark ---------------------------------------------------------
#pragma mark === End Public Functions ===
#pragma mark ---------------------------------------------------------

@end
