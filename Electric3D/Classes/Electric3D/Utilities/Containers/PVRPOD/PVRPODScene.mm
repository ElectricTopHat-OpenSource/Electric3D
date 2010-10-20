//
//  PVRPODScene.mm
//  Electric3D
//
//  Created by Robert McDowell on 04/10/2010.
//  Copyright 2010 Electric TopHat Ltd. All rights reserved.
//

#import "PVRPODScene.h"

namespace PVRPOD 
{	
	// ---------------------------------------------------------------
	// Constructor
	// ---------------------------------------------------------------
	PVRPODScene::PVRPODScene(NSData * _data)
	: m_data		( nil )
	, m_offset		( 0 )
	{
		memset(&m_scene, 0, sizeof(PODScene));
		
		set( _data );
	}
	
	// ---------------------------------------------------------------
	// Constructor
	// ---------------------------------------------------------------
	PVRPODScene::PVRPODScene(const void * _data, int _len)
	: m_data		( nil )
	, m_offset		( 0 )
	{
		memset(&m_scene, 0, sizeof(PODScene));
		
		set( _data, _len );
	}
	
	// ---------------------------------------------------------------
	// Destructor
	// ---------------------------------------------------------------
	PVRPODScene::~PVRPODScene()
	{
		invalidate();
	}
	
	// ---------------------------------------------------------------
	// is it using indexed triangles
	// ---------------------------------------------------------------
	BOOL PVRPODScene::isUsingIndexedTriangles() const 
	{ 
		if ( m_scene.numMeshes ) 
		{ 
			return !( m_scene.meshes[0].numVertices == (m_scene.meshes[0].numFaces * 3) );
		} return FALSE; 
	}
	
	// ---------------------------------------------------------------
	// invalidate the model
	// ---------------------------------------------------------------
	void PVRPODScene::invalidate()
	{
		memset(&m_scene, 0, sizeof(PODScene));
		[m_data release]; m_data = nil;
		m_offset = 0;
	}
	
	// ---------------------------------------------------------------
	// change the model data
	// ---------------------------------------------------------------
	BOOL PVRPODScene::set( NSData * _data )
	{
		invalidate();
		
		unsigned int size = [_data length];
		if ( size )
		{
			m_data = [[NSData alloc] initWithBytesNoCopy:memset(malloc(size), 0, size) length:size];
			
			if ( m_data && _data  )
			{
				if ( !fill( [_data bytes], [_data length] ) )
				{
					invalidate();
				}
			}
		}
		
		return m_data != nil;
	}
	
	// ---------------------------------------------------------------
	// change the model data
	// ---------------------------------------------------------------
	BOOL PVRPODScene::set( const void * _data, int _len )
	{
		invalidate();
		
		if ( _len )
		{
			m_data = [[NSData alloc] initWithBytesNoCopy:memset(malloc(_len), 0, _len) length:_len];
			
			if ( m_data && _data  )
			{
				if ( !fill( _data, _len ) )
				{
					invalidate();
				}
			}
		}
		
		return m_data != nil;
	}
	
	// ---------------------------------------------------------------
	// get a chunk from the memory buffer
	// ---------------------------------------------------------------
	void * PVRPODScene::mpool( unsigned int _size )
	{
		if ( ( _size > 0 ) && ( m_offset + _size < [m_data length] ) )
		{
			unsigned int offset = m_offset;
			unsigned char * bytes = (unsigned char *)[m_data bytes];
			m_offset += _size;
			
			void * buffer = &bytes[offset];
			//NSLog(@"%d, %d", m_offset, buffer );
			return buffer;
		}
		return nil;
	}
	
	// ---------------------------------------------------------------
	// get a chunk from the memory buffer and copy the content
	// ---------------------------------------------------------------
	void *  PVRPODScene::mpoolcpy( unsigned int _size, const void * _data )
	{
		void * buffer = mpool( _size );
		if ( buffer )
		{
			memcpy(buffer, _data, _size);
			return buffer;
		}
		return nil;
	}
	
	// ---------------------------------------------------------------
	// fill the data structures with the data pointer
	// ---------------------------------------------------------------
	BOOL PVRPODScene::fill( const void * _data, int _len )
	{
		int hsize = sizeof(PODChunkInfo);
		if ( _len >= hsize )
		{
			PODChunkInfo * chunk = (PODChunkInfo*)_data;
			
			if ( chunk->length == PVRTMODELPOD_VERSION_LEN+1)
			{
				unsigned char * p	= (unsigned char*)_data;
				int pos				= 0;
				int length			= _len;
				bool valid			= TRUE;
				bool done			= FALSE;
				
				while ( ( pos < length ) && valid && !done )
				{
					chunk = (PODChunkInfo*)&p[pos];
					
					switch(chunk->identifier)
					{
						case ePODFileVersion:
						{
							unsigned char * subChunk = &p[pos+hsize];
							
							char version[PVRTMODELPOD_VERSION_LEN];
							memcpy(&version, subChunk, sizeof(version));

							valid = (strcmp(&version[0], PVRTMODELPOD_VERSION) != 0);
							
							//NSLog( @"Found POD Version Chunk : %s", version );
							break;
						}
						case ePODFileExpOpt:
						{
							//NSLog( @"Found Exp Opt Chunk" );
							//const char * expopt = (const char *)&p[pos+hsize];
							//NSLog( @"%s", expopt );
							break;
						}
						case ePODFileScene:
						{
							//NSLog( @"Found SCENE Chunk" );
							valid = read_SCENE( &p[pos+hsize], ( length - pos+hsize ) );
							break;
						}
							
						case ePODFileScene | PVRTMODELPOD_TAG_END:
						{
							done = true;
							break;
						}	
						case (unsigned int) ePODFileEndiannessMisMatch:
						{
							NSLog( @"Found Endianness Mis Match Chunk" );
							valid = false;
							break;
						}
						default:
						{
							//NSLog( @"Unknown chunkID : %d", chunk->identifier );
							break;
						}
					}
				
					pos += chunk->length + hsize;
				}
				
				
				return valid;
			}
		}
		
		return FALSE;
	}
	
	BOOL PVRPODScene::read_SCENE( const unsigned char * _data, int _len )
	{
		PODChunkInfo * chunk;
		int hsize				= sizeof(PODChunkInfo);
		int pos					= 0;
		int length				= _len;
		
		unsigned int cameras	= 0;
		unsigned int lights		= 0; 
		unsigned int materials	= 0;
		unsigned int meshes		= 0; 
		unsigned int textures	= 0;
		unsigned int nodes		= 0;
		
		while ( pos < length )
		{
			chunk = (PODChunkInfo*)&_data[pos];
			
			switch (chunk->identifier) 
			{
				case ePODFileScene | PVRTMODELPOD_TAG_END:
				{
					if(cameras		!= m_scene.numCameras)		return false;
					if(lights		!= m_scene.numLights)		return false;
					if(materials	!= m_scene.numMaterials)	return false;
					if(meshes		!= m_scene.numMeshes)		return false;
					if(textures		!= m_scene.numTextures)		return false;
					if(nodes		!= m_scene.numNodes)		return false;
					return true;
				}
					
				case ePODFileColourBackground:
				{
					//NSLog( @"Found Color Background Chunk" );
					memcpy(&m_scene.colourBackground, &_data[pos+hsize], sizeof(PODVec3f));
					break;
				}
				case ePODFileColourAmbient:
				{
					//NSLog( @"Found Color Ambient Chunk" );
					memcpy(&m_scene.colourAmbient, &_data[pos+hsize], sizeof(PODVec3f));
					break;
				}
				case ePODFileNumCamera:
				{
					//NSLog( @"Found Num Camera Chunk" );
					memcpy(&m_scene.numCameras, &_data[pos+hsize], sizeof(unsigned int));
					if ( m_scene.numCameras )
					{
						unsigned int size = sizeof(PODCamera) * m_scene.numCameras;
						m_scene.cameras = (PODCamera*)mpool(size);
					}
					break;
				}
				case ePODFileNumLight:
				{
					//NSLog( @"Found Num Light Chunk" );
					memcpy(&m_scene.numLights, &_data[pos+hsize], sizeof(unsigned int));
					if ( m_scene.numLights )
					{
						unsigned int size = sizeof(PODLight) * m_scene.numLights;
						m_scene.lights = (PODLight*)mpool(size);
					}
					break;
				}
				case ePODFileNumMesh:
				{
					//NSLog( @"Found Num Mesh Chunk" );
					memcpy(&m_scene.numMeshes, &_data[pos+hsize], sizeof(unsigned int));
					if ( m_scene.numMeshes )
					{
						unsigned int size = sizeof(PODMesh) * m_scene.numMeshes;
						m_scene.meshes = (PODMesh*)mpool(size);
					}
					break;
				}
				case ePODFileNumNode:
				{
					//NSLog( @"Found Num Node Chunk" );
					memcpy(&m_scene.numNodes, &_data[pos+hsize], sizeof(unsigned int));
					if ( m_scene.numNodes )
					{
						unsigned int size = sizeof(PODNode) * m_scene.numNodes;
						m_scene.nodes = (PODNode*)mpool(size);
					}
					break;
				}
				case ePODFileNumTexture:
				{
					//NSLog( @"Found Num Texture Chunk" );
					memcpy(&m_scene.numTextures, &_data[pos+hsize], sizeof(unsigned int));
					if ( m_scene.numTextures )
					{
						unsigned int size = sizeof(PODTexture) * m_scene.numTextures;
						m_scene.textures = (PODTexture*)mpool(size);
					}
					break;
				}
				case ePODFileNumMaterial:
				{
					//NSLog( @"Found Num Material Chunk" );
					memcpy(&m_scene.numMaterials, &_data[pos+hsize], sizeof(unsigned int));
					if ( m_scene.numMaterials )
					{
						unsigned int size = sizeof(PODMaterial) * m_scene.numMaterials;
						m_scene.materials = (PODMaterial*)mpool(size);
					}
					break;
				}
					
				case ePODFileNumMeshNode:
				{
					//NSLog( @"Found Num Mesh Node Chunk" );
					memcpy(&m_scene.numMeshNodes, &_data[pos+hsize], sizeof(unsigned int));
					break;
				}
				case ePODFileNumFrame:
				{
					//NSLog( @"Found Num Frame Chunk" );
					memcpy(&m_scene.numFrames, &_data[pos+hsize], sizeof(unsigned int));
					break;
				}
				case ePODFileFlags:
				{
					//NSLog( @"Found Flags Chunk" );
					memcpy(&m_scene.flags, &_data[pos+hsize], sizeof(unsigned int));
					break;
				}
					
				case ePODFileCamera:
				{
					//NSLog( @"Found Camera Chunk %d", chunk->length );
					pos += read_CAMERA( &_data[pos+hsize], ( length - pos+hsize ), &m_scene.cameras[cameras] );
					cameras++;
					break;
				}
				case ePODFileLight:
				{
					NSLog( @"Found Light Chunk %d", chunk->length );
					pos += read_LIGHT( &_data[pos+hsize], ( length - pos+hsize ), &m_scene.lights[lights] );
					lights++;
					break;
				}
				case ePODFileMaterial:
				{
					//NSLog( @"Found Material Chunk %d", chunk->length );
					pos += read_MATERIAL( &_data[pos+hsize], ( length - pos+hsize ), &m_scene.materials[materials] );
					materials++;
					break;
				}
				case ePODFileMesh:
				{
					//NSLog( @"Found Mesh Chunk %d", chunk->length );
					pos += read_MESH( &_data[pos+hsize], ( length - pos+hsize ), &m_scene.meshes[meshes] );
					meshes++;
					break;
				}
				case ePODFileNode:
				{
					//NSLog( @"Found Node Chunk %d", chunk->length );
					pos += read_NODE( &_data[pos+hsize], ( length - pos+hsize ), &m_scene.nodes[nodes] );
					nodes++;
					break;
				}
				case ePODFileTexture:	
				{
					//NSLog( @"Found Texture Chunk %d", chunk->length );
					pos += read_TEXTURE( &_data[pos+hsize], ( length - pos+hsize ), &m_scene.textures[textures] );
					textures++;
					break;
				}
				default:
				{
					//NSLog( @"Unknown chunkID : %d len %d", chunk->identifier, chunk->length );
					break;
				}
			}
			
			pos += chunk->length + hsize;
		}
		return false;
	}
	
	int PVRPODScene::read_CAMERA( const unsigned char * _data, int _len, PODCamera * _cam )
	{
		PODChunkInfo *		chunk;
		int hsize			= sizeof(PODChunkInfo);
		int pos				= 0;
		int length			= _len;
		
		while ( pos < length )
		{
			chunk = (PODChunkInfo*)&_data[pos];
			
			switch(chunk->identifier)
			{
				case ePODFileCamera | PVRTMODELPOD_TAG_END:
				{
					return pos + hsize;
				}	
				case ePODFileCamIdxTgt:
				{
					memcpy(&_cam->idxTarget, &_data[pos+hsize], sizeof(int));			
					break;
				}
				case ePODFileCamFOV:
				{
					memcpy(&_cam->fov, &_data[pos+hsize], sizeof(float));
					break;
				}
				case ePODFileCamFar:
				{
					memcpy(&_cam->far, &_data[pos+hsize], sizeof(float));
					break;
				}
				case ePODFileCamNear:
				{
					memcpy(&_cam->near, &_data[pos+hsize], sizeof(float));
					break;
				}
				case ePODFileCamAnimFOV:
				{
					_cam->animFrames = chunk->length;
					if ( _cam->animFrames )
					{
						unsigned int size = sizeof(float) * chunk->length;
						_cam->animFovs = (float*)mpoolcpy( size, &_data[pos+hsize] );
					}
					break;
				}	
				default:
				{
					//NSLog( @"Unknown chunkID : %d len %d", chunk->identifier, chunk->length );
					break;
				}
			}
			
			pos += chunk->length + hsize;
		}
		return pos;
	}
	
	int PVRPODScene::read_LIGHT( const unsigned char * _data, int _len, PODLight * _light )
	{
		PODChunkInfo *		chunk;
		int hsize			= sizeof(PODChunkInfo);
		int pos				= 0;
		int length			= _len;
		
		while ( pos < length )
		{
			chunk = (PODChunkInfo*)&_data[pos];
			
			switch(chunk->identifier)
			{
				case ePODFileLight | PVRTMODELPOD_TAG_END:			
					return pos + hsize;
						
				case ePODFileLightIdxTgt:
				{
					memcpy(&_light->idxTarget, &_data[pos+hsize], sizeof(int));
					break;
				}
				case ePODFileLightColour:
				{
					memcpy(&_light->colour[0], &_data[pos+hsize], sizeof(float) * 3);
					break;
				}
				case ePODFileLightType:
				{
					memcpy(&_light->type, &_data[pos+hsize], sizeof(ePODLightType));
					break;
				}

				default:
				{
					//NSLog( @"Unknown chunkID : %d len %d", chunk->identifier, chunk->length );
					break;
				}
			}
			
			pos += chunk->length + hsize;
		}
		return pos;
	}
	
	int PVRPODScene::read_MATERIAL( const unsigned char * _data, int _len, PODMaterial * _material )
	{
		PODChunkInfo *		chunk;
		int hsize			= sizeof(PODChunkInfo);
		int pos				= 0;
		int length			= _len;
		
		while ( pos < length )
		{
			chunk = (PODChunkInfo*)&_data[pos];
			switch(chunk->identifier)
			{
				case ePODFileMaterial | PVRTMODELPOD_TAG_END:			
					return pos + hsize;
					
				case ePODFileMatName:
				{
					unsigned int size = sizeof(char) * MIN( PODMaxName, chunk->length ); 
					memcpy(&_material->name[0], &_data[pos+hsize], size);
					break;
				}
				case ePODFileMatIdxTexDiffuse:
				{
					memcpy(&_material->idxTexDiffuse, &_data[pos+hsize], sizeof(int) );
					break;
				}
				case ePODFileMatOpacity:
				{
					memcpy(&_material->matOpacity, &_data[pos+hsize], sizeof(float) );	
					break;
				}
				case ePODFileMatAmbient:
				{
					memcpy(&_material->matAmbient, &_data[pos+hsize], sizeof(float) );
					break;
				}
				case ePODFileMatDiffuse:
				{
					memcpy(&_material->matDiffuse, &_data[pos+hsize], sizeof(float) );
					break;
				}
				case ePODFileMatSpecular:
				{
					memcpy(&_material->matSpecular, &_data[pos+hsize], sizeof(float) );
					break;
				}
				case ePODFileMatShininess:
				{
					memcpy(&_material->matShininess, &_data[pos+hsize], sizeof(float) );
					break;
				}
				case ePODFileMatEffectFile:
				{
					unsigned int size = sizeof(char) * MIN( PODMaxName, chunk->length ); 
					memcpy(&_material->effectFile[0], &_data[pos+hsize], size);
					break;
				}
				case ePODFileMatEffectName:
				{
					unsigned int size = sizeof(char) * MIN( PODMaxName, chunk->length ); 
					memcpy(&_material->effectName[0], &_data[pos+hsize], size);
					break;
				}
					
				default:
				{
					//NSLog( @"Unknown chunkID : %d len %d", chunk->identifier, chunk->length );
					break;
				}
			}
			pos += chunk->length + hsize;
		}
		return pos;
	}
	
	int PVRPODScene::read_MESH( const unsigned char * _data, int _len, PODMesh * _mesh )
	{
		PODChunkInfo *		chunk;
		int hsize			= sizeof(PODChunkInfo);
		int pos				= 0;
		int length			= _len;
		unsigned int nUVWs	= 0;
		
		while ( pos < length )
		{
			chunk = (PODChunkInfo*)&_data[pos];
			
			switch(chunk->identifier)
			{
				case ePODFileMesh | PVRTMODELPOD_TAG_END:
				{
					//if(nUVWs != s.nNumUVW) return false;
					return pos + hsize;
				}
					
				case ePODFileMeshNumVtx:
				{
					memcpy(&_mesh->numVertices, &_data[pos+hsize], sizeof(unsigned int));
					break;
				}
				case ePODFileMeshNumFaces:
				{
					memcpy(&_mesh->numFaces, &_data[pos+hsize], sizeof(unsigned int));
					break;
				}
				case ePODFileMeshNumUVW:
				{
					memcpy(&_mesh->numUVW, &_data[pos+hsize], sizeof(unsigned int));	
					if ( _mesh->numUVW )
					{
						unsigned int size = sizeof(PODData) * _mesh->numUVW;
						_mesh->UVWs = (PODData*)mpool(size);
					}
					break;
				}
				case ePODFileMeshNumStrips:
				{
					memcpy(&_mesh->numStrips, &_data[pos+hsize], sizeof(unsigned int));	
					break;
				}
				
				case ePODFileMeshStripLength:
				{
					if ( chunk->length )
					{
						unsigned int size = sizeof(unsigned int) * chunk->length;
						_mesh->stripLengths = (unsigned int*)mpoolcpy( size, &_data[pos+hsize] );
					}
					break;
				}
				case ePODFileMeshInterleaved:
				{
					if ( chunk->length )
					{
						unsigned int size = sizeof(unsigned char) * chunk->length;
						_mesh->interleaved = (unsigned char*)mpoolcpy( size, &_data[pos+hsize] );
					}
					break;
				}
					
				
				// ---------------------------------------------------------------------------------
				// Bone Batches
				// ---------------------------------------------------------------------------------
				case ePODFileMeshBoneBatches:
				{
					if ( chunk->length )
					{
						unsigned int size = sizeof(int) * chunk->length;
						_mesh->boneBatches.batches = (int*)mpoolcpy( size, &_data[pos+hsize] );
					}
					break;
				}
				case ePODFileMeshBoneBatchBoneCnts:
				{
					if ( chunk->length )
					{
						unsigned int size = sizeof(int) * chunk->length;
						_mesh->boneBatches.batchBoneCnt = (int*)mpoolcpy( size, &_data[pos+hsize] );
					}
					break;
				}
				case ePODFileMeshBoneBatchOffsets:
				{
					if ( chunk->length )
					{
						unsigned int size = sizeof(int) * chunk->length;
						_mesh->boneBatches.batchOffsets = (int*)mpoolcpy( size, &_data[pos+hsize] );
					}
					break;
				}
				case ePODFileMeshBoneBatchBoneMax:
				{
					memcpy(&_mesh->boneBatches.batchBoneMax, &_data[pos+hsize], sizeof(int));	
					break;
				}
				case ePODFileMeshBoneBatchCnt:
				{
					memcpy(&_mesh->boneBatches.batchCnt, &_data[pos+hsize], sizeof(int));
					break;
				}
				// ----------------------------------------------------------------------------------
					
				case ePODFileMeshFaces:
				{
					pos += read_PODData( &_data[pos+hsize], ( length - pos+hsize ), ePODFileMeshFaces, true, &_mesh->faces );
					break;
				}
				case ePODFileMeshVtx:
				{
					pos += read_PODData( &_data[pos+hsize], ( length - pos+hsize ), ePODFileMeshVtx, _mesh->interleaved == nil, &_mesh->vertices );
					break;
				}
				case ePODFileMeshNor:
				{
					pos += read_PODData( &_data[pos+hsize], ( length - pos+hsize ), ePODFileMeshNor, _mesh->interleaved == nil, &_mesh->normals );
					break;
				}
				case ePODFileMeshTan:
				{
					pos += read_PODData( &_data[pos+hsize], ( length - pos+hsize ), ePODFileMeshTan, _mesh->interleaved == nil, &_mesh->tangents );
					break;
				}
				case ePODFileMeshBin:
				{
					pos += read_PODData( &_data[pos+hsize], ( length - pos+hsize ), ePODFileMeshBin, _mesh->interleaved == nil, &_mesh->binormals );
					break;
				}
				case ePODFileMeshUVW:
				{
					pos += read_PODData( &_data[pos+hsize], ( length - pos+hsize ), ePODFileMeshUVW, _mesh->interleaved == nil, &_mesh->UVWs[nUVWs] );
					nUVWs++;
					break;
				}
				case ePODFileMeshVtxCol:
				{
					pos += read_PODData( &_data[pos+hsize], ( length - pos+hsize ), ePODFileMeshVtxCol, _mesh->interleaved == nil, &_mesh->vtxColours );
					break;
				}
				case ePODFileMeshBoneIdx:
				{
					pos += read_PODData( &_data[pos+hsize], ( length - pos+hsize ), ePODFileMeshBoneIdx, _mesh->interleaved == nil, &_mesh->boneIdx );
					break;
				}
				case ePODFileMeshBoneWeight:
				{
					pos += read_PODData( &_data[pos+hsize], ( length - pos+hsize ), ePODFileMeshBoneWeight, _mesh->interleaved == nil, &_mesh->boneWeight );
					break;
				}
				default:
				{
					//NSLog( @"Unknown chunkID : %d len %d", chunk->identifier, chunk->length );
					break;
				}
			}
			
			pos += chunk->length + hsize;
		}
		return pos;
	}
	
	int PVRPODScene::read_NODE( const unsigned char * _data, int _len, PODNode * _node )
	{
		PODChunkInfo *		chunk;
		int hsize			= sizeof(PODChunkInfo);
		int pos				= 0;
		int length			= _len;
		
		bool  oldFormat		= false;
		float oldpos[3]		= {0,0,0};
		float oldquat[4]	= {0,0,0,1};
		float oldscale[7]	= {1,1,1,0,0,0,0};
		
		while ( pos < length )
		{
			chunk = (PODChunkInfo*)&_data[pos];
			
			switch(chunk->identifier)
			{
				case ePODFileNode | PVRTMODELPOD_TAG_END:
				{
					if(oldFormat)
					{
						if(_node->animPositions)
						{
							_node->animFlags |= ePODHasPositionAni;
						}
						else
						{
							_node->animPositions = (float*) mpoolcpy(sizeof(oldpos), &oldpos[0]);
						}
						
						if(_node->animRotations)
						{
							_node->animFlags |= ePODHasRotationAni;
						}
						else
						{
							_node->animRotations = (float*) mpoolcpy(sizeof(oldquat), &oldquat[0]);
						}
						
						if(_node->animScales)
						{
							_node->animFlags |= ePODHasScaleAni;
						}
						else
						{
							_node->animScales = (float*) mpoolcpy(sizeof(oldscale), &oldscale[0]);
						}
					}
					return pos + hsize;
				}
					
				case ePODFileNodeIdx:
				{
					memcpy(&_node->idx, &_data[pos+hsize], sizeof(int));
					break;
				}
				case ePODFileNodeName:
				{
					unsigned int size = sizeof(char) * MIN( PODMaxName, chunk->length ); 
					memcpy(&_node->name[0], &_data[pos+hsize], size);	
					break;
				}
				case ePODFileNodeIdxMat:
				{
					memcpy(&_node->idxMaterial, &_data[pos+hsize], sizeof(int));
					break;
				}
				case ePODFileNodeIdxParent:
				{
					memcpy(&_node->idxParent, &_data[pos+hsize], sizeof(int));
					break;
				}
				case ePODFileNodeAnimFlags:
				{
					memcpy(&_node->animFlags, &_data[pos+hsize], sizeof(unsigned int));
					break;
				}
				case ePODFileNodeAnimPos:
				{
					unsigned int size = sizeof(float) * chunk->length;
					_node->animPositions = (float*)mpoolcpy(size, &_data[pos+hsize]);
					break;
				}
				case ePODFileNodeAnimRot:
				{
					unsigned int size = sizeof(float) * chunk->length;
					_node->animRotations = (float*)mpoolcpy(size, &_data[pos+hsize]);
					break;
				}
				case ePODFileNodeAnimScale:
				{
					unsigned int size = sizeof(float) * chunk->length;
					_node->animScales = (float*)mpoolcpy(size, &_data[pos+hsize]);
					break;
				}
				case ePODFileNodeAnimMatrix:
				{
					unsigned int size = sizeof(float) * chunk->length;
					_node->animMatrixs = (float*)mpoolcpy(size, &_data[pos+hsize]);
					break;
				}
					
				// Parameters from the older pod format
				case ePODFileNodePos:
				{
					memcpy(&oldpos[0],  &_data[pos+hsize], sizeof(oldpos));
					oldFormat = true;		
					break;
				}
				case ePODFileNodeRot:
				{
					memcpy(&oldquat[0],  &_data[pos+hsize], sizeof(oldquat));
					oldFormat = true;
					break;
				}
				case ePODFileNodeScale:
				{
					memcpy(&oldscale[0],  &_data[pos+hsize], sizeof(oldscale));	
					oldFormat = true;		
					break;
				}
					
				default:
				{
					//NSLog( @"Unknown chunkID : %d len %d", chunk->identifier, chunk->length );
					break;
				}
			}
			
			pos += chunk->length + hsize;
		}
		return pos;
	}
	
	int PVRPODScene::read_TEXTURE( const unsigned char * _data, int _len, PODTexture * _texture )
	{
		PODChunkInfo *		chunk;
		int hsize			= sizeof(PODChunkInfo);
		int pos				= 0;
		int length			= _len;
		
		while ( pos < length )
		{
			chunk = (PODChunkInfo*)&_data[pos];
			
			switch(chunk->identifier)
			{
				case ePODFileTexture | PVRTMODELPOD_TAG_END:
				{
					return pos + hsize;
				}	
					
				case ePODFileTexName:
				{
					unsigned int size = sizeof(char) * MIN( PODMaxName, chunk->length ); 
					memcpy(&_texture->name[0], &_data[pos+hsize], size);		
					break;
				}
				default:
				{
					//NSLog( @"Unknown chunkID : %d len %d", chunk->identifier, chunk->length );
					break;
				}
			}
			
			pos += chunk->length + hsize;
		}
		return pos;
	}
	
	int PVRPODScene::read_PODData( const unsigned char * _data, int _len, ePODFileName _spec, bool _validData, PODData * _poddat )
	{
		PODChunkInfo *		chunk;
		int hsize			= sizeof(PODChunkInfo);
		int pos				= 0;
		int length			= _len;
		
		while ( pos < length )
		{
			chunk = (PODChunkInfo*)&_data[pos];
			
			if(chunk->identifier == (_spec | PVRTMODELPOD_TAG_END))
				return pos + hsize;
			
			switch(chunk->identifier)
			{
				case ePODFileDataType:
				{
					memcpy(&_poddat->type, &_data[pos+hsize], sizeof(ePVRTDataType));
					break;
				}
				case ePODFileN:
				{
					memcpy(&_poddat->numVertexes, &_data[pos+hsize], sizeof(unsigned int));
					break;
				}
				case ePODFileStride:
				{
					memcpy(&_poddat->stride, &_data[pos+hsize], sizeof(unsigned int));
					break;
				}
				case ePODFileData:
				{
					if(_validData) 
					{ 
						unsigned int size = sizeof(unsigned char) * chunk->length;
						_poddat->data = (unsigned char*)mpoolcpy( size, &_data[pos+hsize] );
					} 
					else 
					{ 
						memcpy(&_poddat->data, &_data[pos+hsize], sizeof(unsigned int));
					}	
					break;
				}
				default:
				{
					//NSLog( @"Unknown chunkID : %d len %d", chunk->identifier, chunk->length );
					break;
				}
			}
			
			pos += chunk->length + hsize;
		}
		
		return pos;
	}

};
