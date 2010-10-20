/*
 *  MAX3DSUtility.h
 *  Electric3D
 *
 *  Created by Robert McDowell on 04/10/2010.
 *  Copyright 2010 Electric TopHat Ltd. All rights reserved.
 *
 */

#ifndef __MAX3DSUtility_H__
#define __MAX3DSUtility_H__

namespace MAX3DS 
{

	inline void readN( const unsigned char * bytes, void * buffer, int len )
	{
		char* pB = (char*)buffer;
		for (int n=0; n<len; n++)
		{
			pB[n] = bytes[n];
		}
	}
	
	inline int readI2( const unsigned char * _data ) 
	{	
		struct { union { char bytes[2]; int value; }; } buffer= { 0 };
		
		readN( _data, &buffer, 2 );
		
		return buffer.value;
	}
	
	inline float readF( const unsigned char * _data ) 
	{	
		struct { union { char bytes[4]; float value; }; } buffer= { 0 };
		
		readN ( _data, &buffer, 4 );
		
		return buffer.value;
	}
	
	inline int readI4( const unsigned char * _data )
	{
		struct { union { char bytes[4]; int value; }; } buffer= { 0 };
		
		readN( _data, &buffer, 4);
		
		return buffer.value;
	}
	
	inline int readStringLength( const unsigned char * bytes )
	{
		int len = 0;
		while (bytes[len])
			len++;
		return len;
	}
	
	inline float Convertf( float _value )
	{
		union floatunion { unsigned char part[4]; float value; } Converter;
		char swap_char;
		
		Converter.value = _value;
		swap_char = Converter.part[0]; Converter.part[0] = Converter.part[3]; Converter.part[3] = swap_char;
		swap_char = Converter.part[1]; Converter.part[1] = Converter.part[2]; Converter.part[2] = swap_char;
		
		return Converter.value;
	}
	
	inline int ConvertI4( int _value )
	{
		union longunion { unsigned char part[4]; unsigned long value; } Converter;
		char swap_char;
		
		Converter.value = _value;
		swap_char = Converter.part[0]; Converter.part[0] = Converter.part[3]; Converter.part[3] = swap_char;
		swap_char = Converter.part[1]; Converter.part[1] = Converter.part[2]; Converter.part[2] = swap_char;
		
		return Converter.value;
	}
	
	inline int ConvertI2( int _value )
	{
		union shortunion { unsigned char part[2]; unsigned short value; } Converter;
		char swap_char;
		
		Converter.value = _value;
		swap_char = Converter.part[0]; Converter.part[0] = Converter.part[1]; Converter.part[1] = swap_char;
		
		return Converter.value;
	}
};

#endif