//
//  GLMeshStatic.m
//  Electric3D
//
//  Created by Robert McDowell on 23/09/2010.
//  Copyright 2010 Electric TopHat Ltd. All rights reserved.
//

#import "GLMeshStatic.h"
#import "Compression.h"

#define USE_COMPRESSED_MS_FILE 1

namespace GLMeshes 
{
#pragma mark ---------------------------------------------------------
#pragma mark Internal Consts 
#pragma mark ---------------------------------------------------------
	
	// MeshStatic Identifyer
	const int _kMSIdent   = 90876712;
	// MeshStatic format version
	const int _kMSVersion = 1;
	
#pragma mark ---------------------------------------------------------
#pragma mark End Internal Consts 
#pragma mark ---------------------------------------------------------
	
#pragma mark ---------------------------------------------------------
#pragma mark Constructor / Destructor
#pragma mark ---------------------------------------------------------
	
	GLMeshStatic::GLMeshStatic( NSString * _filePath )
	: GLMesh		( _filePath )
	, m_data		( 0 )
	, m_header		( 0 )
	, m_verts		( 0 )
	{
		read( _filePath );
	}
	
	GLMeshStatic::GLMeshStatic( unsigned int _numverts, NSString * _name )
	: GLMesh		( _name )
	, m_data		( 0 )
	, m_header		( 0 )
	, m_verts		( 0 )
	{
		// -----------------------------------------------
		// malloc the data
		// -----------------------------------------------
		int space = sizeof( GLMeshStaticHeader ) + ( sizeof(GLInterleavedVert3D) * _numverts );
		void * bytes = (void*)malloc( space );
		memset(bytes, 0, space);
		// -----------------------------------------------
		
		// -----------------------------------------------
		// pass the bytes into an NSData object 
		// and control over to it
		// -----------------------------------------------
		m_data = [[NSData alloc] initWithBytesNoCopy:bytes length:space];
		// -----------------------------------------------
		
		// -----------------------------------------------
		// Fix up the header pointer
		// -----------------------------------------------
		m_header = (GLMeshStaticHeader*)bytes;
		// -----------------------------------------------
		
		// -----------------------------------------------
		// Setup the header information
		// -----------------------------------------------
		m_header->ident		= _kMSIdent;
		m_header->version	= _kMSVersion;
		m_header->numverts	= _numverts;
		// -----------------------------------------------
		
		// -----------------------------------------------
		// Fix up the pointers
		// -----------------------------------------------
		unsigned char * p = (unsigned char*)bytes;
		m_verts = (GLInterleavedVert3D*)&p[sizeof( GLMeshStaticHeader )];
		// -----------------------------------------------
	}
	
	GLMeshStatic::~GLMeshStatic()
	{
		[m_data release];
	}
	
#pragma mark ---------------------------------------------------------
#pragma mark End Constructor / Destructor
#pragma mark ---------------------------------------------------------

#pragma mark ---------------------------------------------------------
#pragma mark Public Functions
#pragma mark ---------------------------------------------------------
	
	BOOL GLMeshStatic::read( NSString * _filePath )
	{
		NSFileHandle * file = [NSFileHandle fileHandleForReadingAtPath:_filePath];
		if ( file )
		{
#if USE_COMPRESSED_MS_FILE
			
			// read the compressed file
			NSData * compressed = [file readDataToEndOfFile];
			
			NSLog( @"Read compressed file of size %d", [compressed length] );
			
			m_data = [Compression gzipInflate:compressed];
			//m_data = [Compression zlibInflate:compressed];
			
			NSLog( @"Memory foot print size       %d", [m_data length] );
#else
			m_data = [file readDataToEndOfFile];
#endif
			
			int headerSize = sizeof( GLMeshStaticHeader );
			
			if ( [m_data length] > headerSize )
			{
				unsigned char * p = (unsigned char*)[m_data bytes];
				
				m_header = (GLMeshStaticHeader*)p;
				if ( m_header->ident != _kMSIdent )
				{
					m_header = 0;
					m_data = nil;
					return false;
				}
				else if ( m_header->version != _kMSVersion )
				{
					m_header = 0;
					m_data = nil;
					return false;
				}
				else 
				{
					// keep the bytes in memory
					[m_data retain];
					
					// set up the vert pointer
					m_verts = (GLInterleavedVert3D*)&p[headerSize];
					
					return true;
				}
			}
		}
		
		return false;
	}
	
	BOOL GLMeshStatic::write( NSString * _filePath ) const
	{
		if ( m_data )
		{
#if USE_COMPRESSED_MS_FILE
			NSLog( @"Memory foot print size        %d", [m_data length] );
			
			NSData * compressed = [Compression gzipDeflate:m_data];
			//NSData * compressed = [Compression zlibDeflate:m_data];
			
			NSLog( @"Write compressed file of size %d", [compressed length] );
			
			return [compressed writeToFile:_filePath atomically:YES];
#else
			return [m_data writeToFile:_filePath atomically:YES];
#endif
		}
		return false;
	}
	
#pragma mark ---------------------------------------------------------
#pragma mark End Public Functions
#pragma mark ---------------------------------------------------------
};