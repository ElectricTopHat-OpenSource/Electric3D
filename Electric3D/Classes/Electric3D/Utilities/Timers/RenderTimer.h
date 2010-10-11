//
//  RenderTimer.h
//  Electric3D
//
//  Created by Robert McDowell on 21/09/2010.
//  Copyright 2010 Electric TopHat Ltd. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TimerTypes.h"

@interface RenderTimer : NSObject 
{
	// ------------------------------------------------
    // Use of the CADisplayLink class is the preferred 
	// method for controlling your animation timing.
    // CADisplayLink will link to the main display and 
	// fire every vsync when added to a given run-loop.
    // The NSTimer class is used only as fallback when 
	// running on a pre 3.1 device where CADisplayLink
    // isn't available.
    // ------------------------------------------------
	BOOL			displayLinkSupported;
	id				displayLink;
	// ------------------------------------------------
	
	// ------------------------------------------------
	// Basic animation timer for pre 3.1
	// ------------------------------------------------
    NSTimer *		normalTimer;
	// ------------------------------------------------
	
	// ------------------------------------------------
	// Time Interval
	// ------------------------------------------------
	eTimeInterval	timeInteval;
	// ------------------------------------------------
	
	// ------------------------------------------------
	// Delegate and callback
	// ------------------------------------------------
	id				delegate;
	SEL				selector;
	// ------------------------------------------------
	
	// ------------------------------------------------
	// Is the timer running
	// ------------------------------------------------
	BOOL			running;
	// ------------------------------------------------
}

@property (nonatomic,readonly)	BOOL	running;

@property (nonatomic,retain)	id		delegate;
@property (nonatomic)			SEL		selector;

@property (nonatomic)			eTimeInterval	timeInteval;

- (void) startTimer;
- (void) stopTimer;

@end
