//
//  CGTestSplineLoader.mm
//  Electric3D
//
//  Created by Robert McDowell on 18/10/2010.
//  Copyright 2010 Electric TopHat Ltd. All rights reserved.
//

#import "TestSplineLoader.h"
#import "E3DSplineManager.h"

@interface TestSplineLoader (PrivateMethods)

- (void) initialization;
- (void) teardown;

- (void) print:(NSString*)_text result:(BOOL)_result;
- (void) print:(NSString*)_text;

@end

@implementation TestSplineLoader

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
// canRotate
// ------------------------------------------
- (BOOL) canRotate
{
	return FALSE;
}

// ------------------------------------------
// update Function
// ------------------------------------------
- (void) update:(id)_sender
{
	BOOL update = TRUE;
	switch (state) 
	{
		case 0:
		{
			const E3D::E3DSpline * spline = factory->load( @"SPLINE_2Points", @"3ds" );			
			[self print:@"3ds 2 point spline loaded" result:spline!=nil];
			if ( spline )
			{
				factory->release(spline);
			}
			break;
		}
		case 1:
		{
			const E3D::E3DSpline * spline = factory->load( @"SPLINE_4Points", @"3ds" );			
			[self print:@"3ds 4 point spline loaded" result:spline!=nil];
			if ( spline )
			{
				factory->release(spline);
			}
			break;
		}
		default:
			update = FALSE;
			break;
	} 
	state += (update) ? 1 : 0;
	
	[display scrollRangeToVisible:NSMakeRange([[display text] length]-1, 0)];
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
	display = [[UITextView alloc] initWithFrame:[self bounds]];
	//[display setEditable:FALSE];
	//[display setExclusiveTouch:FALSE];
	[display setUserInteractionEnabled:FALSE];
	[self addSubview:display];
	[self print:@"Running...."];
	
	factory = new E3D::E3DSplineManager();
	
	state = 0;
}

// ------------------------------------------
// Teardown
// ------------------------------------------
- (void) teardown
{	
	[display removeFromSuperview];
	SAFE_RELEASE( display );
	
	SAFE_DELETE( factory );
}

// ------------------------------------------
// print text in the window
// ------------------------------------------
- (void) print:(NSString*)_text result:(BOOL)_result
{
	NSString * result = (_result) ? @"TRUE" : @"FALSE";
	[self print:[NSString stringWithFormat:@"%@ : %@", result, _text]];
}

// ------------------------------------------
// print text in the window
// ------------------------------------------
- (void) print:(NSString*)_text
{
	if ( _text)
	{
		NSString * currentText = [display text];
		[display setText:[NSString stringWithFormat:@"%@%@\n",currentText, _text]];
	}
}

#pragma mark ---------------------------------------------------------
#pragma mark === End Private Functions  ===
#pragma mark ---------------------------------------------------------

@end