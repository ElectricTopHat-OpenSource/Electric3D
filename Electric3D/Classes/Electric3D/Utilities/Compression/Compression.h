//
//  zlib.h
//  Electric3D
//
//  Created by Robert McDowell on 23/09/2010.
//  Copyright 2010 Electric TopHat Ltd. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface Compression : NSObject 

// ZLIB :: Compressor and Archiver
+ (NSData *) zlibInflate:(NSData*)_data;
+ (NSData *) zlibDeflate:(NSData*)_data;

// GZIP :: Compressor Only
+ (NSData *) gzipInflate:(NSData*)_data;
+ (NSData *) gzipDeflate:(NSData*)_data;

@end
