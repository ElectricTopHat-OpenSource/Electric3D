/* -*- c++ -*- */
/////////////////////////////////////////////////////////////////////////////
//
// Md2Model.cpp -- Copyright (c) 2004-2006 David Henry
// last modification: feb. 25, 2006
//
// This code is licenced under the MIT license.
//
// This software is provided "as is" without express or implied
// warranties. You may freely copy and compile this source into
// applications you distribute provided that the copyright text
// below is included in the resulting source code.
//
// Implementation of MD2 Model classes.
//
/////////////////////////////////////////////////////////////////////////////

//#include <stdio.h>
//#include <stdlib.h>
//#include <string.h>

#include "MD2Model.h"

namespace MD2
{
	
	/////////////////////////////////////////////////////////////////////////////
	//
	// class cMd2Model implementation.
	//
	/////////////////////////////////////////////////////////////////////////////
		
	// Magic number (should be 844121161)
	const int _kMd2Ident = 'I' + ('D'<<8) + ('P'<<16) + ('2'<<24);
	
	// MD2 format version
	const int _kMd2Version = 8;
	
	// MD2 Max Frames
	const unsigned int _kMd2MaxFrames = 256;
	
	
	// ---------------------------------------------------------------
	// Constructor
	// ---------------------------------------------------------------
	MD2Model::MD2Model(NSData * _data)
	: m_data ( nil )
	{
		set( _data );
	}
	
	// ---------------------------------------------------------------
	// Constructor
	// ---------------------------------------------------------------
	MD2Model::MD2Model(const void * _data, int _len)
	: m_data ( nil )
	{
		set( _data, _len );
	}
	
	// ---------------------------------------------------------------
	// Destructor
	// ---------------------------------------------------------------
	MD2Model::~MD2Model()
	{
		[m_data release];
	}
	
	// ---------------------------------------------------------------
	// invalidate the model
	// ---------------------------------------------------------------
	void MD2Model::invalidate()
	{
		m_header, m_skins, m_texCoords, m_triangles, m_glcmds = 0;
		memset(m_frames, 0, sizeof(m_frames));
		
		[m_data release]; m_data = nil;
	}
	
	// ---------------------------------------------------------------
	// change the model data
	// ---------------------------------------------------------------
	BOOL MD2Model::set( NSData * _data )
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
	BOOL MD2Model::set( const void * _data, int _len )
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
	BOOL MD2Model::fill( const void * _data, int _len )
	{
		if ( _len >= sizeof(Md2Header) )
		{
			// -------------------------------------
			// set the pointer to the header
			// -------------------------------------
			m_header = (Md2Header*)_data;
			// -------------------------------------
			
			// Check if ident and version are valid
			if (m_header->ident != _kMd2Ident)
			{
				m_header = 0;
			}
			else if (m_header->version != _kMd2Version)
			{
				m_header = 0;
			}
			else 
			{	
				unsigned char * p = (unsigned char*)_data;
				
				m_skins			= (Md2Skin*) &p[m_header->offset_skins];
				m_texCoords		= (Md2TexCoord*) &p[m_header->offset_st];
				m_triangles		= (Md2Triangle*) &p[m_header->offset_tris];
				m_glcmds		= (int*) &p[m_header->offset_glcmds];
				
				// Read frames
				int nAt = m_header->offset_frames;
				int frames = MIN( 256, m_header->num_frames );
				for (int i = 0; i < frames; ++i) 
				{
					// Memory allocation for the vertices of this frame
					m_frames[i] = (Md2Frame*)&p[nAt];
					nAt += m_header->framesize;
				}
				
				return true;
			}
		}
		return false;
	}

}