/*
 *  MAX3DSModel.h
 *  Electric3D
 *
 *  Created by Robert McDowell on 04/10/2010.
 *  Copyright 2010 Electric TopHat Ltd. All rights reserved.
 *
 */

#ifndef __MAX3DSTYPES_H__
#define __MAX3DSTYPES_H__

namespace MAX3DS 
{
	
	typedef enum 
	{	
		// ********************************************************************
		// Basic chunks which can be found everywhere in the file
		CHUNK_VERSION				= 0x0002,
		CHUNK_RGBF					= 0x0010,		// float4 R; float4 G; float4 B
		CHUNK_RGBB					= 0x0011,		// int1 R; int1 G; int B
		
		// Linear color values (gamma = 2.2?)
		CHUNK_LINRGBF				= 0x0013,	// float4 R; float4 G; float4 B
		CHUNK_LINRGBB				= 0x0012,	// int1 R; int1 G; int B
		
		CHUNK_PERCENTW				= 0x0030,		// int2   percentage
		CHUNK_PERCENTF				= 0x0031,		// float4  percentage
		// ********************************************************************
		
		// Prj master chunk
		CHUNK_PRJ					= 0xC23D,
		
		// MDLI master chunk
		CHUNK_MLI					= 0x3DAA,
		
		// Primary main chunk of the .3ds file
		CHUNK_MAIN					= 0x4D4D,
		
		// Mesh main chunk
		CHUNK_OBJMESH				= 0x3D3D,
		
		// Specifies the background color of the .3ds file
		// This is passed through the material system for
		// viewing purposes.
		CHUNK_BKGCOLOR				= 0x1200,
		
		// Specifies the ambient base color of the scene.
		// This is added to all materials in the file
		CHUNK_AMBCOLOR				= 0x2100,
		
		// Specifies the background image for the whole scene
		// This value is passed through the material system
		// to the viewer 
		CHUNK_BIT_MAP				= 0x1100,
		CHUNK_BIT_MAP_EXISTS		= 0x1101,
		
		// ********************************************************************
		// Viewport related stuff. Ignored
		CHUNK_DEFAULT_VIEW			= 0x3000,
		CHUNK_VIEW_TOP				= 0x3010,
		CHUNK_VIEW_BOTTOM			= 0x3020,
		CHUNK_VIEW_LEFT				= 0x3030,
		CHUNK_VIEW_RIGHT			= 0x3040,
		CHUNK_VIEW_FRONT			= 0x3050,
		CHUNK_VIEW_BACK				= 0x3060,
		CHUNK_VIEW_USER				= 0x3070,
		CHUNK_VIEW_CAMERA			= 0x3080,
		// ********************************************************************
		
		// Mesh chunks
		CHUNK_OBJBLOCK				= 0x4000,
		CHUNK_TRIMESH				= 0x4100,
		CHUNK_VERTLIST				= 0x4110,
		CHUNK_VERTFLAGS				= 0x4111,
		CHUNK_FACELIST				= 0x4120,
		CHUNK_FACEMAT				= 0x4130,
		CHUNK_MAPLIST				= 0x4140,
		CHUNK_SMOOLIST				= 0x4150,
		CHUNK_TRMATRIX				= 0x4160,
		CHUNK_MESHCOLOR				= 0x4165,
		CHUNK_TXTINFO				= 0x4170,
		CHUNK_LIGHT					= 0x4600,
		CHUNK_CAMERA				= 0x4700,
		CHUNK_HIERARCHY				= 0x4F00,
		
		// Specifies the global scaling factor. This is applied
		// to the root node's transformation matrix
		CHUNK_MASTER_SCALE			= 0x0100,
		
		// ********************************************************************
		// Material chunks
		CHUNK_MAT_MATERIAL			= 0xAFFF,
		
		// asciiz containing the name of the material
		CHUNK_MAT_MATNAME			= 0xA000, 
		CHUNK_MAT_AMBIENT			= 0xA010, // followed by color chunk
		CHUNK_MAT_DIFFUSE			= 0xA020, // followed by color chunk
		CHUNK_MAT_SPECULAR			= 0xA030, // followed by color chunk
		
		// Specifies the shininess of the material
		// followed by percentage chunk
		CHUNK_MAT_SHININESS			= 0xA040, 
		CHUNK_MAT_SHININESS_PERCENT = 0xA041 ,
		
		// Specifies the shading mode to be used
		// followed by a short
		CHUNK_MAT_SHADING			= 0xA100, 
		
		// NOTE: Emissive color (self illumination) seems not
		// to be a color but a single value, type is unknown.
		// Make the parser accept both of them.
		// followed by percentage chunk (?)
		CHUNK_MAT_SELF_ILLUM		= 0xA080,  
		
		// Always followed by percentage chunk	(?)
		CHUNK_MAT_SELF_ILPCT		= 0xA084,  
		
		// Always followed by percentage chunk
		CHUNK_MAT_TRANSPARENCY		= 0xA050, 
		
		// Diffuse texture channel 0 
		CHUNK_MAT_TEXTURE			= 0xA200,
		
		// Contains opacity information for each texel
		CHUNK_MAT_OPACMAP			= 0xA210,
		
		// Contains a reflection map to be used to reflect
		// the environment. This is partially supported.
		CHUNK_MAT_REFLMAP			= 0xA220,
		
		// Self Illumination map (emissive colors)
		CHUNK_MAT_SELFIMAP			= 0xA33d,	
		
		// Bumpmap. Not specified whether it is a heightmap
		// or a normal map. Assme it is a heightmap since
		// artist normally prefer this format.
		CHUNK_MAT_BUMPMAP			= 0xA230,
		
		// Specular map. Seems to influence the specular color
		CHUNK_MAT_SPECMAP			= 0xA204,
		
		// Holds shininess data. 
		CHUNK_MAT_MAT_SHINMAP		= 0xA33C,
		
		// Scaling in U/V direction.
		// (need to gen separate UV coordinate set 
		// and do this by hand)
		CHUNK_MAT_MAP_USCALE		= 0xA354,
		CHUNK_MAT_MAP_VSCALE		= 0xA356,
		
		// Translation in U/V direction.
		// (need to gen separate UV coordinate set 
		// and do this by hand)
		CHUNK_MAT_MAP_UOFFSET		= 0xA358,
		CHUNK_MAT_MAP_VOFFSET		= 0xA35a,
		
		// UV-coordinates rotation around the z-axis
		// Assumed to be in radians.
		CHUNK_MAT_MAP_ANG			= 0xA35C,
		
		// Tiling flags for 3DS files
		CHUNK_MAT_MAP_TILING		= 0xa351,
		
		// Specifies the file name of a texture
		CHUNK_MAPFILE				= 0xA300,
		
		// Specifies whether a materail requires two-sided rendering
		CHUNK_MAT_TWO_SIDE			= 0xA081,  
		// ********************************************************************
		
		// Main keyframer chunk. Contains translation/rotation/scaling data
		CHUNK_KEYFRAMER		= 0xB000,
		
		// Supported sub chunks
		CHUNK_TRACKINFO		= 0xB002,
		CHUNK_TRACKOBJNAME  = 0xB010,
		CHUNK_TRACKDUMMYOBJNAME  = 0xB011,
		CHUNK_TRACKPIVOT    = 0xB013,
		CHUNK_TRACKPOS      = 0xB020,
		CHUNK_TRACKROTATE   = 0xB021,
		CHUNK_TRACKSCALE    = 0xB022,
		
		// ********************************************************************
		// Keyframes for various other stuff in the file
		// Partially ignored
		CHUNK_AMBIENTKEY    = 0xB001,
		CHUNK_TRACKMORPH    = 0xB026,
		CHUNK_TRACKHIDE     = 0xB029,
		CHUNK_OBJNUMBER     = 0xB030,
		CHUNK_TRACKCAMERA	= 0xB003,
		CHUNK_TRACKFOV		= 0xB023,
		CHUNK_TRACKROLL		= 0xB024,
		CHUNK_TRACKCAMTGT	= 0xB004,
		CHUNK_TRACKLIGHT	= 0xB005,
		CHUNK_TRACKLIGTGT	= 0xB006,
		CHUNK_TRACKSPOTL	= 0xB007,
		CHUNK_FRAMES		= 0xB008,
		// ********************************************************************
		
		// light sub-chunks
		CHUNK_DL_OFF                 = 0x4620,
		CHUNK_DL_OUTER_RANGE         = 0x465A,
		CHUNK_DL_INNER_RANGE         = 0x4659,
		CHUNK_DL_MULTIPLIER          = 0x465B,
		CHUNK_DL_EXCLUDE             = 0x4654,
		CHUNK_DL_ATTENUATE           = 0x4625,
		CHUNK_DL_SPOTLIGHT           = 0x4610,
		
		// camera sub-chunks
		CHUNK_CAM_RANGES             = 0x4720
		
	} eMAX3DS;
	
	
	// The below structure will be padded to 8
	const int MAX3DS_ChunkHeaderSize = 6;
	typedef struct
	{
		unsigned short	identifier;
		unsigned int	length;

	} MAX3DS_ChunkHeader;
	
	
	typedef struct
	{
		float x;
		float y;
		float z;
		
	} MAX3DS_VERTEX;
	
	typedef struct
	{
		float u;
		float v;
		
	} MAX3DS_UV;
		
	//The three ints for the polygon
	//represent the no.s(or rank) of it's 3 vertices
	typedef struct
	{
		unsigned short a;
		unsigned short b;
		unsigned short c;
		unsigned short flag; // visibility flag
		/*
		union {
			struct  {
				unsigned char AB : 1;
				unsigned char BC : 1;
				unsigned char AC : 1;
				unsigned char Mapping : 1;
				unsigned char padA : 4;
				unsigned char padB : 2;
				unsigned char padC : 2;
				unsigned char faceSelected3 : 1;
				unsigned char faceSelected2 : 1;
				unsigned char faceSelected1 : 1;
			};
			unsigned short flag; // visibility flag
		}flag;
		*/
	} MAX3DS_FACE;
	
	typedef struct
	{
		float matrix[4][3];
		
	} MAX3DS_MATRIX;
	
	typedef struct
	{
		char name[20];
		int numVerts;
		int numFaces;
		int	numUVs;
		
	} MAX3DS_OBJECT_HEADER;
	
	typedef struct
	{
		MAX3DS_OBJECT_HEADER	header;
		
		MAX3DS_VERTEX *			verts;
		MAX3DS_FACE *			faces;
		MAX3DS_UV *				uvs;
		
		MAX3DS_MATRIX *			matrix;
	} MAX3DS_OBJECT;
};

#endif
