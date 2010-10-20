/*
 *  TestSplines.h
 *  Electric3D
 *
 *  Created by Robert McDowell on 18/10/2010.
 *  Copyright 2010 Electric TopHat Ltd. All rights reserved.
 *
 */

#import <UIKit/UIKit.h>
#import "TestSplineLoader.h"
#import "TestSplinePlayback2Points.h"
#import "TestSplinePlayback4Points.h"

namespace SplineTests 
{
	void AddSection( NSMutableArray * dataset )
	{	
		NSMutableDictionary * data			= [NSMutableDictionary dictionaryWithCapacity:2];
		NSString *			sectiontitle	= @"Spline Tests";
		NSMutableArray *	array			= [NSMutableArray arrayWithCapacity:16];
		
		{
			NSMutableDictionary * testInfo = [NSMutableDictionary dictionary];
			
			[testInfo setObject:@"Spline Loader Tests" forKey:@"name"];
			[testInfo setObject:[TestSplineLoader class] forKey:@"class"];
			
			[array addObject:testInfo];
		}
		
		{
			NSMutableDictionary * testInfo = [NSMutableDictionary dictionary];
			
			[testInfo setObject:@"Spline Playback 2 Points Test" forKey:@"name"];
			[testInfo setObject:[TestSplinePlayback2Points class] forKey:@"class"];
			
			[array addObject:testInfo];
		}
		
		{
			NSMutableDictionary * testInfo = [NSMutableDictionary dictionary];
			
			[testInfo setObject:@"Spline Playback 4 Points Test" forKey:@"name"];
			[testInfo setObject:[TestSplinePlayback4Points class] forKey:@"class"];
			
			[array addObject:testInfo];
		}
		
		[data setObject:sectiontitle	forKey:@"sectiontitle"];
		[data setObject:array			forKey:@"array"];
		[dataset addObject:data];
	}
};