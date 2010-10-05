//
//  MAX3DSModel.h
//  Electric3D
//
//  Created by Robert McDowell on 04/10/2010.
//  Copyright 2010 Electric TopHat Ltd. All rights reserved.
//

#ifndef __MAX3DSModel_H__
#define __MAX3DSModel_H__	

#import "MAX3DSTypes.h"
#import <vector>

namespace MAX3DS 
{
	
	class MAX3DSModel 
	{
	public: // Functions
		
		MAX3DSModel(NSData * _data = nil);
		MAX3DSModel(const void * data, int len);
		~MAX3DSModel();
		
	public: // Functions
		
		inline BOOL valid() const { return m_data != 0; };
	
		void invalidate();
		
		BOOL set( NSData * _data );
		BOOL set( const void * _data, int _len );
				
		inline int count() const { return m_objects.size(); };
		inline const MAX3DS_OBJECT * objectAtIndex( unsigned int _index ) const { return &m_objects[_index]; };
		
	private: // Functions
		
		BOOL fill( const void * _data, int _len );
		void read_OBJMESH( const unsigned char * _data, int _len );
		void read_OBJBLOCK( const unsigned char * _data, int _len );
		void read_TRIMESH( const unsigned char * _data, int _len, MAX3DS_OBJECT & _object );
		
	private: // Data
		NSData *					m_data;
		std::vector<MAX3DS_OBJECT>	m_objects;
	};
	
};

#endif
