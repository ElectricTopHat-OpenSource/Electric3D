//
//  GLMeshFactory.h
//  Electric3D
//
//  Created by Robert McDowell on 23/09/2010.
//  Copyright 2010 Electric TopHat Ltd. All rights reserved.
//

#if !defined(__GLMeshFactory_h__)
#define __GLMeshFactory_h__

#import <map>

namespace GLMeshes { class GLMesh; };

namespace GLMeshes
{
	class GLMeshFactory 
	{
#pragma mark ---------------------------------------------------------
#pragma mark Constructor / Destructor
#pragma mark ---------------------------------------------------------
	public: // Functions
		
		GLMeshFactory();
		virtual ~GLMeshFactory();
		
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
		const GLMesh * load( const NSString * _name, const NSString * _ext, NSBundle * _bundle = nil );
		const GLMesh * load( const NSString * _filePath );
		
		// release the mesh
		void release( const GLMesh * _mesh );
		
		// clear the entire mesh bank
		void clear();
		
#pragma mark ---------------------------------------------------------
#pragma mark === End Public Functions  ===
#pragma mark ---------------------------------------------------------
		
#pragma mark ---------------------------------------------------------
#pragma mark === Private Functions  ===
#pragma mark ---------------------------------------------------------
		
		GLMesh * loadMS( const NSString * _filePath );
		GLMesh * loadMVA( const NSString * _filePath );
		GLMesh * loadMD2( const NSString * _filePath );
		
#pragma mark ---------------------------------------------------------
#pragma mark === End Private Functions  ===
#pragma mark ---------------------------------------------------------
		
#pragma mark ---------------------------------------------------------
#pragma mark === Private Data  ===
#pragma mark ---------------------------------------------------------
	private: // Data
		
		NSDictionary *				 m_extHash;
		
		std::map<NSUInteger,GLMesh*> m_meshes;
		
#pragma mark ---------------------------------------------------------
#pragma mark === Private Data  ===
#pragma mark ---------------------------------------------------------
	};

};

#endif