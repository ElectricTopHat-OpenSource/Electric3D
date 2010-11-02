//
//  E3DMeshMorph.m
//  Electric3D
//
//  Created by Robert McDowell on 23/09/2010.
//  Copyright 2010 Electric TopHat Ltd. All rights reserved.
//

#import "E3DMeshMorph.h"

namespace E3D 
{	
#pragma mark ---------------------------------------------------------
#pragma mark Internal Consts 
#pragma mark ---------------------------------------------------------
	
	// MeshVertexAnimation Identifyer
	const int _MMFileIdent   = 2143464;
	// MeshVertexAnimation format version
	const int _MMFileVersion = 1;
	
#pragma mark ---------------------------------------------------------
#pragma mark End Internal Consts 
#pragma mark ---------------------------------------------------------
	
#pragma mark ---------------------------------------------------------
#pragma mark Constructor / Destructor
#pragma mark ---------------------------------------------------------
	
	
	E3DMeshMorph::E3DMeshMorph( NSData *	_data, NSString * _name )
	: E3DMesh		( _name )
	, m_data		( nil )
	, m_header		( 0 )
	, m_info		( 0 )
	, m_iterpverts	( 0 )
	, m_indices		( 0 )
	, m_vertsaabb	( 0 )
	{		
		// -----------------------------------------------
		// refrence the current pointer
		// -----------------------------------------------
		m_data = _data;
		// -----------------------------------------------
		
		// -----------------------------------------------
		// Setup the data
		// -----------------------------------------------
		setup();
		// -----------------------------------------------
	}
	
	E3DMeshMorph::E3DMeshMorph( void * _buffer, unsigned int _length, NSString * _name )
	: E3DMesh		( _name )
	, m_data		( nil )
	, m_header		( 0 )
	, m_info		( 0 )
	, m_iterpverts	( 0 )
	, m_indices		( 0 )
	, m_vertsaabb	( 0 )
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
	
	
	E3DMeshMorph::E3DMeshMorph( const E3DMeshMorphInfo & _info, NSString * _name )
	: E3DMesh( _name )
	, m_data		( 0 )
	, m_header		( 0 )
	, m_info		( 0 )
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
		int header	= sizeof(E3DMeshFileHeader);
		int info	= sizeof(E3DMeshMorphInfo);
		
		int buffer  = sizeof(GLInterleavedVert3D) * _info.numverts;
		int indices = sizeof(GLVertIndice) * _info.numindices;
		
		int chunk	= sizeof(_GLVert3D) * _info.numverts;
		int aabbs	= sizeof(CGMaths::CGAABB);
		
		// this is x number of vert frames + 1 for the interperied frame
		int space   = header + info + buffer + indices + ( chunk * numframes ) + ( aabbs * numframes );
		
		unsigned char * bytes = (unsigned char *)memset( malloc( space ), 0, space );
		// -----------------------------------------------
		
		// -----------------------------------------------
		// pass the bytes into an NSData object 
		// and control over to it
		// -----------------------------------------------
		m_data = [[[NSData alloc] initWithBytesNoCopy:bytes length:space] autorelease];
		// -----------------------------------------------
		
		// -----------------------------------------------
		// Setup the File header information
		// -----------------------------------------------
		m_header			= (E3DMeshFileHeader*)bytes;
		m_header->ident		= _MMFileIdent;
		m_header->version	= _MMFileVersion;
		// -----------------------------------------------
		
		// -----------------------------------------------
		// Setup the animation info data
		// -----------------------------------------------
		m_info				= (E3DMeshMorphInfo*)&bytes[header];		
		m_info->numframes	= numframes;
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
	
	E3DMeshMorph::~E3DMeshMorph()
	{
		[m_data release];
	}
	
#pragma mark ---------------------------------------------------------
#pragma mark End Constructor / Destructor
#pragma mark ---------------------------------------------------------
	
#pragma mark ---------------------------------------------------------
#pragma mark === Public Functions  ===
#pragma mark ---------------------------------------------------------
		
	const GLInterleavedVert3D *	E3DMeshMorph::interpverts( unsigned int _frame ) const
	{
		_GLVert3D * v = m_verts[MIN(_frame, m_info->numframes-1)];
		
		int i;
		for (i=0; i<m_info->numverts; i++)
		{
			m_iterpverts[i].vert.x = v[i].x;
			m_iterpverts[i].vert.y = v[i].y;
			m_iterpverts[i].vert.z = v[i].z;
		}
		
		return m_iterpverts;
	}
	
	const CGMaths::CGAABB &	E3DMeshMorph::aabb( unsigned int _frame1, unsigned int _frame2, float _interp ) const
	{
		float  value = MAX( MIN( _interp, 1.0f ), 0.0f );
		const CGMaths::CGAABB & v1 = m_vertsaabb[MIN(_frame1, m_info->numframes-1)];
		const CGMaths::CGAABB & v2 = m_vertsaabb[MIN(_frame2, m_info->numframes-1)];
		
		m_info->aabb.min.x = LERP( v1.min.x, v2.min.x, value );
		m_info->aabb.min.y = LERP( v1.min.y, v2.min.y, value );
		m_info->aabb.min.z = LERP( v1.min.z, v2.min.z, value );
		
		m_info->aabb.max.x = LERP( v1.max.x, v2.max.x, value );
		m_info->aabb.max.y = LERP( v1.max.y, v2.max.y, value );
		m_info->aabb.max.z = LERP( v1.max.z, v2.max.z, value );
		
		return m_info->aabb;
	}
	
	const GLInterleavedVert3D * E3DMeshMorph::interpverts( unsigned int _frame1, unsigned int _frame2, float _interp ) const
	{		
		float  value = MAX( MIN( _interp, 1.0f ), 0.0f );
		_GLVert3D * v1 = m_verts[MIN(_frame1, m_info->numframes-1)];
		_GLVert3D * v2 = m_verts[MIN(_frame2, m_info->numframes-1)];
		int i;
		for (i=0; i<m_info->numverts; i++)
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
	
#pragma mark ---------------------------------------------------------
#pragma mark === Private Functions  ===
#pragma mark ---------------------------------------------------------
	
	BOOL E3DMeshMorph::setup()
	{
		int header = sizeof( E3DMeshFileHeader );
		if ( [m_data length] > header )
		{
			unsigned char * p = (unsigned char*)[m_data bytes];
			
			m_header = (E3DMeshFileHeader*)p;
			if ( m_header->ident != _MMFileIdent )
			{
				m_header = 0;
				m_data = nil;
			}
			else if ( m_header->version != _MMFileVersion )
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
				m_info				= (E3DMeshMorphInfo*)&p[header];
				// -----------------------------------------------
				
				// -----------------------------------------------
				int chunk			= ( sizeof(_GLVert3D) * m_info->numverts );
				int indices			= ( sizeof(GLVertIndice) * m_info->numindices );
				int buffer			= ( sizeof(GLInterleavedVert3D) * m_info->numverts );
				int interpoffset	= header + sizeof(E3DMeshMorphInfo);
				int indicesoffset	= interpoffset + buffer;
				int vertsoffset		= interpoffset + buffer + indices;
				int aabboffset		= interpoffset + buffer + indices + ( chunk * m_info->numframes );
				// -----------------------------------------------
				
				// -----------------------------------------------
				// set up the vert pointer
				// -----------------------------------------------
				m_iterpverts = (GLInterleavedVert3D*)&p[interpoffset];
				m_vertsaabb  = (CGMaths::CGAABB*)&p[aabboffset];
				
				if ( indices )
				{
					m_indices = (GLVertIndice*)&p[indicesoffset];
				}
				
				int i; 
				int offset	= vertsoffset;
				for ( i=0; i<m_info->numframes; i++ )
				{
					m_verts[i] = (_GLVert3D*)&p[offset];
					offset += chunk;
				}	
				// -----------------------------------------------
				
				return TRUE;
			}
		}
		return FALSE;
	}

#pragma mark ---------------------------------------------------------
#pragma mark === End Private Functions  ===
#pragma mark ---------------------------------------------------------
};