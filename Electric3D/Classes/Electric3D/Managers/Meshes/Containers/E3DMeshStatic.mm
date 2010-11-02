//
//  E3DMeshStatic.m
//  Electric3D
//
//  Created by Robert McDowell on 23/09/2010.
//  Copyright 2010 Electric TopHat Ltd. All rights reserved.
//

#import "E3DMeshStatic.h"
#import "Compression.h"


namespace E3D 
{
#pragma mark ---------------------------------------------------------
#pragma mark Internal Consts 
#pragma mark ---------------------------------------------------------
	
	// MeshStatic Identifyer
	const int _MSFileIdent   = 90876712;
	// MeshStatic format version
	const int _MSFileVersion = 1;
	
#pragma mark ---------------------------------------------------------
#pragma mark End Internal Consts 
#pragma mark ---------------------------------------------------------
	
#pragma mark ---------------------------------------------------------
#pragma mark Constructor / Destructor
#pragma mark ---------------------------------------------------------
	
	E3DMeshStatic::E3DMeshStatic( NSData *	_data, NSString * _name )
	: E3DMesh		( _name )
	, m_data		( nil )
	, m_header		( 0 )
	, m_info		( 0 )
	, m_verts		( 0 )
	, m_indices		( 0 )
	{		
		m_data = _data;
		setup();
	}
	
	E3DMeshStatic::E3DMeshStatic( void * _buffer, unsigned int _length, NSString * _name )
	: E3DMesh		( _name )
	, m_data		( nil )
	, m_header		( 0 )
	, m_info		( 0 )
	, m_verts		( 0 )
	, m_indices		( 0 )
	{
		// -----------------------------------------------
		// pass the bytes into an NSData object 
		// and control over to it
		// -----------------------------------------------
		m_data = [[[NSData alloc] initWithBytes:_buffer length:_length] autorelease];
		// -----------------------------------------------
		
		// -----------------------------------------------
		// setup the data
		// -----------------------------------------------
		setup();
		// -----------------------------------------------
	}
	
	E3DMeshStatic::E3DMeshStatic( const E3DMeshStaticInfo & _info, NSString * _name )
	: E3DMesh		( _name )
	, m_data		( nil )
	, m_header		( 0 )
	, m_info		( 0 )
	, m_verts		( 0 )
	, m_indices		( 0 )
	{		
		// -----------------------------------------------
		// malloc the data
		// -----------------------------------------------
		int buffer  = sizeof(GLInterleavedVert3D) * _info.numverts;
		int indices = ( _info.numindices ) ? sizeof(GLVertIndice) * _info.numindices : 0;
		int header	= sizeof(E3DMeshFileHeader);
		int info	= sizeof(E3DMeshStaticInfo);
		int space	= header + info + buffer + indices;

		unsigned char * bytes = (unsigned char *)memset( malloc( space ), 0, space );
		// -----------------------------------------------
		
		// -----------------------------------------------
		// pass the bytes into an NSData object 
		// and control over to it
		// -----------------------------------------------
		m_data = [[[NSData alloc] initWithBytesNoCopy:bytes length:space] autorelease];
		// -----------------------------------------------
		
		// -----------------------------------------------
		// Fix up the header pointer
		// -----------------------------------------------
		m_header = (E3DMeshFileHeader*)bytes;
		// -----------------------------------------------
		
		// -----------------------------------------------
		// Setup the header information
		// -----------------------------------------------
		m_header->ident		= _MSFileIdent;
		m_header->version	= _MSFileVersion;
		// -----------------------------------------------
		
		// -----------------------------------------------
		// Setup the animation info data
		// -----------------------------------------------
		m_info				= (E3DMeshStaticInfo*)&bytes[header];
		m_info->numverts	= _info.numverts;
		m_info->numindices	= _info.numindices;
		m_info->aabb		= _info.aabb;
		// -----------------------------------------------
		
		// -----------------------------------------------
		// Setup the data set
		// -----------------------------------------------
		setup();	
		// -----------------------------------------------
	}
	
	E3DMeshStatic::~E3DMeshStatic()
	{
		[m_data release];
	}
	
#pragma mark ---------------------------------------------------------
#pragma mark End Constructor / Destructor
#pragma mark ---------------------------------------------------------
	
#pragma mark ---------------------------------------------------------
#pragma mark === Private Functions  ===
#pragma mark ---------------------------------------------------------
	
	BOOL E3DMeshStatic::setup()
	{
		int header = sizeof( E3DMeshFileHeader );
		if ( [m_data length] > header )
		{
			unsigned char * p = (unsigned char*)[m_data bytes];
			
			m_header = (E3DMeshFileHeader*)p;
			if ( m_header->ident != _MSFileIdent )
			{
				m_header = 0;
				m_data = nil;
			}
			else if ( m_header->version != _MSFileVersion )
			{
				m_header = 0;
				m_data = nil;
			}
			else 
			{	
				// -----------------------------------------------
				// keep the bytes in memory
				// -----------------------------------------------
				[m_data retain];
				// -----------------------------------------------
				
				// -----------------------------------------------
				// Setup the animation info data
				// -----------------------------------------------
				m_info				= (E3DMeshStaticInfo*)&p[header];
				// -----------------------------------------------
				
				// -----------------------------------------------				
				int vertsoffset		= header + sizeof(E3DMeshStaticInfo);
				// -----------------------------------------------
				
				// -----------------------------------------------
				// set up the vert pointer
				// -----------------------------------------------
				m_verts = (GLInterleavedVert3D*)&p[vertsoffset];
				
				// set up the indices list
				if ( m_info->numindices )
				{
					int verts			= ( sizeof(GLInterleavedVert3D) * m_info->numverts );
					int indicesoffset	= vertsoffset + verts;
					
					m_indices = (GLVertIndice*)&p[indicesoffset];
				}
				
				return TRUE;
			}
		}
		return FALSE;
	}
	
#pragma mark ---------------------------------------------------------
#pragma mark === End Private Functions  ===
#pragma mark ---------------------------------------------------------
};