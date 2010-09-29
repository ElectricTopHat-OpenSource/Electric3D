/*
 *  MD2Types.h
 *  Electric3D
 *
 *  Created by Robert McDowell on 22/09/2010.
 *  Copyright 2010 Electric TopHat Ltd. All rights reserved.
 *
 */

#ifndef __MD2TYPES_H__
#define __MD2TYPES_H__

namespace MD2
{
	// Md2 header
	typedef struct 
	{
		int ident;          // Magic number, "IDP2"
		int version;        // Md2 format version, should be 8
		
		int skinwidth;      // Texture width
		int skinheight;     // Texture height
		
		int framesize;      // Size of a frame, in bytes
		
		int num_skins;      // Number of skins
		int num_vertices;   // Number of vertices per frame
		int num_st;         // Number of texture coords
		int num_tris;       // Number of triangles
		int num_glcmds;     // Number of OpenGL commands
		int num_frames;     // Number of frames
		
		int offset_skins;   // offset to skin data
		int offset_st;      // offset to texture coords
		int offset_tris;    // offset to triangle data
		int offset_frames;  // offset to frame data
		int offset_glcmds;  // offset to OpenGL commands
		int offset_end;     // offset to the end of the file
	} Md2Header;

	// Skin data
	typedef struct 
	{
		char name[64];  // Texture's filename
	} Md2Skin;

	// Texture coords.
	typedef struct Md2TexCoord_t
	{
		short s;
		short t;
	} Md2TexCoord;

	// Triangle data
	typedef struct 
	{
		unsigned short vertex[3];  // Triangle's vertex indices
		unsigned short st[3];      // Texture coords. indices
	} Md2Triangle;

	// Vertex data
	typedef struct 
	{
		unsigned char v[3];         // Compressed vertex position
		unsigned char normalIndex;  // Normal vector index
	} Md2Vertex;

	// Frame data
	typedef struct 
	{
		float scale[3];        // Scale factors
		float translate[3];    // Translation vector
		char  name[16];       // Frame name
		Md2Vertex verts[1];  // Frames's vertex list
	} Md2Frame;

	// OpenGL command packet
	typedef struct 
	{
		float s;    // S texture coord.
		float t;    // T texture coord.
		int index;  // Vertex index
	} Md2Glcmd;
};

#endif