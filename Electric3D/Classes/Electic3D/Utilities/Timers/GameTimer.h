//
//  GameTimer.h
//  Electric3D
//
//  Created by Robert McDowell on 25/09/2010.
//  Copyright 2010 Electric TopHat Ltd. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface GameTimer : NSObject 
{
	// ------------------------------------------------
	// Basic animation timer
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

@property (nonatomic)			NSTimeInterval	normalTimerTiming;

- (void) startTimer;
- (void) stopTimer;

@end
