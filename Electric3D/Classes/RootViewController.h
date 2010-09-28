//
//  RootViewController.h
//  Electric3D
//
//  Created by Robert McDowell on 20/09/2010.
//  Copyright 2010 Electric TopHat Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GameTimer.h"

@interface RootViewController : UIViewController <UITableViewDelegate,
												  UITableViewDataSource>
{
@private

	IBOutlet UITableView *	tableView;
	NSMutableArray *		tableData;
	
	GameTimer *				updateTimer;
	UIView *				subView;	
}

@end
