//
//  GLSpriteFactory.h
//  Electric3D
//
//  Created by Robert McDowell on 24/09/2010.
//  Copyright 2010 Electric TopHat Ltd. All rights reserved.
//

#if !defined(__GLSpriteFactory_h__)
#define __GLSpriteFactory_h__

#import <map>

#pragma mark ---------------------------------------------------------
#pragma mark Forward Declaration
#pragma mark ---------------------------------------------------------
namespace GLTextures	{ class GLTextureFactory; };
namespace GLSprites		{ class GLSprite; }
#pragma mark ---------------------------------------------------------

namespace GLSprites
{
	class GLSpriteFactory  
	{
#pragma mark ---------------------------------------------------------
#pragma mark Constructor / Destructor
#pragma mark ---------------------------------------------------------
	public: // Functions
		
		// --------------------------------------------------
		// Constructor
		// --------------------------------------------------
		GLSpriteFactory( GLTextures::GLTextureFactory * _texturefactory );
		
		// --------------------------------------------------
		// Destructor
		// --------------------------------------------------
		~GLSpriteFactory();
		
#pragma mark ---------------------------------------------------------
#pragma mark End Constructor / Destructor
#pragma mark ---------------------------------------------------------
		
#pragma mark ---------------------------------------------------------
#pragma mark Public Functions
#pragma mark ---------------------------------------------------------
	public:	// Functions
		
		BOOL isLoaded( const NSString * _name, const NSString * _ext, NSBundle * _bundle = nil );
		BOOL isLoaded( const NSString * _filePath );
		
		const GLSprite * load( const NSString * _name, const NSString * _ext, NSBundle * _bundle = nil );
		const GLSprite * load( const NSString * _filePath );
		
		void release( const GLSprite * _texture );
		
		void clear();
		
#pragma mark ---------------------------------------------------------
#pragma mark End Public Functions
#pragma mark ---------------------------------------------------------
		
#pragma mark ---------------------------------------------------------
#pragma mark Private Functions
#pragma mark ---------------------------------------------------------
	private: // Functions
		
		GLSprite *	loadSprite( const NSString * _filePath );
		
#pragma mark ---------------------------------------------------------
#pragma mark End Private Functions
#pragma mark ---------------------------------------------------------
		
#pragma mark ---------------------------------------------------------
#pragma mark Private Data
#pragma mark ---------------------------------------------------------
	private: // Data
		
		GLTextures::GLTextureFactory *			m_texturefactory;
		
		std::map<NSUInteger,GLSprite*>			m_sprites;
		
#pragma mark ---------------------------------------------------------
#pragma mark End Private Data
#pragma mark ---------------------------------------------------------
	};
	
};

#endif