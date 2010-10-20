//
//  gzip.h
//  Electric3D
//
//  Created by Robert McDowell on 19/10/2010.
//  Copyright 2010 Electric TopHat Ltd. All rights reserved.
//

#if !defined(__gzip_h__)
#define __gzip_h__

namespace Compressor
{
	namespace gzip 
	{
		// GZIP :: Compressor Only
		NSData * inflate(NSData* _data);
		NSData * deflate(NSData* _data);
	};	
};

#endif