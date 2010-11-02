//
//  E3DMeshManager.h
//  Electric3D
//
//  Created by Robert McDowell on 23/09/2010.
//  Copyright 2010 Electric TopHat Ltd. All rights reserved.
//

#if !defined(__E3DMeshManager_h__)
#define __E3DMeshManager_h__

#import <map>

namespace E3D { class E3DMesh; };

namespace E3D
{
	typedef std::map<NSUInteger,E3DMesh*> MESH_MAP;
	
	class E3DMeshManager
	{
#pragma mark ---------------------------------------------------------
#pragma mark Constructor / Destructor
#pragma mark ---------------------------------------------------------
	public: // Functions
		
		E3DMeshManager();
		virtual ~E3DMeshManager();
		
#pragma mark ---------------------------------------------------------
#pragma mark End Constructor / Destructor
#pragma mark ---------------------------------------------------------
		
#pragma mark ---------------------------------------------------------
#pragma mark === Public Functions  ===
#pragma mark ---------------------------------------------------------
	public: // Functions
		
		BOOL isLoaded( const NSString * _name, const NSString * _ext, NSBundle * _bundle = nil );
		BOOL isLoaded( const NSString * _filePath );
		
		// load a mesh into the bank
		const E3DMesh * load( const NSString * _name, const NSString * _ext, NSBundle * _bundle = nil );
		const E3DMesh * load( const NSString * _filePath );
		
		// retain or get the mesh
		const E3DMesh * retain( const NSString * _name ); 
		
		// release the mesh
		void release( const E3DMesh * _mesh );
		
		// clear the entire mesh bank
		void clear();
		
		// save the mesh to disk
		BOOL save( const E3DMesh * _mesh, const NSString * _filePath );
		
#pragma mark ---------------------------------------------------------
#pragma mark === End Public Functions  ===
#pragma mark ---------------------------------------------------------
		
#pragma mark ---------------------------------------------------------
#pragma mark === Private Functions  ===
#pragma mark ---------------------------------------------------------
	private: // Functions
		E3DMesh * loadMesh( const NSString * _filePath );
		E3DMesh * loadMD2( const NSString * _filePath );
		E3DMesh * load3DS( const NSString * _filePath );
		E3DMesh * loadPOD( const NSString * _filePath );
		
#pragma mark ---------------------------------------------------------
#pragma mark === End Private Functions  ===
#pragma mark ---------------------------------------------------------
		
#pragma mark ---------------------------------------------------------
#pragma mark === Private Data  ===
#pragma mark ---------------------------------------------------------
	private: // Data
		
		NSDictionary *		m_extHash;
		
		MESH_MAP			m_meshes;
		
#pragma mark ---------------------------------------------------------
#pragma mark === Private Data  ===
#pragma mark ---------------------------------------------------------
	};

};

#endif