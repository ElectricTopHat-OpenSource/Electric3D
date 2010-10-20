//
//  zip.h
//  Electric3D
//
//  Created by Robert McDowell on 19/10/2010.
//  Copyright 2010 Electric TopHat Ltd. All rights reserved.
//

#if !defined(__zip_h__)
#define __zip_h__

namespace Compressor
{
	namespace zip
	{
		// ZLIB :: Compressor and Archiver
		NSData * inflate(NSData* _data);
		NSData * deflate(NSData* _data);
	};	
};

#endif
