/*
 *  PVRPODUtility.h
 *  Electric3D
 *
 *  Created by Robert McDowell on 05/10/2010.
 *  Copyright 2010 Electric TopHat Ltd. All rights reserved.
 *
 */

#ifndef __PVRPODUtility_H__
#define __PVRPODUtility_H__

#import "PVRPODTypes.h"

namespace PVRPOD 
{
	size_t PODDataTypeSize(const ePVRTDataType type)
	{
		switch(type)
		{
			default:
				return 0;
			case EPODDataFloat:
				return sizeof(float);
			case EPODDataInt:
				return sizeof(int);
			case EPODDataShort:
			case EPODDataShortNorm:
			case EPODDataUnsignedShort:
				return sizeof(unsigned short);
			case EPODDataRGBA:
				return sizeof(unsigned int);
			case EPODDataARGB:
				return sizeof(unsigned int);
			case EPODDataD3DCOLOR:
				return sizeof(unsigned int);
			case EPODDataUBYTE4:
				return sizeof(unsigned int);
			case EPODDataDEC3N:
				return sizeof(unsigned int);
			case EPODDataFixed16_16:
				return sizeof(unsigned int);
			case EPODDataUnsignedByte:
			case EPODDataByte:
			case EPODDataByteNorm:
				return sizeof(unsigned char);
		}
	}
	

	size_t PODDataTypeComponentCount(const ePVRTDataType type)
	{
		switch(type)
		{
			default:
				return 0;
				
			case EPODDataFloat:
			case EPODDataInt:
			case EPODDataShort:
			case EPODDataShortNorm:
			case EPODDataUnsignedShort:
			case EPODDataFixed16_16:
			case EPODDataByte:
			case EPODDataByteNorm:
			case EPODDataUnsignedByte:
				return 1;
				
			case EPODDataDEC3N:
				return 3;
				
			case EPODDataRGBA:
			case EPODDataARGB:
			case EPODDataD3DCOLOR:
			case EPODDataUBYTE4:
				return 4;
		}
	}
	
	size_t PODDataStride(const PODData &data)
	{
		return PODDataTypeSize(data.eType) * data.n;
	}
	
};

#endif