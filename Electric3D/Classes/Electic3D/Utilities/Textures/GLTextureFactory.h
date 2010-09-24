//
//  GLTextureFactory.h
//  Electric3D
//
//  Created by Robert McDowell on 24/09/2010.
//  Copyright 2010 Electric TopHat Ltd. All rights reserved.
//

#if !defined(__GLTextureFactory_h__)
#define __GLTextureFactory_h__

#import <OpenGLES/ES2/gl.h>
#import <map>

namespace GLTextures 
{
#pragma mark ---------------------------------------------------------
#pragma mark Forward Declaration
#pragma mark ---------------------------------------------------------
	class GLTexture;
#pragma mark ---------------------------------------------------------
	
	class GLTextureFactory  
	{
#pragma mark ---------------------------------------------------------
#pragma mark Constructor / Destructor
#pragma mark ---------------------------------------------------------
	public: // Functions
		
		// --------------------------------------------------
		// Constructor
		// --------------------------------------------------
		GLTextureFactory();
		
		// --------------------------------------------------
		// Destructor
		// --------------------------------------------------
		~GLTextureFactory();
		
#pragma mark ---------------------------------------------------------
#pragma mark End Constructor / Destructor
#pragma mark ---------------------------------------------------------
		
#pragma mark ---------------------------------------------------------
#pragma mark Public Functions
#pragma mark ---------------------------------------------------------
	public:	// Functions
		
		BOOL isLoaded( const NSString * _name, const NSString * _ext, NSBundle * _bundle = nil );
		BOOL isLoaded( const NSString * _filePath );
		
		const GLTexture * load( const NSString * _name, const NSString * _ext, NSBundle * _bundle = nil );
		const GLTexture * load( const NSString * _filePath );
		
		void release( const GLTexture * _texture );
		
		void clear();
		
#pragma mark ---------------------------------------------------------
#pragma mark End Public Functions
#pragma mark ---------------------------------------------------------
		
#pragma mark ---------------------------------------------------------
#pragma mark Private Functions
#pragma mark ---------------------------------------------------------
	private: // Functions
		
		GLTexture *	loadTexture( const NSString * _filePath );
		
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
		
		std::map<NSUInteger,GLTexture*>			m_textures;
		
#pragma mark ---------------------------------------------------------
#pragma mark End Private Data
#pragma mark ---------------------------------------------------------
	};
	
};

#endif
