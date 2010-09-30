/*
 *  MD3Types.h
 *  Electric3D
 *
 *  Created by Robert McDowell on 28/09/2010.
 *  Copyright 2010 Electric TopHat Ltd. All rights reserved.
 *
 */

#ifndef __MD3TYPES_H__
#define __MD3TYPES_H__

#define MD3_MAX_QPATH 64
#define MD3_MAX_FRAMES 1024
#define MD3_MAX_TAGS 16
#define MD3_MAX_SURFACES 32

namespace MD3
{	
	// Md2 header
	typedef struct 
	{
		int  ident;					// id of file, always "IDP3" 
		int  version;				// this is a version number, always 15 
		char name[MD3_MAX_QPATH];   // sometimes left Blank...
		int	 flags;
		
		int  num_frames;			// Number of Frames
		int  num_tags;				// Number of Tag object
		int	 num_surfaces;			// Number of Surface objects
		int	 num_skins;				// Number of Skin objects
		
		int  offset_frames;			// Relative offset from start of MD3 object where Frame objects star.
		int  offset_tags;			// Relative offset from start
		int  offset_surfaces;		// Relative offset from start
		int  offset_end;			// offset to the end of the file
	} MD3Header;

	// Frames Data
	typedef struct
	{
		float min_bounds[3];		// First corner of the bounding box
		float max_bounds[3];		// Second corner of the bounding box
		float local_origin[3];		// Local origin, usually (0, 0, 0).
		float radius;				// Radius of bounding sphere.
		char  name[16];				// Name of Frame
	} MD3Frames;
	
	// Tag Data
	typedef struct
	{
		char  name[MD3_MAX_QPATH];
		float origin[3];
		float axis[3][3];
	} MD3Tag;
	
	// Surface Data
	typedef struct
	{
		int  ident;					// id of file, always "IDP3" 
		char name[MD3_MAX_QPATH];   // sometimes left Blank...
		int	 flags;
		
		int  num_frames;			// Number of animation frames. This should match NUM_FRAMES in the MD3 header.
		int  num_shaders;			// Number of Shader objects defined in this Surface
		int  num_verts;				// Number of Vertex objects defined in this Surface
		int  num_triangles;			// Number of Triangle objects defined in this Surface
		
		int  offset_triangles;		// Relative offset from start
		int  offset_shaders;		// Relative offset from start
		int  offset_st;				// Relative offset from start
		int  offset_xyznormal;		// Relative offset from start
		int  offset_end;			// offset to the end of the file
	} MD3Surface;
	
	// Shader path
	typedef
	{
		char  name[MD3_MAX_QPATH];  // Pathname of shader in the PK3
		int	  index;				// Shader index number
	} MD3Shader;
	
	// Triangle data
	typedef struct 
	{
		int INDEXES[3]; // List of offset values into the list of Vertex objects
	} MD3Triangle;
	
	// Texture Coordinates
	typedef struct
	{
		float st[2];  // S-T (U-V?) texture coordinate ( 0 <-> 1 )
	} MD3TexCoord;
	
	// Vertex Data
	typedef struct
	{
		short x;
		short y;
		short z;
		short normal;
	} MD3Vertex;
};