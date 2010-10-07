//
//  GLMeshFactory.m
//  Electric3D
//
//  Created by Robert McDowell on 23/09/2010.
//  Copyright 2010 Electric TopHat Ltd. All rights reserved.
//

#import "GLMeshFactory.h"
#import "GLMesh.h"
#import "GLMeshStatic.h"
#import "GLMeshVertexAnimation.h"

#import "GLVertexs.h"

#pragma mark ---------------------------------------------------------

#pragma mark MAX3DSModel

#import "MAX3DSModel.h"
#import "MAX3DSModelConvertor.h"

#pragma mark End MAX3DSModel


#pragma mark MD2Model

#import "MD2Model.h"
#import "MD2ModelConvertor.h"

#pragma mark End MD2Model

#pragma mark PVRPODModel

#import "PVRPODModel.h"
#import "PVRPODModelConvertor.h"

#pragma mark End PVRPODModel

#pragma mark ---------------------------------------------------------

namespace GLMeshes
{
#pragma mark ---------------------------------------------------------
#pragma mark Internal Consts 
#pragma mark ---------------------------------------------------------
	
	typedef enum 
	{
		eMeshFileExt_MS = 0,
		eMeshFileExt_MVA,
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
	GLMeshFactory::GLMeshFactory()
	{
		m_extHash = [[NSDictionary alloc] initWithObjectsAndKeys:
					 [NSNumber numberWithInt:eMeshFileExt_MS], @"ms",
					 [NSNumber numberWithInt:eMeshFileExt_MVA], @"mva",
					 [NSNumber numberWithInt:eMeshFileExt_MD2], @"md2",
					 [NSNumber numberWithInt:eMeshFileExt_3DS], @"3ds",
					 [NSNumber numberWithInt:eMeshFileExt_POD], @"pod",
					 nil];
	}

	// --------------------------------------------------
	// Destructor
	// --------------------------------------------------
	GLMeshFactory::~GLMeshFactory()
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
	BOOL GLMeshFactory::isLoaded( const NSString * _name, const NSString * _ext, NSBundle * _bundle )
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
	BOOL GLMeshFactory::isLoaded( const NSString * _filePath )
	{
		std::map<NSUInteger,GLMesh*>::iterator lb = m_meshes.lower_bound(_filePath.hash);
		if (lb != m_meshes.end() && !(m_meshes.key_comp()(_filePath.hash, lb->first)))
		{
			return true;
		}
		return false;
	}
	
	// --------------------------------------------------
	// load a mesh
	// --------------------------------------------------
	const GLMesh * GLMeshFactory::load( const NSString * _name, const NSString * _ext, NSBundle * _bundle )
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
	const GLMesh * GLMeshFactory::load( const NSString * _filePath )
	{
		GLMesh * mesh = nil;
		
		std::map<NSUInteger,GLMesh*>::iterator lb = m_meshes.lower_bound(_filePath.hash);
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
				case eMeshFileExt_MS:
				{
					mesh = loadMS( _filePath );
					break;
				}
				case eMeshFileExt_MVA:
				{
					mesh = loadMVA( _filePath );
					break;
				}
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
				default:
					DPrint( @"ERROR : Failed to load mesh file %@ as the file format is not supported.", _filePath );
					break;
			}
			
			if ( mesh )
			{
				m_meshes[mesh->hash()] = mesh;
			}
		}
		
		return mesh;
	}

	// --------------------------------------------------
	// release a mesh
	// --------------------------------------------------
	void GLMeshFactory::release( const GLMesh * _mesh )
	{
		if ( _mesh )
		{
			NSUInteger key = _mesh->hash();
			std::map<NSUInteger,GLMesh*>::iterator lb = m_meshes.lower_bound(key);
			if (lb != m_meshes.end() && !(m_meshes.key_comp()(key, lb->first)))
			{
				GLMesh * mesh = lb->second;
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
	void GLMeshFactory::clear()
	{
		std::map<NSUInteger,GLMesh*>::iterator objt;
		for (objt = m_meshes.begin(); objt != m_meshes.end(); ++objt) 
		{
			GLMesh * mesh = objt->second;
			delete( mesh );
		}
		// remove all the dead pointers
		m_meshes.clear();
	}
	
#pragma mark ---------------------------------------------------------
#pragma mark === End Public Functions  ===
#pragma mark ---------------------------------------------------------

#pragma mark ---------------------------------------------------------
#pragma mark === Private Functions  ===
#pragma mark ---------------------------------------------------------
	
	// --------------------------------------------------
	// load an MS Mesh ( Custom Static Mesh )
	// --------------------------------------------------
	GLMesh * GLMeshFactory::loadMS( const NSString * _filePath )
	{
		GLMeshStatic * staticMesh = new GLMeshStatic( _filePath );
	
		if ( !staticMesh->valid() )
		{
			delete( staticMesh );
			staticMesh = nil;
		}
		return staticMesh;
	}
	
	// --------------------------------------------------
	// load an MVA Mesh ( Custom Mesh Vertex Animations )
	// --------------------------------------------------
	GLMesh * GLMeshFactory::loadMVA( const NSString * _filePath )
	{
		GLMeshVertexAnimation * animatedMesh = new GLMeshVertexAnimation( _filePath );
		
		if ( !animatedMesh->valid() )
		{
			delete( animatedMesh );
			animatedMesh = nil;
		}
		return animatedMesh;
	}
	
	// --------------------------------------------------
	// load an MD2 Mesh
	// --------------------------------------------------
	GLMesh * GLMeshFactory::loadMD2( const NSString * _filePath )
	{
		NSFileHandle * file = [NSFileHandle fileHandleForReadingAtPath:_filePath];
		if ( file )
		{
			NSData * data = [file readDataToEndOfFile];
			
			NSLog( @"loadMD2 file of size %d", [data length] );
			
			MD2::MD2Model model( data );
			
			if ( model.valid() )
			{	
				if ( ( model.numframes() == 1 ) || 
					 ( model.numframes() == 2 ) || // Start and end frame
					 ( model.numframes() == 20 ) ) // 20 is the default num frames in the QTip Exporter
				{
					GLMeshStaticInfo info;
					info.numverts	= model.numverts();
					info.numindices	= 0;
					info.aabb		= CGMaths::CGAABBUnit;
					
					GLMeshStatic * staticMesh = new GLMeshStatic( info, _filePath );
					
					if ( !MD2::convertFrameToVerts( &model, 0, staticMesh->verts() ) )
					{
						delete( staticMesh );
						staticMesh = nil;
					}
					else 
					{
						CGMaths::CGAABB aabb = calculateAABB(staticMesh->verts(), staticMesh->numverts());
						staticMesh->setAABB( aabb );
					}
					
					return staticMesh;
				}
				else 
				{
					GLMeshVertexAnimationInfo info;
					info.numframes	= model.numframes();
					info.numverts	= model.numverts();
					info.numindices	= 0;
					info.aabb		= CGMaths::CGAABBUnit;
					
					GLMeshVertexAnimation * animatedMesh = new GLMeshVertexAnimation( info, _filePath );
					
					if ( MD2::convertFrameToVerts( &model, 0, animatedMesh->interpverts() ) )
					{
						CGMaths::CGAABB aabb = calculateAABB(animatedMesh->interpverts(), animatedMesh->numverts());
						animatedMesh->setAABB( aabb );
						
						int i;
						for ( i=0; i<model.numframes(); i++ )
						{
							if ( !MD2::convertFrameToVerts( &model, i, animatedMesh->frameverts(i) ) )
							{
								delete( animatedMesh );
								animatedMesh = nil;
								break;
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
	GLMesh * GLMeshFactory::load3DS( const NSString * _filePath )
	{
		NSFileHandle * file = [NSFileHandle fileHandleForReadingAtPath:_filePath];
		if ( file )
		{
			NSData * data = [file readDataToEndOfFile];
			
			NSLog( @"load3DS file of size %d", [data length] );
			
			MAX3DS::MAX3DSModel model( data );
			
			if ( model.valid() && model.count() )
			{
				const MAX3DS::MAX3DS_OBJECT * mesh = model.objectAtIndex(0);
				
				GLMeshStaticInfo info;
				info.numverts	= mesh->header.numVerts;
				info.numindices	= ( mesh->header.numVerts != mesh->header.numFaces*3 ) ? mesh->header.numFaces*3  : 0;
				info.aabb		= CGMaths::CGAABBUnit;
				
				GLMeshStatic * staticMesh = new GLMeshStatic( info, _filePath );
				
				if ( !MAX3DS::convertToVerts( mesh, staticMesh->verts() ) )
				{
					delete( staticMesh );
					staticMesh = nil;
				}
				else 
				{
					// is it an indexed triangle mesh
					if ( staticMesh->indices() )
					{
						if ( !MAX3DS::convertToIndices( mesh, staticMesh->indices() ) )
						{
							delete( staticMesh );
							staticMesh = nil;
						}
					}
					
					CGMaths::CGAABB aabb = calculateAABB(staticMesh->verts(), staticMesh->numverts());
					staticMesh->setAABB( aabb );
				}
				
				return staticMesh;
			}
		}
		
		return nil;
	}
	
	// --------------------------------------------------
	// load an POD Mesh
	// --------------------------------------------------
	GLMesh * GLMeshFactory::loadPOD( const NSString * _filePath )
	{
		NSFileHandle * file = [NSFileHandle fileHandleForReadingAtPath:_filePath];
		if ( file )
		{
			NSData * data = [file readDataToEndOfFile];
			
			NSLog( @"loadPOD file of size %d", [data length] );
			
			PVRPOD::PVRPODModel model( data );
			
			if ( model.valid() )
			{
				const PVRPOD::PODScene * scene = model.scene();
				if ( scene->numMeshes )
				{
					const PVRPOD::PODMesh * mesh = &scene->meshes[0];
					
					GLMeshStaticInfo info;
					info.numverts	= mesh->numVertices;
					info.numindices	= ( mesh->numVertices != mesh->numFaces*3 ) ? mesh->numFaces*3  : 0;
					info.aabb		= CGMaths::CGAABBUnit;
					
					GLMeshStatic * staticMesh = new GLMeshStatic( info, _filePath );
					
					if ( !PVRPOD::convertToVerts( mesh, staticMesh->verts() ) )
					{
						delete( staticMesh );
						staticMesh = nil;
					}
					else 
					{
						// is it an indexed triangle mesh
						if ( staticMesh->indices() )
						{
							if ( !PVRPOD::convertToIndices( mesh, staticMesh->indices() ) )
							{
								delete( staticMesh );
								staticMesh = nil;
							}
						}
						
						CGMaths::CGAABB aabb = calculateAABB(staticMesh->verts(), staticMesh->numverts());
						staticMesh->setAABB( aabb );
					}
					
					return staticMesh;
				}
			}
		}
		
		return nil;
	}
	
#pragma mark ---------------------------------------------------------
#pragma mark === End Private Functions  ===
#pragma mark ---------------------------------------------------------
};