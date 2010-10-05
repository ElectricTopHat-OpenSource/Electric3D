//
//  MAX3DSModel.m
//  Electric3D
//
//  Created by Robert McDowell on 04/10/2010.
//  Copyright 2010 Electric TopHat Ltd. All rights reserved.
//

#import "MAX3DSModel.h"
#import "MAX3DSUtility.h"

namespace MAX3DS 
{	
	// ---------------------------------------------------------------
	// Constructor
	// ---------------------------------------------------------------
	MAX3DSModel::MAX3DSModel(NSData * _data)
	: m_data		( nil )
	{
		set( _data );
	}
	
	// ---------------------------------------------------------------
	// Constructor
	// ---------------------------------------------------------------
	MAX3DSModel::MAX3DSModel(const void * _data, int _len)
	: m_data		( nil )
	{
		set( _data, _len );
	}
	
	// ---------------------------------------------------------------
	// Destructor
	// ---------------------------------------------------------------
	MAX3DSModel::~MAX3DSModel()
	{
		[m_data release];
	}

	// ---------------------------------------------------------------
	// invalidate the model
	// ---------------------------------------------------------------
	void MAX3DSModel::invalidate()
	{
		m_objects.clear();
		
		[m_data release]; m_data = nil;
	}
	
	// ---------------------------------------------------------------
	// change the model data
	// ---------------------------------------------------------------
	BOOL MAX3DSModel::set( NSData * _data )
	{
		invalidate();
		
		m_data = [_data retain];
		
		if ( m_data  )
		{
			if ( !fill( [m_data bytes], [m_data length] ) )
			{
				invalidate();
			}
		}
		
		return m_data != nil;
	}
	
	// ---------------------------------------------------------------
	// change the model data
	// ---------------------------------------------------------------
	BOOL MAX3DSModel::set( const void * _data, int _len )
	{
		invalidate();
		
		m_data = [[NSData alloc] initWithBytes:_data length:_len];
		
		const void * bytes	= [m_data bytes];
		int length			= [m_data length];
		
		if ( !fill( bytes, length ) )
		{
			invalidate();
		}
		
		return m_data != nil;
	}
	
	// ---------------------------------------------------------------
	// fill the data structures with the data pointer
	// ---------------------------------------------------------------
	BOOL MAX3DSModel::fill( const void * _data, int _len )
	{
		int hsize = MAX3DS_ChunkHeaderSize;
		if ( _len >= hsize )
		{
			unsigned char * p	= (unsigned char*)_data;
			
			// make sure that we id matches
			if ( readI2(p) == CHUNK_MAIN )
			{
				MAX3DS_ChunkHeader chunk;
				int pos				= 0;
				int length			= _len;
				
				while ( pos < length )
				{
					chunk.identifier	= readI2(&p[pos]);
					chunk.length		= readI4(&p[pos+2]);
					
					switch (chunk.identifier) 
					{
						case CHUNK_MAIN:
						{
							NSLog( @"Found main 3DS file Chunk" );
							pos += hsize;
							break;
						}	
						case CHUNK_VERSION:
						{
							unsigned short version	= readI2(&p[pos+hsize]);
							NSLog( @"Found 3DS Version Chunk : %d", version );
							pos += chunk.length;
							break;
						}	
						case CHUNK_OBJMESH:
						{
							NSLog( @"Found OBJECT MESH Chunk" );
							read_OBJMESH( &p[pos+hsize], chunk.length - hsize );
							pos += chunk.length;
							break;
						}	
						default:
							NSLog( @"Unknown chunkID : (0x%04x)", chunk.identifier );
							pos += chunk.length;
							break;
					}
				}
				
				return ( m_objects.size() > 0 );
			}
		}
		return FALSE;
	}
	
	void MAX3DSModel::read_OBJMESH( const unsigned char * _data, int _len )
	{
		MAX3DS_ChunkHeader chunk;
		int hsize			= MAX3DS_ChunkHeaderSize;
		int pos				= 0;
		int length			= _len;
		
		while ( pos < length )
		{
			chunk.identifier	= readI2(&_data[pos]);
			chunk.length		= readI4(&_data[pos+2]);
			
			switch (chunk.identifier) {
					
				case CHUNK_OBJBLOCK:
					read_OBJBLOCK( &_data[pos+hsize], chunk.length - hsize );
					break;
					
				case CHUNK_MAT_MATERIAL:
					DPrint(@"Skip Material info");
					break;
					
				default:
					NSLog( @"Unknown chunkID : (0x%04x)", chunk.identifier );
					break;
			}		
			pos += chunk.length;
		}
	}
	
	void MAX3DSModel::read_OBJBLOCK( const unsigned char * _data, int _len )
	{
		MAX3DS_OBJECT		object;
		MAX3DS_ChunkHeader  chunk;
		int hsize			= MAX3DS_ChunkHeaderSize;
		int pos				= 0;
		int length			= _len;
		
		int namelen			= readStringLength( _data );
		pos += namelen + 1; // null terminator
		
		memset(&object, 0, MIN( sizeof(MAX3DS_OBJECT), 20 ) );
		memcpy(&object.header.name, _data, namelen + 1);
		
		while ( pos < length )
		{
			chunk.identifier	= readI2(&_data[pos]);
			chunk.length		= readI4(&_data[pos+2]);
			
			switch (chunk.identifier) 
			{
				case CHUNK_TRIMESH:
					read_TRIMESH( &_data[pos+hsize], chunk.length-hsize, object );
					break;
					
				default:
					NSLog( @"Unknown chunkID : (0x%04x)", chunk.identifier );
					break;
			}
			
			pos += chunk.length;
		}
		
		if ( object.header.numVerts )
		{
			m_objects.push_back( object );
		}
	}
	
	void MAX3DSModel::read_TRIMESH( const unsigned char * _data, int _len, MAX3DS_OBJECT & _object )
	{
		MAX3DS_ChunkHeader chunk;
		int hsize			= MAX3DS_ChunkHeaderSize;
		int pos				= 0;
		int length			= _len;
		
		while (pos < length)
		{
			chunk.identifier	= readI2(&_data[pos]);
			chunk.length		= readI4(&_data[pos+2]);
			
			switch (chunk.identifier) 
			{
				case CHUNK_VERTLIST:
				{
					NSLog(@"CHUNK_VERTLIST");
					
					_object.header.numVerts = readI2(&_data[pos+hsize]);
					_object.verts			= (MAX3DS_VERTEX*)&_data[pos+hsize+2];
					
					break;
				}	
				case CHUNK_FACELIST:
				{
					NSLog(@"CHUNK_FACELIST");
					
					_object.header.numFaces	= readI2(&_data[pos+hsize]);
					_object.faces			= (MAX3DS_FACE*)&_data[pos+hsize+2];
					
					break;
				}	
				case CHUNK_MAPLIST:
				{
					NSLog(@"CHUNK_MAPLIST");
					
					_object.header.numUVs	= readI2(&_data[pos+hsize]);
					_object.uvs				= (MAX3DS_UV*)&_data[pos+hsize+2];
					
					break;
				}	
				case CHUNK_TRMATRIX:
				{
					NSLog(@"CHUNK_TRMATRIX");
					
					_object.matrix			= (MAX3DS_MATRIX*)&_data[pos+hsize];
					
					break;
				}	
				case CHUNK_MESHCOLOR:
				{
					NSLog(@"CHUNK_MESHCOLOR");
					
					
					break;
				}	
				default:
					NSLog( @"Unknown chunkID : (0x%04x)", chunk.identifier );
					break;
			}
			
			pos += chunk.length;
		}
	}

};