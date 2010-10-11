//
//  DeltaTimer.m
//  Electric3D
//
//  Created by Robert McDowell on 11/10/2010.
//  Copyright 2010 Electric TopHat Ltd. All rights reserved.
//

#import "DeltaTimer.h"


@implementation DeltaTimer

#pragma mark ---------------------------------------------------------
#pragma mark === Properties  ===
#pragma mark ---------------------------------------------------------

@synthesize delta;

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
	delta			= 0.0f;
}

// -------------------------------------
// update the FPS value
// -------------------------------------
- (NSTimeInterval) update
{
	NSTimeInterval current = [NSDate timeIntervalSinceReferenceDate];
	delta = -lastInterval - -current;
	lastInterval	= current;
	return delta;
}

#pragma mark ---------------------------------------------------------
#pragma mark === End Public Functions ===
#pragma mark ---------------------------------------------------------

@end
