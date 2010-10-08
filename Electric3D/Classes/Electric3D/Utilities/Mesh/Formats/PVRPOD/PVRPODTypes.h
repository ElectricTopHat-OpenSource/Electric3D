/*
 *  PODTypes.h
 *  Electric3D
 *
 *  Created by Robert McDowell on 04/10/2010.
 *  Copyright 2010 Electric TopHat Ltd. All rights reserved.
 *
 */

#ifndef __PVRPODTYPES_H__
#define __PVRPODTYPES_H__

namespace PVRPOD 
{
	#define PVRTMODELPOD_VERSION			("AB.POD.2.0") /*!< POD file version string */
	#define PVRTMODELPOD_VERSION_LEN		(10)
	
	// PVRTMODELPOD Scene Flags
	#define PVRTMODELPODSF_FIXED			(0x00000001)   /*!< PVRTMODELPOD Fixed-point 16.16 data (otherwise float) flag */
	#define PVRTMODELPOD_TAG_MASK			(0x80000000)
	#define PVRTMODELPOD_TAG_START			(0x00000000)
	#define PVRTMODELPOD_TAG_END			(0x80000000)
	
	#define CFAH		(1024)
	#define	PODMaxName	32
	
	enum ePODFileName
	{
		ePODFileVersion				= 1000,
		ePODFileScene,
		ePODFileExpOpt,
		ePODFileEndiannessMisMatch  = -402456576,
		
		ePODFileColourBackground	= 2000,
		ePODFileColourAmbient,
		ePODFileNumCamera,
		ePODFileNumLight,
		ePODFileNumMesh,
		ePODFileNumNode,
		ePODFileNumMeshNode,
		ePODFileNumTexture,
		ePODFileNumMaterial,
		ePODFileNumFrame,
		ePODFileCamera,		// Will come multiple times
		ePODFileLight,		// Will come multiple times
		ePODFileMesh,		// Will come multiple times
		ePODFileNode,		// Will come multiple times
		ePODFileTexture,	// Will come multiple times
		ePODFileMaterial,	// Will come multiple times
		ePODFileFlags,
		
		ePODFileMatName				= 3000,
		ePODFileMatIdxTexDiffuse,
		ePODFileMatOpacity,
		ePODFileMatAmbient,
		ePODFileMatDiffuse,
		ePODFileMatSpecular,
		ePODFileMatShininess,
		ePODFileMatEffectFile,
		ePODFileMatEffectName,
		
		ePODFileTexName				= 4000,
		
		ePODFileNodeIdx				= 5000,
		ePODFileNodeName,
		ePODFileNodeIdxMat,
		ePODFileNodeIdxParent,
		ePODFileNodePos,
		ePODFileNodeRot,
		ePODFileNodeScale,
		ePODFileNodeAnimPos,
		ePODFileNodeAnimRot,
		ePODFileNodeAnimScale,
		ePODFileNodeMatrix,
		ePODFileNodeAnimMatrix,
		ePODFileNodeAnimFlags,
		
		ePODFileMeshNumVtx			= 6000,
		ePODFileMeshNumFaces,
		ePODFileMeshNumUVW,
		ePODFileMeshFaces,
		ePODFileMeshStripLength,
		ePODFileMeshNumStrips,
		ePODFileMeshVtx,
		ePODFileMeshNor,
		ePODFileMeshTan,
		ePODFileMeshBin,
		ePODFileMeshUVW,			// Will come multiple times
		ePODFileMeshVtxCol,
		ePODFileMeshBoneIdx,
		ePODFileMeshBoneWeight,
		ePODFileMeshInterleaved,
		ePODFileMeshBoneBatches,
		ePODFileMeshBoneBatchBoneCnts,
		ePODFileMeshBoneBatchOffsets,
		ePODFileMeshBoneBatchBoneMax,
		ePODFileMeshBoneBatchCnt,
		
		ePODFileLightIdxTgt			= 7000,
		ePODFileLightColour,
		ePODFileLightType,
		
		ePODFileCamIdxTgt			= 8000,
		ePODFileCamFOV,
		ePODFileCamFar,
		ePODFileCamNear,
		ePODFileCamAnimFOV,
		
		ePODFileDataType			= 9000,
		ePODFileN,
		ePODFileStride,
		ePODFileData
	};
	
	enum ePODLightType
	{
		ePODPoint=0,	/*!< Point light */
		ePODDirectional /*!< Directional light */
	};
	
	enum ePODPrimitiveType
	{
		ePODTriangles=0, /*!< Triangles */
		ePODLines		 /*!< Lines*/
	};
	
	enum ePODAnimationData
	{
		ePODHasPositionAni	= 0x01,	/*!< Position animation */
		ePODHasRotationAni	= 0x02, /*!< Rotation animation */
		ePODHasScaleAni		= 0x04, /*!< Scale animation */
		ePODHasMatrixAni	= 0x08  /*!< Matrix animation */
	};
	
	enum ePVRTDataType 
	{
		EPODDataNone,
		EPODDataFloat,
		EPODDataInt,
		EPODDataUnsignedShort,
		EPODDataRGBA,
		EPODDataARGB,
		EPODDataD3DCOLOR,
		EPODDataUBYTE4,
		EPODDataDEC3N,
		EPODDataFixed16_16,
		EPODDataUnsignedByte,
		EPODDataShort,
		EPODDataShortNorm,
		EPODDataByte,
		EPODDataByteNorm
	};
	
	typedef struct
	{
		float x;
		float y;
	} PODVec2f;
	
	typedef struct
	{
		float x;
		float y;
		float z;
	} PODVec3f;
	
	typedef struct
	{
		float x;
		float y;
		float z;
		float w;
	} PODVec4f;
	
	typedef union {
		int value;
		struct 
		{
			unsigned char x;
			unsigned char y;
			unsigned char z;
			unsigned char w;
		};
	} PODVec4c;
	
	typedef struct
	{
		PODVec3f vert;
		PODVec3f normal;
		PODVec4c col;
		PODVec2f uvA;
		PODVec2f uvB;
	} PODInterleavedA;
	
	typedef struct 
	{
		int			idxTarget;			/*!< Index of the target object */
		float		fov;				/*!< Field of view */
		float		far;				/*!< Far clip plane */
		float		near;				/*!< Near clip plane */
		int			animFrames;			/*!< Num frames of animation */
		float *		animFovs;			/*!< 1 VERTTYPE per frame of animation. */
		
	} PODCamera;
	
	typedef struct
	{
		int				idxTarget;		/*!< Index of the target object */
		float			colour[3];		/*!< Light colour (0.0f -> 1.0f for each channel) */
		ePODLightType	type;			/*!< Light type (point, directional etc.) */
		
	} PODLight;
	
	typedef struct
	{
		ePVRTDataType	type;			/*!< Type of data stored */
		unsigned int	numVertexes;	/*!< Number of values per vertex */
		unsigned int	stride;			/*!< Distance in bytes from one array entry to the next */
		unsigned char *	data;			/*!< Actual data (array of values); if mesh is interleaved, this is an OFFSET from pInterleaved */
		
	} PODData;

	typedef struct
	{
		int	*	batches;			/*!< Space for nBatchBoneMax bone indices, per batch */
		int	*	batchBoneCnt;		/*!< Actual number of bone indices, per batch */
		int	*	batchOffsets;		/*!< Offset into triangle array, per batch */
		int		batchBoneMax;		/*!< Stored value as was passed into Create() */
		int		batchCnt;
		
	} PODBoneBatches;
	
	typedef struct 
	{
		unsigned int		numVertices;	/*!< Number of vertices in the mesh */
		unsigned int		numFaces;		/*!< Number of triangles in the mesh */
		unsigned int		numUVW;			/*!< Number of texture coordinate channels per vertex */
		unsigned int		numStrips;		/*!< If mesh is stripped: number of strips, length of pnStripLength array. */
		
		PODData				faces;			/*!< List of triangle indices */
		PODData				vertices;		/*!< List of vertices (x0, y0, z0, x1, y1, z1, x2, etc...) */
		PODData				normals;		/*!< List of vertex normals (Nx0, Ny0, Nz0, Nx1, Ny1, Nz1, Nx2, etc...) */
		PODData				tangents;		/*!< List of vertex tangents (Tx0, Ty0, Tz0, Tx1, Ty1, Tz1, Tx2, etc...) */
		PODData				binormals;		/*!< List of vertex binormals (Bx0, By0, Bz0, Bx1, By1, Bz1, Bx2, etc...) */
		PODData				vtxColours;		/*!< A colour per vertex */
		PODData				boneIdx;		/*!< nNumBones*nNumVertex ints (Vtx0Idx0, Vtx0Idx1, ... Vtx1Idx0, Vtx1Idx1, ...) */
		PODData				boneWeight;		/*!< nNumBones*nNumVertex floats (Vtx0Wt0, Vtx0Wt1, ... Vtx1Wt0, Vtx1Wt1, ...) */
		
		PODBoneBatches		boneBatches;	/*!< Bone tables */
		
		PODData				*UVWs;			/*!< List of UVW coordinate sets; size of array given by 'nNumUVW' */
		
		unsigned int		*stripLengths;	/*!< If mesh is stripped: number of tris per strip. */
		unsigned char		*interleaved;	/*!< Interleaved vertex data */
		
		ePODPrimitiveType	primitiveType;	/*!< Primitive type used by this mesh */
	} PODMesh;
	
	typedef struct 
	{
		int			idx;				/*!< Index into mesh, light or camera array, depending on which object list contains this Node */
		char		name[PODMaxName];	/*!< Name of object */
		int			idxMaterial;		/*!< Index of material used on this mesh */
		
		int			idxParent;			/*!< Index into MeshInstance array; recursively apply ancestor's transforms after this instance's. */
		
		unsigned int animFlags;			/*!< Stores which animation arrays the POD Node contains */
		float *		 animPositions;		/*!< 3 floats per frame of animation. */
		float *		 animRotations;		/*!< 4 floats per frame of animation. */
		float *		 animScales;		/*!< 7 floats per frame of animation. */
		float *		 animMatrixs;		/*!< 16 floats per frame of animation. */
	} PODNode;
	
	typedef struct 
	{
		char	name[PODMaxName];		/*!< File-name of texture */
	} PODTexture;
	
	typedef struct  
	{
		char		name[PODMaxName];		/*!< Name of material */
		int			idxTexDiffuse;			/*!< Idx into textures for diffuse texture */
		float		matOpacity;				/*!< Material opacity (used with vertex alpha ?) */
		float		matAmbient[3];			/*!< Ambient RGB value */
		float		matDiffuse[3];			/*!< Diffuse RGB value */
		float		matSpecular[3];			/*!< Specular RGB value */
		float		matShininess;			/*!< Material shininess */
		char		effectFile[PODMaxName];	/*!< Name of effect file */
		char		effectName[PODMaxName];	/*!< Name of effect in the effect file */
	} PODMaterial;
	
	typedef struct  
	{
		PODVec3f		colourBackground;		/*!< Background colour */
		PODVec3f		colourAmbient;			/*!< Ambient colour */
		
		unsigned int	numCameras;				/*!< The length of the array pCamera */
		unsigned int	numLights;				/*!< The length of the array pLight */
		unsigned int	numMeshes;				/*!< The length of the array pMesh */
		unsigned int	numNodes;				/*!< Number of items in the array pNode */
		unsigned int	numTextures;			/*!< Number of textures in the array pTexture */
		unsigned int	numMaterials;			/*!< Number of materials in the array pMaterial */
		
		unsigned int	numMeshNodes;			/*!< Number of items in the array pNode which are objects */
		unsigned int	numFrames;				/*!< Number of frames of animation */
		unsigned int	flags;					/*!< PVRTMODELPODSF_* bit-flags */
		
		PODCamera *		cameras;				/*!< Camera nodes array */
		PODLight *		lights;					/*!< Light nodes array */
		PODMesh *		meshes;					/*!< Mesh array. Meshes may be instanced several times in a scene; i.e. multiple Nodes may reference any given mesh. */
		PODNode *		nodes;					/*!< Node array. Sorted as such: objects, lights, cameras, Everything Else (bones, helpers etc) */
		PODTexture *	textures;				/*!< Texture array */
		PODMaterial	*	materials;				/*!< Material array */

	} PODScene;
	
	typedef struct
	{
		unsigned int	identifier;
		unsigned int	length;
		
	} PODChunkInfo;
};

#endif