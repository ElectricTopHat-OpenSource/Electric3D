//
//  TestMeshLoader.m
//  Electric3D
//
//  Created by Robert McDowell on 19/10/2010.
//  Copyright 2010 Electric TopHat Ltd. All rights reserved.
//

#import "TestMeshLoader.h"
#import "Electric3D.h"

@interface TestMeshLoader (PrivateMethods)

- (void) initialization;
- (void) teardown;

- (void) print:(NSString*)_text result:(BOOL)_result withTime:(NSTimeInterval)_time;
- (void) print:(NSString*)_text result:(BOOL)_result;
- (void) print:(NSString*)_text;

@end

@implementation TestMeshLoader

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
			NSTimeInterval start = [NSDate timeIntervalSinceReferenceDate];
			const E3D::E3DMesh * mesh = factory->load( @"MD2AnimatedMeshTest", @"md2" );
			NSTimeInterval end   = [NSDate timeIntervalSinceReferenceDate];
			
			[self print:@"Animated MD2 loaded" result:mesh!=nil withTime:(end-start)];
			if ( mesh )
			{
				factory->release(mesh);
			}
			break;
		}
		case 1:
		{
			NSTimeInterval start = [NSDate timeIntervalSinceReferenceDate];
			const E3D::E3DMesh * mesh = factory->load( @"MD2StaticMeshTest", @"md2" );
			NSTimeInterval end   = [NSDate timeIntervalSinceReferenceDate];
			
			[self print:@"Static MD2 loaded" result:mesh!=nil withTime:(end-start)];
			if ( mesh )
			{
				factory->release(mesh);
			}
			break;
		}
		case 2:
		{
			NSTimeInterval start = [NSDate timeIntervalSinceReferenceDate];
			const E3D::E3DMesh * mesh = factory->load( @"vertexpaintcube", @"3DS" );
			NSTimeInterval end   = [NSDate timeIntervalSinceReferenceDate];
			
			[self print:@"Static 3DS loaded" result:mesh!=nil withTime:(end-start)];
			if ( mesh )
			{
				factory->release(mesh);
			}
			break;
		}
		case 3:
		{
			NSTimeInterval start = [NSDate timeIntervalSinceReferenceDate];
			const E3D::E3DMesh * mesh = factory->load( @"vertex_cube", @"POD" );
			NSTimeInterval end   = [NSDate timeIntervalSinceReferenceDate];
			
			[self print:@"Static POD loaded" result:mesh!=nil withTime:(end-start)];
			if ( mesh )
			{
				factory->release(mesh);
			}
			break;
		}
		case 4:
		{
			const E3D::E3DMesh * mesh = factory->load( @"vertex_cube", @"POD" );
			if ( mesh )
			{
				NSTimeInterval start = [NSDate timeIntervalSinceReferenceDate];
				factory->save(mesh, [DOCUMENTS_PATH stringByAppendingPathComponent:@"MSCube.ms"] );
				NSTimeInterval end   = [NSDate timeIntervalSinceReferenceDate];
				
				[self print:@"Write MS File From POD" result:mesh!=nil withTime:(end-start)];
				if ( mesh )
				{
					factory->release(mesh);
				}
			}
			break;
		}
		case 5:
		{
			NSTimeInterval start = [NSDate timeIntervalSinceReferenceDate];
			const E3D::E3DMesh * mesh = factory->load( [DOCUMENTS_PATH stringByAppendingPathComponent:@"MSCube.ms"] );
			NSTimeInterval end   = [NSDate timeIntervalSinceReferenceDate];
			
			[self print:@"Static MS loaded From POD" result:mesh!=nil withTime:(end-start)];
			if ( mesh )
			{
				factory->release(mesh);
			}
			break;
		}
		case 6:
		{
			const E3D::E3DMesh * mesh = factory->load( @"MD2AnimatedMeshTest", @"md2" );
			if ( mesh )
			{
				NSTimeInterval start = [NSDate timeIntervalSinceReferenceDate];
				factory->save(mesh, [DOCUMENTS_PATH stringByAppendingPathComponent:@"MSCube.mva"] );
				NSTimeInterval end   = [NSDate timeIntervalSinceReferenceDate];
				
				[self print:@"Write MVA File From MD2" result:mesh!=nil withTime:(end-start)];
				if ( mesh )
				{
					factory->release(mesh);
				}
			}
			break;
		}
		case 7:
		{
			NSTimeInterval start = [NSDate timeIntervalSinceReferenceDate];
			const E3D::E3DMesh * mesh = factory->load( [DOCUMENTS_PATH stringByAppendingPathComponent:@"MSCube.mva"] );
			NSTimeInterval end   = [NSDate timeIntervalSinceReferenceDate];
			
			[self print:@"Static MVA loaded From MD2" result:mesh!=nil withTime:(end-start)];
			if ( mesh )
			{
				factory->release(mesh);
			}
			break;
		}
		case 8:
		{
			NSTimeInterval start = [NSDate timeIntervalSinceReferenceDate];
			const E3D::E3DMesh * mesh = factory->load( @"Box", @"3ds" );
			NSTimeInterval end   = [NSDate timeIntervalSinceReferenceDate];
			
			[self print:@"Static 3DS loaded" result:mesh!=nil withTime:(end-start)];
			if ( mesh )
			{
				factory->release(mesh);
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
	
	factory = new E3D::E3DMeshManager();
	
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
- (void) print:(NSString*)_text result:(BOOL)_result withTime:(NSTimeInterval)_time
{
	NSString * result = (_result) ? @"TRUE" : @"FALSE";
	[self print:[NSString stringWithFormat:@"%@ : %@ in %.3f", result, _text, _time]];

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
