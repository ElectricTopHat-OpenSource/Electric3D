//
//  gzip.mm
//  Electric3D
//
//  Created by Robert McDowell on 19/10/2010.
//  Copyright 2010 Electric TopHat Ltd. All rights reserved.
//

#import "gzip.h"
#import <zlib.h>

namespace Compressor
{
	namespace gzip 
	{
		NSData * inflate( NSData * _data )
		{
			if ([_data length] == 0) return _data;
			
			NSUInteger full_length	= [_data length];
			NSUInteger chunk_length	= [_data length] / 2;
			
			NSMutableData *decompressed = [NSMutableData dataWithLength: full_length + chunk_length];
			BOOL done = NO;
			int status;
			
			z_stream strm;
			strm.next_in = (Bytef *)[_data bytes];
			strm.avail_in = [_data length];
			strm.total_out = 0;
			strm.zalloc = Z_NULL;
			strm.zfree = Z_NULL;
			
			if (inflateInit2(&strm, (15+32)) != Z_OK) return nil;
			while (!done)
			{
				// Make sure we have enough room and reset the lengths.
				if (strm.total_out >= [decompressed length])
					[decompressed increaseLengthBy: chunk_length];
				strm.next_out = (Bytef*)[decompressed mutableBytes] + strm.total_out;
				strm.avail_out = [decompressed length] - strm.total_out;
				
				// Inflate another chunk.
				status = inflate (&strm, Z_SYNC_FLUSH);
				if (status == Z_STREAM_END) done = YES;
				else if (status != Z_OK) break;
			}
			if (inflateEnd (&strm) != Z_OK) return nil;
			
			// Set real length.
			if (done)
			{
				[decompressed setLength: strm.total_out];
				return [NSData dataWithData: decompressed];
			}
			else return nil;
		}
		
		NSData * deflate( NSData * _data )
		{
			if ([_data length] == 0) return _data;
			
			z_stream strm;
			
			strm.zalloc = Z_NULL;
			strm.zfree = Z_NULL;
			strm.opaque = Z_NULL;
			strm.total_out = 0;
			strm.next_in=(Bytef *)[_data bytes];
			strm.avail_in = [_data length];
			
			// Compresssion Levels:
			//   Z_NO_COMPRESSION
			//   Z_BEST_SPEED
			//   Z_BEST_COMPRESSION
			//   Z_DEFAULT_COMPRESSION
			
			if (deflateInit2(&strm, Z_DEFAULT_COMPRESSION, Z_DEFLATED, (15+16), 8, Z_DEFAULT_STRATEGY) != Z_OK) return nil;
			
			NSUInteger		chunk_length	= 16384;   // 16K chuncks for expansion
			NSMutableData *	compressed		= [NSMutableData dataWithLength:chunk_length];
			
			do {
				
				if (strm.total_out >= [compressed length])
					[compressed increaseLengthBy: chunk_length];
				
				strm.next_out = (Bytef*)[compressed mutableBytes] + strm.total_out;
				strm.avail_out = [compressed length] - strm.total_out;
				
				deflate(&strm, Z_FINISH);  
				
			} while (strm.avail_out == 0);
			
			deflateEnd(&strm);
			
			[compressed setLength: strm.total_out];
			return [NSData dataWithData:compressed];
		}
	};	
};
