//
//  E3DMeshManager.m
//  Electric3D
//
//  Created by Robert McDowell on 23/09/2010.
//  Copyright 2010 Electric TopHat Ltd. All rights reserved.
//

#import "E3DMeshManager.h"

#import "GLVertexs.h"

#pragma mark ---------------------------------------------------------

#define USE_COMPRESSED_MESH_FILES 1

#if USE_COMPRESSED_MESH_FILES
#import "Compression.h"
#endif

#pragma mark ---------------------------------------------------------

#pragma mark CustomTypes

#import "E3DMeshTypes.h"
#import "E3DMesh.h"
#import "E3DMeshStatic.h"
#import "E3DMeshMorph.h"

#pragma mark End CustomTypes

#pragma mark MAX3DSScene

#import "MAX3DSScene.h"
#import "MAX3DSModelConvertor.h"

#pragma mark End MAX3DSScene


#pragma mark MD2Model

#import "MD2Model.h"
#import "MD2ModelConvertor.h"

#pragma mark End MD2Model

#pragma mark PVRPODScene

#import "PVRPODScene.h"
#import "PVRPODModelConvertor.h"

#pragma mark End PVRPODScene

#pragma mark ---------------------------------------------------------

namespace E3D
{
#pragma mark ---------------------------------------------------------
#pragma mark Internal Consts 
#pragma mark ---------------------------------------------------------
	
	typedef enum 
	{
		eMeshFileExt_Unknown = 0,
		eMeshFileExt_MD2,
		eMeshFileExt_3DS,
		eMeshFileExt_POD,
		
	} eMeshFileExt;
	
#pragma mark ---------------------------------------------------------
#pragma mark End Internal Consts 
#pragma mark ---------------------------------------------------------
	
#pragma mark ---------------------------------------------------------
#pragma mark Constructor / Destructor
#pragma mark ---------------------------------------------------------

	// --------------------------------------------------
	// Constructor
	// --------------------------------------------------
	E3DMeshManager::E3DMeshManager()
	{
		m_extHash = [[NSDictionary alloc] initWithObjectsAndKeys:
					 [NSNumber numberWithInt:eMeshFileExt_MD2], @"md2",
					 [NSNumber numberWithInt:eMeshFileExt_3DS], @"3ds",
					 [NSNumber numberWithInt:eMeshFileExt_POD], @"pod",
					 nil];
	}

	// --------------------------------------------------
	// Destructor
	// --------------------------------------------------
	E3DMeshManager::~E3DMeshManager()
	{
		clear();
	}

#pragma mark ---------------------------------------------------------
#pragma mark End Constructor / Destructor
#pragma mark ---------------------------------------------------------

#pragma mark ---------------------------------------------------------
#pragma mark === Public Functions  ===
#pragma mark ---------------------------------------------------------

	// --------------------------------------------------
	// is the mesh loaded
	// --------------------------------------------------
	BOOL E3DMeshManager::isLoaded( const NSString * _name, const NSString * _ext, NSBundle * _bundle )
	{
		NSBundle * bundle	= ( _bundle ) ? _bundle : [NSBundle mainBundle];
		NSString * path		= [bundle pathForResource:_name ofType:_ext];
		if ( path )
		{
			return isLoaded( path );
		}
		return nil;
	}
	
	// --------------------------------------------------
	// is the mesh loaded
	// --------------------------------------------------
	BOOL E3DMeshManager::isLoaded( const NSString * _filePath )
	{
		MESH_MAP::iterator lb = m_meshes.lower_bound(_filePath.hash);
		if (lb != m_meshes.end() && !(m_meshes.key_comp()(_filePath.hash, lb->first)))
		{
			return true;
		}
		return false;
	}
	
	// --------------------------------------------------
	// load a mesh
	// --------------------------------------------------
	const E3DMesh * E3DMeshManager::load( const NSString * _name, const NSString * _ext, NSBundle * _bundle )
	{
		NSBundle * bundle	= ( _bundle ) ? _bundle : [NSBundle mainBundle];
		NSString * path		= [bundle pathForResource:_name ofType:_ext];
		if ( path )
		{
			return load( path );
		}
		return nil;
	}
	
	// --------------------------------------------------
	// load a mesh
	// --------------------------------------------------
	const E3DMesh * E3DMeshManager::load( const NSString * _filePath )
	{
		E3DMesh * mesh = nil;
		
		MESH_MAP::iterator lb = m_meshes.lower_bound(_filePath.hash);
		if (lb != m_meshes.end() && !(m_meshes.key_comp()(_filePath.hash, lb->first)))
		{
			mesh = lb->second;
			mesh->incrementReferenceCount();
		}
		else // Load the texture and convert it.
		{
			NSString * ext = [[_filePath pathExtension] lowercaseString];
			switch ([[m_extHash objectForKey:ext] intValue]) 
			{
				case eMeshFileExt_MD2:
				{
					mesh = loadMD2( _filePath );
					break;
				}
				case eMeshFileExt_3DS:
				{
					mesh = load3DS( _filePath );
					break;
				}
				case eMeshFileExt_POD:
				{
					mesh = loadPOD( _filePath );
					break;
				}
				case eMeshFileExt_Unknown:
				default:
				{
					mesh = loadMesh( _filePath );
					break;
				}
			}
			
			if ( mesh )
			{
				m_meshes[mesh->hash()] = mesh;
			}
			else 
			{
				DPrint( @"ERROR : Failed to load mesh file %@ as the file format is not supported.", _filePath );
			}

		}
		
		return mesh;
	}

	// --------------------------------------------------
	// release a mesh
	// --------------------------------------------------
	void E3DMeshManager::release( const E3DMesh * _mesh )
	{
		if ( _mesh )
		{
			NSUInteger key = _mesh->hash();
			MESH_MAP::iterator lb = m_meshes.lower_bound(key);
			if (lb != m_meshes.end() && !(m_meshes.key_comp()(key, lb->first)))
			{
				E3DMesh * mesh = lb->second;
				mesh->decrementReferenceCount();
				
				if ( mesh->referenceCount() <= 0 )
				{	
					// remove the object reference
					// from the map
					m_meshes.erase( lb );			
					
					// delete the object
					delete( mesh );
				}
			}
		}
	}

	// --------------------------------------------------
	// clear all the meshes
	// --------------------------------------------------
	void E3DMeshManager::clear()
	{
		MESH_MAP::iterator objt;
		for (objt = m_meshes.begin(); objt != m_meshes.end(); ++objt) 
		{
			E3DMesh * mesh = objt->second;
			delete( mesh );
		}
		// remove all the dead pointers
		m_meshes.clear();
	}
	
	// --------------------------------------------------
	// save a mesh to disk
	// --------------------------------------------------
	BOOL E3DMeshManager::save( const E3DMesh * _mesh, const NSString * _filePath )
	{
		if ( _mesh && _mesh->isValid() )
		{
			// friend class has access to the binary data buffer
			const NSData * data = _mesh->data(); 
			if ( data )
			{
#if USE_COMPRESSED_MESH_FILES
				// Compress the file with gzip
				NSData * compressed = Compressor::gzip::deflate( data );
				DPrint( @"Save file uncompressed %d / compressed %d", data length], [compressed length] );
				return [compressed writeToFile:_filePath atomically:YES];
#else
				return [data writeToFile:_filePath atomically:YES];
#endif
			}
		}
		
		return FALSE;
	}
	
#pragma mark ---------------------------------------------------------
#pragma mark === End Public Functions  ===
#pragma mark ---------------------------------------------------------

#pragma mark ---------------------------------------------------------
#pragma mark === Private Functions  ===
#pragma mark ---------------------------------------------------------
	
	// --------------------------------------------------
	// load a Mesh File 
	// The type will be discovered from the file header
	// --------------------------------------------------
	E3DMesh * E3DMeshManager::loadMesh( const NSString * _filePath )
	{
		NSFileHandle * file = [NSFileHandle fileHandleForReadingAtPath:_filePath];
		if ( file )
		{
#if USE_COMPRESSED_MESH_FILES
			// read the compressed file
			NSData * compressed = [file readDataToEndOfFile];
			// Decompress the file
			NSData * data = Compressor::gzip::inflate( compressed );
#else
			NSData * data = [file readDataToEndOfFile];
#endif
			if ( [data length] > sizeof( E3DMeshFileHeader ) )
			{
				E3DMesh * mesh = nil;
				unsigned char * p = (unsigned char*)[data bytes];
				E3DMeshFileHeader * header = (E3DMeshFileHeader*)p;
				
				if (header->ident == _MSFileIdent) 
				{
					mesh = new E3DMeshStatic( data );
				}
				else if (header->ident == _MMFileIdent) 
				{
					mesh = new E3DMeshMorph( data );
				}
				
				if ( mesh && !mesh->isValid() )
				{
					delete( mesh );
					mesh = nil;
				}
				return mesh;
			}
		}
		return nil;
	}
	
	// --------------------------------------------------
	// load an MD2 Mesh
	// --------------------------------------------------
	E3DMesh * E3DMeshManager::loadMD2( const NSString * _filePath )
	{
		NSFileHandle * file = [NSFileHandle fileHandleForReadingAtPath:_filePath];
		if ( file )
		{
			NSData * data = [file readDataToEndOfFile];
			
			//NSLog( @"loadMD2 file of size %d", [data length] );
			
			MD2::MD2Model model( data );
			
			if ( model.valid() )
			{	
				if ( ( model.numframes() == 1 ) || 
					 ( model.numframes() == 2 ) || // Start and end frame
					 ( model.numframes() == 20 ) ) // 20 is the default num frames in the QTip Exporter
				{
					E3DMeshStaticInfo info;
					info.aabb		= CGMaths::CGAABBUnit;
#if MD2_USE_INDEXED_TRIANLGES
					info.numverts	= model.numverts();
					info.numindices	= ( model.numtrangles() != model.numtrangles()*3 ) ? model.numtrangles()*3  : 0;
#else
					info.numverts	= model.numtrangles()*3;
					info.numindices	= 0;
#endif
					
					E3DMeshStatic * staticMesh = new E3DMeshStatic( info, _filePath );
					
					if ( !MD2::convertFrameToVerts( &model, 0, staticMesh->verts() ) )
					{
						delete( staticMesh );
						staticMesh = nil;
					}
					else 
					{
						// is it an indexed triangle mesh
						if ( info.numindices && !MD2::convertToIndices( &model, 0, staticMesh->indices() ) )
						{
							delete( staticMesh );
							staticMesh = nil;
						}
						else 
						{
							CGMaths::CGAABB aabb = calculateAABB(staticMesh->verts(), staticMesh->numverts());
							staticMesh->setaabb( aabb );
						}
					}
					
					return staticMesh;
				}
				else 
				{
					E3DMeshMorphInfo info;
					info.numframes	= model.numframes();
					info.aabb		= CGMaths::CGAABBUnit;
#if MD2_USE_INDEXED_TRIANLGES
					info.numverts	= model.numverts();
					info.numindices	= ( model.numtrangles() != model.numtrangles()*3 ) ? model.numtrangles()*3  : 0;
#else
					info.numverts	= model.numtrangles()*3;
					info.numindices	= 0;
#endif
					
					E3DMeshMorph * animatedMesh = new E3DMeshMorph( info, _filePath );
					
					if ( MD2::convertFrameToVerts( &model, 0, animatedMesh->interpverts() ) )
					{
						// is it an indexed triangle mesh
						if ( info.numindices && !MD2::convertToIndices( &model, 0, animatedMesh->indices() ) )
						{
							delete( animatedMesh );
							animatedMesh = nil;
						}
						else 
						{
							CGMaths::CGAABB aabb = calculateAABB(animatedMesh->interpverts(), animatedMesh->numverts());
							animatedMesh->setaabb( aabb );
							
							int i;
							for ( i=0; i<model.numframes(); i++ )
							{
								if ( !MD2::convertFrameToVerts( &model, i, animatedMesh->frameverts(i) ) )
								{
									delete( animatedMesh );
									animatedMesh = nil;
									break;
								}
								else 
								{
									CGMaths::CGAABB aabb = calculateAABB(animatedMesh->frameverts(i), animatedMesh->numverts());
									animatedMesh->setaabb( i, aabb );
								}

							}
						}
					}
					else 
					{
						delete( animatedMesh );
						animatedMesh = nil;
					}
					
					return animatedMesh;
				}
			}
		}
		return nil;
	}
	
	// --------------------------------------------------
	// load an 3DS Mesh
	// --------------------------------------------------
	E3DMesh * E3DMeshManager::load3DS( const NSString * _filePath )
	{
		NSFileHandle * file = [NSFileHandle fileHandleForReadingAtPath:_filePath];
		if ( file )
		{
			NSData * data = [file readDataToEndOfFile];
			
			//NSLog( @"load3DS file of size %d", [data length] );
			
			MAX3DS::MAX3DSScene model( data );
			
			if ( model.valid() && model.count() )
			{
				E3DMeshStaticInfo info;
				info.numverts	= 0;
				info.numindices	= 0;
				info.aabb		= CGMaths::CGAABBUnit;
				
				int i;
				// work out the total number size 
				// of the meshes
				for ( i=0; i<model.count(); i++ )
				{
					const MAX3DS::MAX3DS_OBJECT * mesh = model.objectAtIndex(i);
					
					info.numverts	+= mesh->header.numVerts;
					info.numindices	+= ( mesh->header.numVerts != mesh->header.numFaces*3 ) ? mesh->header.numFaces*3  : 0;
				}
				
				// create the static model with the total space required
				E3DMeshStatic * staticMesh = new E3DMeshStatic( info, _filePath );
				
				CGMaths::CGAABB			aabb	= CGMaths::CGAABBZero;
				GLInterleavedVert3D *	verts	= staticMesh->verts();
				GLVertIndice *			indices	= staticMesh->indices();
				
				// loop over each mesh and convert it
				int vertoffset		= 0;
				int indicesoffset	= 0;
				BOOL ok				= TRUE;
				for ( i=0; i<model.count(); i++ )
				{
					const MAX3DS::MAX3DS_OBJECT * mesh = model.objectAtIndex(i);
					
					if ( MAX3DS::convertToVerts( mesh, &verts[vertoffset] ) )
					{
						// is it an indexed triangle mesh
						if ( indices && !MAX3DS::convertToIndices( mesh, &indices[indicesoffset], vertoffset ) )
						{
							ok = FALSE;
							break;
						}
					}
					else 
					{
						ok = FALSE;
						break;
					}
					
					vertoffset		+= mesh->header.numVerts;
					indicesoffset	+= mesh->header.numFaces*3;
				}
				
				if ( ok )
				{
					CGMaths::CGAABB aabb = calculateAABB(staticMesh->verts(), staticMesh->numverts());
					staticMesh->setaabb( aabb );
				}
				else 
				{
					delete( staticMesh );
					staticMesh = nil;
				}

				return staticMesh;
			}
		}
		
		return nil;
	}
	
	// --------------------------------------------------
	// load an POD Mesh
	// --------------------------------------------------
	E3DMesh * E3DMeshManager::loadPOD( const NSString * _filePath )
	{
		NSFileHandle * file = [NSFileHandle fileHandleForReadingAtPath:_filePath];
		if ( file )
		{
			NSData * data = [file readDataToEndOfFile];
			
			//NSLog( @"loadPOD file of size %d", [data length] );
			
			PVRPOD::PVRPODScene model( data );
			
			if ( model.valid() )
			{
				const PVRPOD::PODScene * scene = model.scene();
				if ( scene->numMeshes )
				{
					E3DMeshStaticInfo info;
					info.numverts	= 0;
					info.numindices	= 0;
					info.aabb		= CGMaths::CGAABBUnit;
					
					if ( scene->numMeshes > 1 )
					{
						int i;
						// work out the total number size 
						// of the meshes
						for ( i=0; i<scene->numMeshes; i++ )
						{
							const PVRPOD::PODMesh * mesh = &scene->meshes[i];
							
							info.numverts	+= mesh->numVertices;
							info.numindices	+= ( mesh->numVertices != mesh->numFaces*3 ) ? mesh->numFaces*3  : 0;
						}
						
						// create the static model with the total space required
						E3DMeshStatic * staticMesh = new E3DMeshStatic( info, _filePath );
						
						CGMaths::CGAABB			aabb	= CGMaths::CGAABBZero;
						GLInterleavedVert3D *	verts	= staticMesh->verts();
						GLVertIndice *			indices	= staticMesh->indices();
						
						// loop over each mesh and convert it
						int vertoffset		= 0;
						int indicesoffset	= 0;
						BOOL ok				= TRUE;
						for ( i=0; i<scene->numMeshNodes; i++ )
						{
							const PVRPOD::PODNode * node = &scene->nodes[i];
							const PVRPOD::PODMesh * mesh = &scene->meshes[node->idx];
							
							CGMaths::CGMatrix4x4 matrix = PVRPOD::getNodeTransform( node, 0, scene->nodes );
							
							if ( PVRPOD::convertToVerts( mesh, &verts[vertoffset], matrix ) )
							{
								// is it an indexed triangle mesh
								if ( indices && !PVRPOD::convertToIndices( mesh, &indices[indicesoffset], vertoffset ) )
								{
									ok = FALSE;
									break;
								}
							}
							else 
							{
								ok = FALSE;
								break;
							}
							
							vertoffset		+= mesh->numVertices;
							indicesoffset	+= mesh->numFaces*3;
						}
						
						if ( ok )
						{
							CGMaths::CGAABB aabb = calculateAABB(staticMesh->verts(), staticMesh->numverts());
							staticMesh->setaabb( aabb );
						}
						else 
						{
							delete( staticMesh );
							staticMesh = nil;
						}
						
						return staticMesh;
					}
					else 
					{
						const PVRPOD::PODMesh * mesh = &scene->meshes[0];
						
						info.numverts	= mesh->numVertices;
						info.numindices	= ( mesh->numVertices != mesh->numFaces*3 ) ? mesh->numFaces*3  : 0;
						
						// create the static model with the total space required
						E3DMeshStatic * staticMesh = new E3DMeshStatic( info, _filePath );
						
						CGMaths::CGAABB			aabb	= CGMaths::CGAABBZero;
						GLInterleavedVert3D *	verts	= staticMesh->verts();
						GLVertIndice *			indices	= staticMesh->indices();
						
						CGMaths::CGMatrix4x4 matrix = CGMaths::CGMatrix4x4Identity;
						
						BOOL ok	= TRUE;
						if ( PVRPOD::convertToVerts( mesh, verts, matrix ) )
						{
							// is it an indexed triangle mesh
							if ( indices && !PVRPOD::convertToIndices( mesh, indices ) )
							{
								ok = FALSE;
							}
						}
						else 
						{
							ok = FALSE;
						}
						
						if ( ok )
						{
							CGMaths::CGAABB aabb = calculateAABB(staticMesh->verts(), staticMesh->numverts());
							staticMesh->setaabb( aabb );
						}
						else 
						{
							delete( staticMesh );
							staticMesh = nil;
						}
						
						return staticMesh;
					}

				}
			}
		}
		
		return nil;
	}
	
#pragma mark ---------------------------------------------------------
#pragma mark === End Private Functions  ===
#pragma mark ---------------------------------------------------------
};