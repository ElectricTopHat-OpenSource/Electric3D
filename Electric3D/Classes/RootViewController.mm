//
//  RootViewController.m
//  Electric3D
//
//  Created by Robert McDowell on 20/09/2010.
//  Copyright 2010 Electric TopHat Ltd. All rights reserved.
//

#import "RootViewController.h"

#import "CGTestMaths.h"
#import "TestSplines.h"
#import "TestModels.h"
#import "TestCamera.h"

// -------------------------------------------------------------------
// update time defines
// -------------------------------------------------------------------
#define kUpdateFPS				60.0f // Hz
#define kUpdateSeconds			(1.0f / kUpdateFPS) // secs
#define kSkipTicks				(1000 / kUpdateFPS)
// -------------------------------------------------------------------

@interface RootViewController (PrivateMethods)

- (void) removeSubView;
- (void) setSubView:(Class)_class;

@end


@implementation RootViewController

#pragma mark ---------------------------------------------------------
#pragma mark === Constructor / Destructor Functions  ===
#pragma mark ---------------------------------------------------------

// ------------------------------------------
// Initialization
// ------------------------------------------
- (id) initWithCoder:(NSCoder *)aDecoder
{
	if ( self = [super initWithCoder:aDecoder] )
	{
		updateTimer = [[GameTimer alloc] init];
		tableData = [[NSMutableArray alloc] initWithCapacity:10];
		
		MathsTests::AddSection( tableData );
		SplineTests::AddSection( tableData );
		ModelTests::AddSection( tableData );
		CameraTests::AddSection( tableData );
	}
	return self;
}

// ------------------------------------------
// dealloc
// ------------------------------------------
- (void)dealloc 
{
	SAFE_RELEASE( updateTimer );
	SAFE_RELEASE( tableView );
	SAFE_RELEASE( tableData );
	SAFE_RELEASE( subView );
	
    [super dealloc];
}

#pragma mark ---------------------------------------------------------
#pragma mark === End Constructor / Destructor Functions  ===
#pragma mark ---------------------------------------------------------

#pragma mark ---------------------------------------------------------
#pragma mark === UIView Functions  ===
#pragma mark ---------------------------------------------------------

// -------------------------------------------------------------------
// Override to allow orientations other than the default portrait orientation.
// -------------------------------------------------------------------
- (BOOL) shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation 
{
	if ( [subView respondsToSelector:@selector(canRotate)]  )
	{
		return [subView performSelector:@selector(canRotate)] != nil;
	}
    return YES;
}

// -------------------------------------------------------------------
// fix the scale of the object when it's rotated
// -------------------------------------------------------------------
- (void) didRotateFromInterfaceOrientation:(UIInterfaceOrientation)fromInterfaceOrientation 
{
	[subView setFrame:self.view.bounds];
	[subView layoutSubviews];
}

- (void) viewDidLoad
{	
	[tableView reloadData];
}

#pragma mark ---------------------------------------------------------
#pragma mark === End UIView Functions  ===
#pragma mark ---------------------------------------------------------

#pragma mark ---------------------------------------------------------
#pragma mark === Private Functions  ===
#pragma mark ---------------------------------------------------------

// ------------------------------------------
// remove the subview
// ------------------------------------------
- (void) removeSubView
{
	if ( [updateTimer running] )
	{
		[updateTimer stopTimer];
		[updateTimer setDelegate:nil];
		[updateTimer setSelector:nil];
	}
	
	if ( subView )
	{
		[subView removeFromSuperview];
		[subView release];
		subView = nil;
	}
	
	[tableView setHidden:FALSE];
}

// ------------------------------------------
// add the subview
// ------------------------------------------
- (void) setSubView:(Class)_class
{
	if ( subView == nil )
	{
		CGRect frame = [[self view] bounds];
		subView = [[_class alloc] initWithFrame:frame];
		
		if ( subView )
		{
			[[self view] addSubview:subView];
		
			// create the update timer
			[updateTimer setDelegate:subView];
			[updateTimer setSelector:@selector(update:)];
			[updateTimer startTimer];
			
			[tableView setHidden:TRUE];
		}
	}
}

#pragma mark ---------------------------------------------------------
#pragma mark === End Private Functions  ===
#pragma mark ---------------------------------------------------------

#pragma mark ---------------------------------------------------------
#pragma mark === UIResponder Functions  ===
#pragma mark ---------------------------------------------------------

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
	UITouch *touch = [[event allTouches] anyObject];
	if ( [touch tapCount] == 2 )
	{
		[self removeSubView];
	}
}

#pragma mark ---------------------------------------------------------
#pragma mark === End UIResponder Functions  ===
#pragma mark ---------------------------------------------------------

#pragma mark ---------------------------------------------------------
#pragma mark === UITableViewDelegate Functions  ===
#pragma mark ---------------------------------------------------------

// -------------------------------------------------------------------
// did select row at IndexPath
// -------------------------------------------------------------------
- (void)tableView:(UITableView *)_tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{		
	NSMutableDictionary *	section = [tableData objectAtIndex:indexPath.section];
	NSMutableArray *		data	= [section objectForKey:@"array"];
	NSDictionary *			entry	= [data objectAtIndex:indexPath.row];
		
	[self removeSubView];
	[self setSubView:[entry objectForKey:@"class"]];
}

#pragma mark ---------------------------------------------------------
#pragma mark === End UITableViewDelegate Functions  ===
#pragma mark ---------------------------------------------------------

#pragma mark ---------------------------------------------------------
#pragma mark === UITableViewDataSource Functions  ===
#pragma mark ---------------------------------------------------------

// -------------------------------------------------------------------
// get the number of sections in the table
// -------------------------------------------------------------------
- (NSInteger) numberOfSectionsInTableView:(UITableView *)_tableView 
{
	return [tableData count];
}

// -------------------------------------------------------------------
// get the title for the section
// -------------------------------------------------------------------
- (NSString *)tableView:(UITableView *)_tableView titleForHeaderInSection:(NSInteger)_section
{
	NSMutableDictionary * section = [tableData objectAtIndex:_section];
	return [section objectForKey:@"sectiontitle"];
}

// -------------------------------------------------------------------
// get the bnumber of rows in the table section
// -------------------------------------------------------------------
- (NSInteger) tableView:(UITableView *)_tableView numberOfRowsInSection:(NSInteger)_section 
{
	NSMutableDictionary *	section = [tableData objectAtIndex:_section];
	NSMutableArray *		data	= [section objectForKey:@"array"];
    return [data count];
}

// -------------------------------------------------------------------
// get the cell for the data
// -------------------------------------------------------------------
- (UITableViewCell *)tableView:(UITableView *)_tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
	static NSString * cellIdentifier = @"FileListCell";
	UITableViewCell * cell = [_tableView dequeueReusableCellWithIdentifier:cellIdentifier];
	if ( cell == nil )
	{
		cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellIdentifier];
	}
	
	NSMutableDictionary *	section	= [tableData objectAtIndex:indexPath.section];
	NSMutableArray *		data	= [section objectForKey:@"array"];
	NSDictionary *			entry	= [data objectAtIndex:indexPath.row];
	
	[cell setAccessoryType:UITableViewCellAccessoryNone];
	[[cell textLabel] setText:[entry objectForKey:@"name"]];
	
	return cell;
}

#pragma mark ---------------------------------------------------------
#pragma mark === End UITableViewDataSource Functions  ===
#pragma mark ---------------------------------------------------------

@end

