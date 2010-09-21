//
//  Timer.h
//  Electric3D
//
//  Created by Robert McDowell on 21/09/2010.
//  Copyright 2010 Electric TopHat Ltd. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface Timer : NSObject 
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
	NSInteger		displayLinkTiming;	// default to 1 ( setting to 2 will half the render rate )
	// ------------------------------------------------
	
	// ------------------------------------------------
	// Basic animation timer for pre 3.1
	// ------------------------------------------------
    NSTimer *		normalTimer;
	NSTimeInterval	normalTimerTiming; // default to 60hz (1.0 / 60.0) ( set to 1.0 / 30.0 to half the frame rate )
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

@property (nonatomic)			NSInteger		displayLinkTiming;
@property (nonatomic)			NSTimeInterval	normalTimerTiming;

- (void) startTimer;
- (void) stopTimer;

@end
