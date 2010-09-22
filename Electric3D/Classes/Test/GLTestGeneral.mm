//
//  GLTestGeneral.m
//  Electric3D
//
//  Created by Robert McDowell on 22/09/2010.
//  Copyright 2010 Electric TopHat Ltd. All rights reserved.
//

#import "GLTestGeneral.h"

@interface GLTestGeneral (PrivateMethods)

- (void) initialization;
- (void) teardown;

@end

@implementation GLTestGeneral

#pragma mark ---------------------------------------------------------
#pragma mark === Constructor / Destructor Functions  ===
#pragma mark ---------------------------------------------------------

// ------------------------------------------
// intialisation via nib
// ------------------------------------------
- (id)initWithCoder:(NSCoder*)coder 
{
	if ((self = [super initWithCoder:coder])) 
	{
		// Initialization code
		[self initialization];
	}
	return self;
}

// ------------------------------------------
// intialisation using the frame
// ------------------------------------------
- (id)initWithFrame:(CGRect)frame 
{
    if (self = [super initWithFrame:frame]) 
	{
        // Initialization code
		[self initialization];
    }
    return self;
}

// ------------------------------------------
// dealloc
// ------------------------------------------
- (void)dealloc 
{	
	[self teardown];
	
    [super dealloc];
}

#pragma mark ---------------------------------------------------------
#pragma mark === End Constructor / Destructor Functions  ===
#pragma mark ---------------------------------------------------------

#pragma mark ---------------------------------------------------------
#pragma mark === Public Functions  ===
#pragma mark ---------------------------------------------------------

// ------------------------------------------
// update Function
// ------------------------------------------
- (void) update
{
	[self drawView:nil];
}

#pragma mark ---------------------------------------------------------
#pragma mark === End Public Functions  ===
#pragma mark ---------------------------------------------------------

#pragma mark ---------------------------------------------------------
#pragma mark === Private Functions  ===
#pragma mark ---------------------------------------------------------

// ------------------------------------------
// Initialization
// ------------------------------------------
- (void) initialization
{	
}

// ------------------------------------------
// Teardown
// ------------------------------------------
- (void) teardown
{
}

#pragma mark ---------------------------------------------------------
#pragma mark === End Private Functions  ===
#pragma mark ---------------------------------------------------------

@end
