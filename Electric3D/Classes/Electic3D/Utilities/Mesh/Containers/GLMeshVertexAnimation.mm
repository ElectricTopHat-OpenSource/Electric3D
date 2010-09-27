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
	{
		read( _filePath );
	}
	
	GLMeshVertexAnimation::GLMeshVertexAnimation( unsigned int _numverts, unsigned int _numframes, NSString * _name )
	: GLMesh( _name )
	, m_data		( 0 )
	, m_header		( 0 )
	, m_iterpverts	( 0 )
	{
		// -----------------------------------------------
		// clamp the number of frames supported
		// -----------------------------------------------
		_numframes = MIN( 256, _numframes );
		// -----------------------------------------------
		
		// -----------------------------------------------
		// malloc the data
		// -----------------------------------------------
		int chunk	= sizeof(GLInterleavedVertNormal3D) * _numverts;
		int buffer  = sizeof(GLInterleavedVert3D) * _numverts;
		int header	= sizeof(GLMeshVertexAnimationHeader);
		// this is x number of vert frames + 1 for the interperied frame
		int space   = header + buffer + ( chunk * _numframes );
		
		unsigned char * bytes = (unsigned char *)malloc( space );
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
		m_header = (GLMeshVertexAnimationHeader*)bytes;
		// -----------------------------------------------
		
		// -----------------------------------------------
		// Setup the header information
		// -----------------------------------------------
		m_header->ident		= _kMVAIdent;
		m_header->version	= _kMVAVersion;
		m_header->numverts	= _numverts;
		m_header->numframes	= _numframes;
		// -----------------------------------------------
		
		// -----------------------------------------------
		// Fix up the pointers
		// -----------------------------------------------
		int interpoffset = header;
		int vertsoffset  = header + buffer;
		
		// set up the vert pointer
		m_iterpverts = (GLInterleavedVert3D*)&bytes[interpoffset];
		
		int i; 
		int offset	= vertsoffset;
		for ( i=0; i<_numframes; i++ )
		{
			m_verts[i] = (GLInterleavedVertNormal3D*)&bytes[offset];
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
#if USE_COMPRESSED_MVA_FILE
			// read the compressed file
			NSData * compressed = [file readDataToEndOfFile];
			
			NSLog( @"Read compressed file of size %d", [compressed length] );
			
			m_data = [Compression gzipInflate:compressed];
			//m_data = [Compression zlibInflate:compressed];
			
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
					
					int chunk   = ( sizeof( GLInterleavedVert3D ) * m_header->numverts );
					int buffer  = ( sizeof(GLInterleavedVert3D) * m_header->numverts );
					int interpoffset = headerSize;
					int vertsoffset  = interpoffset + buffer;
					
					// set up the vert pointer
					m_iterpverts = (GLInterleavedVert3D*)&p[interpoffset];
					
					int i; 
					int offset	= vertsoffset;
					for ( i=0; i<m_header->numframes; i++ )
					{
						m_verts[i] = (GLInterleavedVertNormal3D*)&p[offset];
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
	
	const GLInterleavedVert3D * GLMeshVertexAnimation::interpverts( unsigned int _frame1, unsigned int _frame2, float _interp ) const
	{
		float  value = MIN( MAX( _interp, 1.0f ), 0.0f );
		GLInterleavedVertNormal3D * v1 = m_verts[_frame1];
		GLInterleavedVertNormal3D * v2 = m_verts[_frame2];
		int i;
		for (i=0; i<m_header->numverts; i++)
		{
			m_iterpverts[i].vert.x = v1[i].vert.x + value*(v2[i].vert.x - v1[i].vert.x);
			m_iterpverts[i].vert.y = v1[i].vert.y + value*(v2[i].vert.y - v1[i].vert.y);
			m_iterpverts[i].vert.z = v1[i].vert.z + value*(v2[i].vert.z - v1[i].vert.z);
			
			m_iterpverts[i].normal.x = v1[i].normal.x + value*(v2[i].normal.x - v1[i].normal.x);
			m_iterpverts[i].normal.y = v1[i].normal.y + value*(v2[i].normal.y - v1[i].normal.y);
			m_iterpverts[i].normal.z = v1[i].normal.z + value*(v2[i].normal.z - v1[i].normal.z);
			
			//m_iterpverts[i].uv.x = v1[i].uv.x + value*(v2[i].uv.x - v1[i].uv.x);
			//m_iterpverts[i].uv.y = v1[i].uv.y + value*(v2[i].uv.y - v1[i].uv.y);
			
#if GLInterleavedVert3D_color
			//m_iterpverts[i].color.red = v1[i].color.red + value*(v2[i].color.red- v1[i].color.red);
			//m_iterpverts[i].color.green = v1[i].color.green + value*(v2[i].color.green- v1[i].color.green);
			//m_iterpverts[i].color.blue = v1[i].color.blue + value*(v2[i].color.blue- v1[i].color.blue);
			//m_iterpverts[i].color.alpha = v1[i].color.alpha + value*(v2[i].color.alpha- v1[i].color.alpha);
#endif
		}
		
		return m_iterpverts;
	}
	
#pragma mark ---------------------------------------------------------
#pragma mark === End Public Functions  ===
#pragma mark ---------------------------------------------------------
};