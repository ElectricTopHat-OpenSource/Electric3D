//
//  RootViewController.m
//  Electric3D
//
//  Created by Robert McDowell on 20/09/2010.
//  Copyright 2010 Electric TopHat Ltd. All rights reserved.
//

#import "RootViewController.h"
#import "GLTestGeneral.h"

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
		tableData = [[NSMutableArray alloc] initWithCapacity:10];
		
		{
			NSMutableDictionary * testInfo = [NSMutableDictionary dictionary];
			
			[testInfo setObject:@"General GL Test" forKey:@"name"];
			[testInfo setObject:[GLTestGeneral class] forKey:@"class"];
			
			[tableData addObject:testInfo];
		}
	}
	return self;
}

// ------------------------------------------
// dealloc
// ------------------------------------------
- (void)dealloc 
{
	SAFE_RELEASE( tableView );
	SAFE_RELEASE( tableData );
	SAFE_RELEASE( subView );
	
	[updateTimer invalidate];
	updateTimer = nil;
	
    [super dealloc];
}

#pragma mark ---------------------------------------------------------
#pragma mark === End Constructor / Destructor Functions  ===
#pragma mark ---------------------------------------------------------

#pragma mark ---------------------------------------------------------
#pragma mark === UIView Functions  ===
#pragma mark ---------------------------------------------------------

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
	if ( updateTimer )
	{
		[updateTimer invalidate];
		updateTimer = nil;
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
			updateTimer = [NSTimer scheduledTimerWithTimeInterval:kUpdateSeconds target:subView selector:@selector(update) userInfo:nil repeats:YES];
			
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
	[self removeSubView];
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
	NSDictionary * entry = [tableData objectAtIndex:indexPath.row];
		
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
	return 1;
}

// -------------------------------------------------------------------
// get the title for the section
// -------------------------------------------------------------------
- (NSString *)tableView:(UITableView *)_tableView titleForHeaderInSection:(NSInteger)section
{
	return @"OpenGL ES Tests";
}

// -------------------------------------------------------------------
// get the bnumber of rows in the table section
// -------------------------------------------------------------------
- (NSInteger) tableView:(UITableView *)_tableView numberOfRowsInSection:(NSInteger)section 
{
    return [tableData count];
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
	
	NSDictionary * entry = [tableData objectAtIndex:indexPath.row];
	
	[cell setAccessoryType:UITableViewCellAccessoryNone];
	[[cell textLabel] setText:[entry objectForKey:@"name"]];
	
	return cell;
}

#pragma mark ---------------------------------------------------------
#pragma mark === End UITableViewDataSource Functions  ===
#pragma mark ---------------------------------------------------------

@end

