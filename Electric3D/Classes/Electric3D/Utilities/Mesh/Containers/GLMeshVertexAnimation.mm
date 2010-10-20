//
//  GLMeshVertexAnimation.m
//  Electric3D
//
//  Created by Robert McDowell on 23/09/2010.
//  Copyright 2010 Electric TopHat Ltd. All rights reserved.
//

#import "GLMeshVertexAnimation.h"
#import "Compression.h"

#define USE_COMPRESSED_MVA_FILE 1

namespace GLMeshes 
{
#pragma mark ---------------------------------------------------------
#pragma mark Internal Consts 
#pragma mark ---------------------------------------------------------
	
	// MeshVertexAnimation Identifyer
	const int _kMVAIdent   = 2143464;
	// MeshVertexAnimation format version
	const int _kMVAVersion = 1;
	
#pragma mark ---------------------------------------------------------
#pragma mark End Internal Consts 
#pragma mark ---------------------------------------------------------
	
#pragma mark ---------------------------------------------------------
#pragma mark Constructor / Destructor
#pragma mark ---------------------------------------------------------
	
	GLMeshVertexAnimation::GLMeshVertexAnimation( NSString * _filePath )
	: GLMesh		( _filePath )
	, m_data		( 0 )
	, m_header		( 0 )
	, m_iterpverts	( 0 )
	, m_indices		( 0 )
	, m_vertsaabb	( 0 )
	{
		read( _filePath );
	}
	
	GLMeshVertexAnimation::GLMeshVertexAnimation( const GLMeshVertexAnimationInfo & _info, NSString * _name )
	: GLMesh( _name )
	, m_data		( 0 )
	, m_header		( 0 )
	, m_iterpverts	( 0 )
	, m_indices		( 0 )
	, m_vertsaabb	( 0 )
	{
		// -----------------------------------------------
		// clamp the number of frames supported
		// -----------------------------------------------
		NSInteger numframes = MIN( 256, _info.numframes );
		// -----------------------------------------------
		
		// -----------------------------------------------
		// malloc the data
		// -----------------------------------------------
		int chunk	= sizeof(_GLVert3D) * _info.numverts;
		int indices = sizeof(GLVertIndice) * _info.numindices;
		int buffer  = sizeof(GLInterleavedVert3D) * _info.numverts;
		int header	= sizeof(GLMeshVertexAnimationHeader);
		int aabbs	= sizeof(CGMaths::CGAABB);
		// this is x number of vert frames + 1 for the interperied frame
		int space   = header + buffer + indices + ( chunk * numframes ) + ( aabbs * numframes );
		
		unsigned char * bytes = (unsigned char *)memset( malloc( space ), 0, space );
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
		m_header = (GLMeshVertexAnimationHeader*)bytes;
		// -----------------------------------------------
		
		// -----------------------------------------------
		// Setup the header information
		// -----------------------------------------------
		m_header->ident		= _kMVAIdent;
		m_header->version	= _kMVAVersion;
		memcpy( &m_header->info, &_info, sizeof(GLMeshVertexAnimationInfo) );
		
		// limit the number of frames supported
		m_header->info.numframes = numframes;
		// -----------------------------------------------
		
		// -----------------------------------------------
		// Fix up the pointers
		// -----------------------------------------------
		int interpoffset	= header;
		int indicesoffset	= header + buffer;
		int vertsoffset		= header + buffer + indices;
		int aabboffset		= header + buffer + indices + ( chunk * numframes );
		
		// set up the vert pointer
		m_iterpverts = (GLInterleavedVert3D*)&bytes[interpoffset];
		m_vertsaabb  = (CGMaths::CGAABB*)&bytes[aabboffset];
		
		if ( indices )
		{
			m_indices = (GLVertIndice*)&bytes[indicesoffset];
		}
		
		int i; 
		int offset	= vertsoffset;
		for ( i=0; i<m_header->info.numframes; i++ )
		{
			m_verts[i] = (_GLVert3D*)&bytes[offset];
			offset += chunk;
		}	
		// -----------------------------------------------
	}
	
	GLMeshVertexAnimation::~GLMeshVertexAnimation()
	{
		[m_data release];
	}
	
#pragma mark ---------------------------------------------------------
#pragma mark End Constructor / Destructor
#pragma mark ---------------------------------------------------------
	
#pragma mark ---------------------------------------------------------
#pragma mark === Public Functions  ===
#pragma mark ---------------------------------------------------------
	
	BOOL GLMeshVertexAnimation::read( NSString * _filePath )
	{
		NSFileHandle * file = [NSFileHandle fileHandleForReadingAtPath:_filePath];
		if ( file )
		{
			// release the old file
			SAFE_RELEASE(m_data);
			
#if USE_COMPRESSED_MVA_FILE
			// read the compressed file
			NSData * compressed = [file readDataToEndOfFile];
			
			NSLog( @"Read compressed file of size %d", [compressed length] );
			
			m_data = Compressor::gzip::inflate( compressed );
			//m_data = Compressor::zlib::inflate( compressed );
			
			NSLog( @"Memory foot print size       %d", [m_data length] );
#else
			m_data = [file readDataToEndOfFile];
#endif
			
			int headerSize = sizeof( GLMeshVertexAnimationHeader );
			
			if ( [m_data length] > headerSize )
			{
				unsigned char * p = (unsigned char*)[m_data bytes];
				
				m_header = (GLMeshVertexAnimationHeader*)p;
				if ( m_header->ident != _kMVAIdent )
				{
					m_header = 0;
					m_data = nil;
					return false;
				}
				else if ( m_header->version != _kMVAVersion )
				{
					m_header = 0;
					m_data = nil;
					return false;
				}
				else 
				{					
					// keep the bytes in memory
					[m_data retain];
					
					int chunk			= ( sizeof(_GLVert3D) * m_header->info.numverts );
					int indices			= ( sizeof(GLVertIndice) * m_header->info.numindices );
					int buffer			= ( sizeof(GLInterleavedVert3D) * m_header->info.numverts );
					int interpoffset	= headerSize;
					int indicesoffset	= headerSize + buffer;
					int vertsoffset		= headerSize + buffer + indices;
					int aabboffset		= headerSize + buffer + indices + ( chunk * m_header->info.numframes );
					
					// set up the vert pointer
					m_iterpverts = (GLInterleavedVert3D*)&p[interpoffset];
					m_vertsaabb  = (CGMaths::CGAABB*)&p[aabboffset];
					
					if ( indices )
					{
						m_indices = (GLVertIndice*)&p[indicesoffset];
					}
					
					int i; 
					int offset	= vertsoffset;
					for ( i=0; i<m_header->info.numframes; i++ )
					{
						m_verts[i] = (_GLVert3D*)&p[offset];
						offset += chunk;
					}					
					return true;
				}
			}
		}
		return false;
	}
	
	BOOL GLMeshVertexAnimation::write( NSString * _filePath ) const 
	{
		if ( m_data )
		{
#if USE_COMPRESSED_MVA_FILE
			NSLog( @"Memory foot print size        %d", [m_data length] );
			
			NSData * compressed = Compressor::gzip::deflate( m_data );
			//NSData * compressed = Compressor::gzip::deflate( m_data );
			
			NSLog( @"Write compressed file of size %d", [compressed length] );
			
			return [compressed writeToFile:_filePath atomically:YES];
#else
			return [m_data writeToFile:_filePath atomically:YES];
#endif
		}
		return false;
	}
	
	const GLInterleavedVert3D *	GLMeshVertexAnimation::interpverts( unsigned int _frame ) const
	{
		_GLVert3D * v = m_verts[MIN(_frame, m_header->info.numframes-1)];
		
		int i;
		for (i=0; i<m_header->info.numverts; i++)
		{
			m_iterpverts[i].vert.x = v[i].x;
			m_iterpverts[i].vert.y = v[i].y;
			m_iterpverts[i].vert.z = v[i].z;
		}
		
		return m_iterpverts;
	}
	
	const CGMaths::CGAABB &	GLMeshVertexAnimation::aabb( unsigned int _frame1, unsigned int _frame2, float _interp ) const
	{
		float  value = MAX( MIN( _interp, 1.0f ), 0.0f );
		const CGMaths::CGAABB & v1 = m_vertsaabb[MIN(_frame1, m_header->info.numframes-1)];
		const CGMaths::CGAABB & v2 = m_vertsaabb[MIN(_frame2, m_header->info.numframes-1)];
		
		m_header->info.aabb.min.x = LERP( v1.min.x, v2.min.x, value );
		m_header->info.aabb.min.y = LERP( v1.min.y, v2.min.y, value );
		m_header->info.aabb.min.z = LERP( v1.min.z, v2.min.z, value );
		
		m_header->info.aabb.max.x = LERP( v1.max.x, v2.max.x, value );
		m_header->info.aabb.max.y = LERP( v1.max.y, v2.max.y, value );
		m_header->info.aabb.max.z = LERP( v1.max.z, v2.max.z, value );
		
		return m_header->info.aabb;
	}
	
	const GLInterleavedVert3D * GLMeshVertexAnimation::interpverts( unsigned int _frame1, unsigned int _frame2, float _interp ) const
	{		
		float  value = MAX( MIN( _interp, 1.0f ), 0.0f );
		_GLVert3D * v1 = m_verts[MIN(_frame1, m_header->info.numframes-1)];
		_GLVert3D * v2 = m_verts[MIN(_frame2, m_header->info.numframes-1)];
		int i;
		for (i=0; i<m_header->info.numverts; i++)
		{
			m_iterpverts[i].vert.x = LERP( v1[i].x, v2[i].x, value );
			m_iterpverts[i].vert.y = LERP( v1[i].y, v2[i].y, value );
			m_iterpverts[i].vert.z = LERP( v1[i].z, v2[i].z, value );
		}
		
		return m_iterpverts;
	}
	
#pragma mark ---------------------------------------------------------
#pragma mark === End Public Functions  ===
#pragma mark ---------------------------------------------------------
};