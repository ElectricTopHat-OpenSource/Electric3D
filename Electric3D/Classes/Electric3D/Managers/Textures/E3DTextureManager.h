//
//  E3DTextureManager.h
//  Electric3D
//
//  Created by Robert McDowell on 24/09/2010.
//  Copyright 2010 Electric TopHat Ltd. All rights reserved.
//

#if !defined(__E3DTextureManager_h__)
#define __E3DTextureManager_h__

#import <OpenGLES/ES2/gl.h>
#import <map>

namespace E3D 
{
#pragma mark ---------------------------------------------------------
#pragma mark Forward Declaration
#pragma mark ---------------------------------------------------------
	class E3DTexture;
#pragma mark ---------------------------------------------------------
	
	class E3DTextureManager  
	{
#pragma mark ---------------------------------------------------------
#pragma mark Constructor / Destructor
#pragma mark ---------------------------------------------------------
	public: // Functions
		
		// --------------------------------------------------
		// Constructor
		// --------------------------------------------------
		E3DTextureManager();
		
		// --------------------------------------------------
		// Destructor
		// --------------------------------------------------
		~E3DTextureManager();
		
#pragma mark ---------------------------------------------------------
#pragma mark End Constructor / Destructor
#pragma mark ---------------------------------------------------------
		
#pragma mark ---------------------------------------------------------
#pragma mark Public Functions
#pragma mark ---------------------------------------------------------
	public:	// Functions
		
		BOOL isLoaded( const NSString * _name, const NSString * _ext, NSBundle * _bundle = nil );
		BOOL isLoaded( const NSString * _filePath );
		
		const E3DTexture * load( const NSString * _name, const NSString * _ext, NSBundle * _bundle = nil );
		const E3DTexture * load( const NSString * _filePath );
		
		void release( const E3DTexture * _texture );
		
		void clear();
		
#pragma mark ---------------------------------------------------------
#pragma mark End Public Functions
#pragma mark ---------------------------------------------------------
		
#pragma mark ---------------------------------------------------------
#pragma mark Private Functions
#pragma mark ---------------------------------------------------------
	private: // Functions
		
		E3DTexture *	loadTexture( const NSString * _filePath );
		
		GLuint defaultTexture( CGSize & _size );
		
		GLuint loadTexture( const NSString * _filePath, CGSize & _size );
		
		void freeTexture( const NSString * _name, GLuint _bindID );
		
#pragma mark ---------------------------------------------------------
#pragma mark End Private Functions
#pragma mark ---------------------------------------------------------
		
#pragma mark ---------------------------------------------------------
#pragma mark Private Data
#pragma mark ---------------------------------------------------------
	private: // Data
		
		std::map<NSUInteger,E3DTexture*>			m_textures;
		
#pragma mark ---------------------------------------------------------
#pragma mark End Private Data
#pragma mark ---------------------------------------------------------
	};
	
};

#endif
