/*
 *  CGTextMaths.h
 *  Electric3D
 *
 *  Created by Robert McDowell on 30/09/2010.
 *  Copyright 2010 Electric TopHat Ltd. All rights reserved.
 *
 */

#import <UIKit/UIKit.h>
#import "CGTestMathsAABB.h"

namespace MathsTests 
{
	void AddSection( NSMutableArray * dataset )
	{	
		NSMutableDictionary * data			= [NSMutableDictionary dictionaryWithCapacity:2];
		NSString *			sectiontitle	= @"Maths Tests";
		NSMutableArray *	array			= [NSMutableArray arrayWithCapacity:16];
			
		{
			NSMutableDictionary * testInfo = [NSMutableDictionary dictionary];
			
			[testInfo setObject:@"AABB Tests" forKey:@"name"];
			[testInfo setObject:[CGTestMathsAABB class] forKey:@"class"];
			
			[array addObject:testInfo];
		}
		
		[data setObject:sectiontitle	forKey:@"sectiontitle"];
		[data setObject:array			forKey:@"array"];
		[dataset addObject:data];
	}
};

