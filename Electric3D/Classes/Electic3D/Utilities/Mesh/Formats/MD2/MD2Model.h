/* -*- c++ -*- */
/////////////////////////////////////////////////////////////////////////////
//
// Md2Model.h -- Copyright (c) 2005-2006 David Henry
// last modification: feb. 25, 2006
//
// This code is licenced under the MIT license.
//
// This software is provided "as is" without express or implied
// warranties. You may freely copy and compile this source into
// applications you distribute provided that the copyright text
// below is included in the resulting source code.
//
// Definition of MD2 Model Classes.
//
/////////////////////////////////////////////////////////////////////////////

#ifndef __MD2MODEL_H__
#define __MD2MODEL_H__	

#import "MD2Types.h"

namespace MD2
{
	extern const unsigned int _kMd2MaxFrames;

	// --------------------------------------------
	// class cMd2Model -- MD2 Model Data Class.
	// --------------------------------------------
	class MD2Model 
	{
	public: // Functions
		
		MD2Model(NSData * _data = nil);
		MD2Model(const void * data, int len);
		~MD2Model();
		
	public: // Functions
		
		inline BOOL valid() const { return m_data != 0; };
		
		void invalidate();
		
		BOOL set( NSData * _data );
		BOOL set( const void * _data, int _len );
		
		inline const Md2Header *	header() const { return m_header; };
		inline const Md2Skin *		skins() const { return m_skins; };
		inline const Md2TexCoord *	texCoords() const { return m_texCoords; };
		inline const Md2Triangle *	triangles() const { return m_triangles; };
		inline const unsigned int	numverts() const { return (m_header) ? m_header->num_tris*3 : 0; };
		
		inline const unsigned int	numframes() const { return (m_header) ? m_header->num_frames : 0; };
		inline const Md2Frame *		frames() const { return *m_frames; };
		inline const Md2Frame *		frame( unsigned int _index ) const { return m_frames[_index]; };
		
	private: // Functions
		
		BOOL fill( const void * _data, int _len );
		
	private: // Data
		NSData *		m_data;
		
		Md2Header *		m_header;
		Md2Skin *		m_skins;
		Md2TexCoord *	m_texCoords;
		Md2Triangle *	m_triangles;
		Md2Frame*		m_frames[256];
		int *			m_glcmds;
	};
};
	
#endif // __MD2_H__

