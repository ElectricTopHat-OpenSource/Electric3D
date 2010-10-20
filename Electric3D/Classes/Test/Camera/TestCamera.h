/*
 *  TestCamera.h
 *  Electric3D
 *
 *  Created by Robert McDowell on 19/10/2010.
 *  Copyright 2010 Electric TopHat Ltd. All rights reserved.
 *
 */

#import <UIKit/UIKit.h>
#import "TestCameraBasic.h"
#import "TestCameraFOV.h"
#import "TestCameraTouch.h"

namespace CameraTests 
{
	void AddSection( NSMutableArray * dataset )
	{	
		NSMutableDictionary * data			= [NSMutableDictionary dictionaryWithCapacity:2];
		NSString *			sectiontitle	= @"Camera Tests";
		NSMutableArray *	array			= [NSMutableArray arrayWithCapacity:16];
		
		{
			NSMutableDictionary * testInfo = [NSMutableDictionary dictionary];
			
			[testInfo setObject:@"Basic Camera Test" forKey:@"name"];
			[testInfo setObject:[TestCameraBasic class] forKey:@"class"];
			
			[array addObject:testInfo];
		}
		
		{
			NSMutableDictionary * testInfo = [NSMutableDictionary dictionary];
			
			[testInfo setObject:@"Camera FOV Test" forKey:@"name"];
			[testInfo setObject:[TestCameraFOV class] forKey:@"class"];
			
			[array addObject:testInfo];
		}
		
		{
			NSMutableDictionary * testInfo = [NSMutableDictionary dictionary];
			
			[testInfo setObject:@"Camera Touch Test" forKey:@"name"];
			[testInfo setObject:[TestCameraTouch class] forKey:@"class"];
			
			[array addObject:testInfo];
		}
		
		[data setObject:sectiontitle	forKey:@"sectiontitle"];
		[data setObject:array			forKey:@"array"];
		[dataset addObject:data];
	}
};