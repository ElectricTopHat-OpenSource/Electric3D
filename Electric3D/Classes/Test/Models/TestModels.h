/*
 *  TestModels.h
 *  Electric3D
 *
 *  Created by Robert McDowell on 19/10/2010.
 *  Copyright 2010 Electric TopHat Ltd. All rights reserved.
 *
 */

#import <UIKit/UIKit.h>
#import "TestMeshLoader.h"
#import "TestMeshStatic.h"
#import "TestMeshAnimated.h"

namespace ModelTests 
{
	void AddSection( NSMutableArray * dataset )
	{	
		NSMutableDictionary * data			= [NSMutableDictionary dictionaryWithCapacity:2];
		NSString *			sectiontitle	= @"Model Tests";
		NSMutableArray *	array			= [NSMutableArray arrayWithCapacity:16];
		
		{
			NSMutableDictionary * testInfo = [NSMutableDictionary dictionary];
			
			[testInfo setObject:@"Mesh Loader Tests" forKey:@"name"];
			[testInfo setObject:[TestMeshLoader class] forKey:@"class"];
			
			[array addObject:testInfo];
		}
		
		{
			NSMutableDictionary * testInfo = [NSMutableDictionary dictionary];
			
			[testInfo setObject:@"Mesh Static Tests" forKey:@"name"];
			[testInfo setObject:[TestMeshStatic class] forKey:@"class"];
			
			[array addObject:testInfo];
		}
		
		{
			NSMutableDictionary * testInfo = [NSMutableDictionary dictionary];
			
			[testInfo setObject:@"Mesh Animated Tests" forKey:@"name"];
			[testInfo setObject:[TestMeshAnimated class] forKey:@"class"];
			
			[array addObject:testInfo];
		}
		
		[data setObject:sectiontitle	forKey:@"sectiontitle"];
		[data setObject:array			forKey:@"array"];
		[dataset addObject:data];
	}
};