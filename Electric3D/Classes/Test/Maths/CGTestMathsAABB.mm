//
//  CGTestMathsAABB.m
//  Electric3D
//
//  Created by Robert McDowell on 30/09/2010.
//  Copyright 2010 Electric TopHat Ltd. All rights reserved.
//

#import "CGTestMathsAABB.h"
#import "CGMaths.h"

@interface CGTestMathsAABB (PrivateMethods)

- (void) initialization;
- (void) teardown;

- (void) print:(NSString*)_text result:(BOOL)_result;
- (void) print:(NSString*)_text;

@end

@implementation CGTestMathsAABB

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
	CGMaths::CGAABB aabb = CGMaths::CGAABBUnit;
	switch (state) 
	{
		case 0:
		{
			CGMaths::CGVector3D aabbcenter = CGMaths::CGAABBGetCenter( aabb );
			BOOL result = ( ( aabbcenter.x == 0.0f ) && ( aabbcenter.y == 0.0f ) && ( aabbcenter.z == 0.0f ) );
			[self print:@"CGAABBUnit Center is CGVector3DZero" result:result==TRUE];
			break;
		}
		case 1:
		{
			CGMaths::CGVector3D aabbvolume = CGMaths::CGAABBGetVolume( aabb );
			BOOL result = ( ( aabbvolume.x == 1.0f ) && ( aabbvolume.y == 1.0f ) && ( aabbvolume.z == 1.0f ) );
			[self print:@"CGAABBUnit Volume is 1" result:result==TRUE];
			break;
		}
			
		case 2:
		{
			BOOL result = CGMaths::CGAABBContains( aabb, CGMaths::CGVector3DZero );
			[self print:@"CGAABBUnit Contains CGVector3DZero" result:result==TRUE];
			break;
		}
		case 3:
		{
			BOOL result = CGMaths::CGAABBContains( aabb, CGMaths::CGVector3DUnit );
			[self print:@"CGAABBUnit NOT Contains CGVector3DUnit" result:result==FALSE];
			break;
		}
		case 4:
		{
			BOOL result = CGMaths::CGAABBContains( aabb, CGMaths::CGVector3DMake( 0.5f, 0.5f, 0.5f ) );
			[self print:@"CGAABBUnit NOT Contains(0.5f,0.5f,0.5f)" result:result==FALSE];
			break;
		}
		case 5:
		{
			BOOL result = CGMaths::CGAABBContains( aabb, CGMaths::CGVector3DMake( -0.5f, -0.5f, -0.5f ) );
			[self print:@"CGAABBUnit NOT Contains(-0.5f,-0.5f,-0.5f)" result:result==FALSE];
			break;
		}
			
		case 6:
		{
			BOOL result = CGMaths::CGAABBContainsOrTouches( aabb, CGMaths::CGVector3DZero );
			[self print:@"CGAABBUnit Contain/Touch CGVector3DZero" result:result==TRUE];
			break;
		}
		case 7:
		{
			BOOL result = CGMaths::CGAABBContainsOrTouches( aabb, CGMaths::CGVector3DUnit );
			[self print:@"CGAABBUnit NOT Contain/Touch (1,1,1)" result:result==FALSE];
			break;
		}
		case 8:
		{
			BOOL result = CGMaths::CGAABBContainsOrTouches( aabb, CGMaths::CGVector3DMake( 0.5f, 0.5f, 0.5f ) );
			[self print:@"CGAABBUnit Contain/Touch (0.5f,0.5f,0.5f)" result:result==TRUE];
			break;
		}
		case 9:
		{
			BOOL result = CGMaths::CGAABBContainsOrTouches( aabb, CGMaths::CGVector3DMake( -0.5f, -0.5f, -0.5f ) );
			[self print:@"CGAABBUnit Contain/Touch (-0.5f,-0.5f,-0.5f)" result:result==TRUE];
			break;
		}
			
		case 10:
		{
			BOOL result = CGMaths::CGAABBContains( aabb, CGMaths::CGAABBUnit );
			[self print:@"CGAABBUnit NOT Contains CGAABBUnit" result:result==FALSE];
			break;
		}
		case 11:
		{
			CGMaths::CGAABB smallaabb = CGMaths::CGAABBMakeScale( CGMaths::CGAABBUnit, 0.5f );
			BOOL result = CGMaths::CGAABBContains( aabb, smallaabb );
			[self print:@"CGAABBUnit Contains small AABB" result:result==TRUE];
			break;
		}
		case 12:
		{
			CGMaths::CGAABB largeaabb = CGMaths::CGAABBMakeScale( CGMaths::CGAABBUnit, 10.0f );
			BOOL result = CGMaths::CGAABBContains( aabb, largeaabb );
			[self print:@"CGAABBUnit NOT Contains large AABB" result:result==FALSE];
			break;
		}
		case 13:
		{	CGMaths::CGAABB offsetaabb = CGMaths::CGAABBUnit;
			offsetaabb.min.x += 5.0f; offsetaabb.min.y += 5.0f; offsetaabb.min.z += 5.0f;
			offsetaabb.max.x += 5.0f; offsetaabb.max.y += 5.0f; offsetaabb.max.z += 5.0f;
			BOOL result = CGMaths::CGAABBContains( aabb, offsetaabb );
			[self print:@"CGAABBUnit NOT Contains Offset AABB" result:result==FALSE];
			break;
		}
			
		case 14:
		{
			BOOL result = CGMaths::CGAABBIntersects( aabb, CGMaths::CGAABBUnit );
			[self print:@"CGAABBUnit Intersects CGAABBUnit" result:result==TRUE];
			break;
		}
		case 15:
		{
			CGMaths::CGAABB smallaabb = CGMaths::CGAABBMakeScale( CGMaths::CGAABBUnit, 0.5f );
			BOOL result = CGMaths::CGAABBIntersects( aabb, smallaabb );
			[self print:@"CGAABBUnit NOT Intersects small AABB" result:result==TRUE];
			break;
		}
		case 16:
		{
			CGMaths::CGAABB largeaabb = CGMaths::CGAABBMakeScale( CGMaths::CGAABBUnit, 10.0f );
			BOOL result = CGMaths::CGAABBIntersects( aabb, largeaabb );
			[self print:@"CGAABBUnit NOT Intersects large AABB" result:result==FALSE];
			break;
		}
		case 17:
		{	CGMaths::CGAABB offsetaabb = CGMaths::CGAABBUnit;
			offsetaabb.min.x += 5.0f; offsetaabb.min.y += 5.0f; offsetaabb.min.z += 5.0f;
			offsetaabb.max.x += 5.0f; offsetaabb.max.y += 5.0f; offsetaabb.max.z += 5.0f;
			BOOL result = CGMaths::CGAABBIntersects( aabb, offsetaabb );
			[self print:@"CGAABBUnit NOT Intersects Offset AABB" result:result==FALSE];
			break;
		}
			
		case 18:
		{
			CGMaths::CGVector3D start = CGMaths::CGVector3DZero;
			CGMaths::CGVector3D end   = CGMaths::CGVector3DUnit;
			
			BOOL result = CGMaths::CGAABBIntersects( aabb, start, end );
			[self print:@"CGAABBUnit Intersects (0,0,0)->(1,1,1)" result:result==TRUE];
			break;
		}
		case 19:
		{
			CGMaths::CGVector3D start = CGMaths::CGVector3DZero;
			CGMaths::CGVector3D end   = CGMaths::CGVector3DMakeScale( CGMaths::CGVector3DUnit, -1.0f );
			
			BOOL result = CGMaths::CGAABBIntersects( aabb, start, end );
			[self print:@"CGAABBUnit Intersects (0,0,0)->(-1,-1,-1)" result:result==TRUE];
			break;
		}
		case 20:
		{
			CGMaths::CGVector3D start = CGMaths::CGVector3DMakeScale( CGMaths::CGVector3DUnit, 1.0f );
			CGMaths::CGVector3D end   = CGMaths::CGVector3DMakeScale( CGMaths::CGVector3DUnit, 2.0f );
			BOOL result = CGMaths::CGAABBIntersects( aabb, start, end );
			[self print:@"CGAABBUnit NOT Intersects (1,1,1)->(2,2,2)" result:result==FALSE];
			break;
		}
		case 21:
		{
			CGMaths::CGVector3D start = CGMaths::CGVector3DMakeScale( CGMaths::CGVector3DUnit, -1.0f );
			CGMaths::CGVector3D end   = CGMaths::CGVector3DMakeScale( CGMaths::CGVector3DUnit,  2.0f );
			BOOL result = CGMaths::CGAABBIntersects( aabb, start, end );
			[self print:@"CGAABBUnit Intersects (-1,-1,-1)->(2,2,2)" result:result==TRUE];
			break;
		}
		case 22:
		{	
			CGMaths::CGVector3D start = CGMaths::CGVector3DMake( 10, 0, 0 );
			CGMaths::CGVector3D end   = CGMaths::CGVector3DMake( 2, 0, 0 );
			BOOL result = CGMaths::CGAABBIntersects( aabb, start, end );
			[self print:@"CGAABBUnit NOT Intersects (10,0,0)->(2,0,0)" result:result==FALSE];
			break;
		}
		case 23:
		{	
			CGMaths::CGVector3D start = CGMaths::CGVector3DMake( 0, 10, 0 );
			CGMaths::CGVector3D end   = CGMaths::CGVector3DMake( 0, 2, 0 );
			BOOL result = CGMaths::CGAABBIntersects( aabb, start, end );
			[self print:@"CGAABBUnit NOT Intersects (0,10,0)->(0,2,0)" result:result==FALSE];
			break;
		}
		case 24:
		{	
			CGMaths::CGVector3D start = CGMaths::CGVector3DMake( 0, 0, 10 );
			CGMaths::CGVector3D end   = CGMaths::CGVector3DMake( 0, 0, 2 );
			BOOL result = CGMaths::CGAABBIntersects( aabb, start, end );
			[self print:@"CGAABBUnit NOT Intersects (0,0,10)->(0,0,2)" result:result==FALSE];
			break;
		}
		case 25:
		{	
			CGMaths::CGVector3D start = CGMaths::CGVector3DMake( 0, 1, 10 );
			CGMaths::CGVector3D end   = CGMaths::CGVector3DMake( 0, 1, -10 );
			BOOL result = CGMaths::CGAABBIntersects( aabb, start, end );
			[self print:@"CGAABBUnit NOT Intersects (0,1,10)->(0,1,-10)" result:result==FALSE];
			break;
		}
		case 26:
		{	
			CGMaths::CGVector3D start = CGMaths::CGVector3DMake( 0, 1, -10 );
			CGMaths::CGVector3D end   = CGMaths::CGVector3DMake( 0, 1, 10 );
			BOOL result = CGMaths::CGAABBIntersects( aabb, start, end );
			[self print:@"CGAABBUnit NOT Intersects (0,1,-10)->(0,1,10)" result:result==FALSE];
			break;
		}
		case 27:
		{	
			CGMaths::CGVector3D start = CGMaths::CGVector3DMake( 10, 1, 0 );
			CGMaths::CGVector3D end   = CGMaths::CGVector3DMake( -10, 1, 0 );
			BOOL result = CGMaths::CGAABBIntersects( aabb, start, end );
			[self print:@"CGAABBUnit NOT Intersects (10,1,0)->(-10,1,0)" result:result==FALSE];
			break;
		}
		case 28:
		{	
			CGMaths::CGVector3D start = CGMaths::CGVector3DMake( -10, 1, 0 );
			CGMaths::CGVector3D end   = CGMaths::CGVector3DMake( 10, 1, 0 );
			BOOL result = CGMaths::CGAABBIntersects( aabb, start, end );
			[self print:@"CGAABBUnit NOT Intersects (-10,1,-0)->(10,1,0)" result:result==FALSE];
			break;
		}
		case 29:
		{	
			CGMaths::CGVector3D start = CGMaths::CGVector3DMake( -10, -1, 0 );
			CGMaths::CGVector3D end   = CGMaths::CGVector3DMake( 10, -1, 0 );
			BOOL result = CGMaths::CGAABBIntersects( aabb, start, end );
			[self print:@"CGAABBUnit NOT Intersects (-10,-1,-0)->(10,-1,0)" result:result==FALSE];
			break;
		}
		case 30:
		{	
			CGMaths::CGVector3D start = CGMaths::CGVector3DMake( -10, 1, 0 );
			CGMaths::CGVector3D end   = CGMaths::CGVector3DMake( 10, -1, 0 );
			BOOL result = CGMaths::CGAABBIntersects( aabb, start, end );
			[self print:@"CGAABBUnit Intersects (-10,1,-0)->(10,-1,0)" result:result==TRUE];
			break;
		}
		default:
			break;
	} 
	state++;
	
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
	
	state = 0;
}

// ------------------------------------------
// Teardown
// ------------------------------------------
- (void) teardown
{	
	[display removeFromSuperview];
	SAFE_RELEASE( display );
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
