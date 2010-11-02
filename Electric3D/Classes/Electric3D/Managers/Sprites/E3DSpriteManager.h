//
//  E3DSpriteManager.h
//  Electric3D
//
//  Created by Robert McDowell on 24/09/2010.
//  Copyright 2010 Electric TopHat Ltd. All rights reserved.
//

#if !defined(__E3DSpriteManager_h__)
#define __E3DSpriteManager_h__

#import <map>

#pragma mark ---------------------------------------------------------
#pragma mark Forward Declaration
#pragma mark ---------------------------------------------------------
namespace E3D	{ class E3DTextureManager; };
namespace E3D		{ class E3DSprite; }
#pragma mark ---------------------------------------------------------

namespace E3D
{
	class E3DSpriteManager  
	{
#pragma mark ---------------------------------------------------------
#pragma mark Constructor / Destructor
#pragma mark ---------------------------------------------------------
	public: // Functions
		
		// --------------------------------------------------
		// Constructor
		// --------------------------------------------------
		E3DSpriteManager( E3D::E3DTextureManager * _texturefactory );
		
		// --------------------------------------------------
		// Destructor
		// --------------------------------------------------
		~E3DSpriteManager();
		
#pragma mark ---------------------------------------------------------
#pragma mark End Constructor / Destructor
#pragma mark ---------------------------------------------------------
		
#pragma mark ---------------------------------------------------------
#pragma mark Public Functions
#pragma mark ---------------------------------------------------------
	public:	// Functions
		
		BOOL isLoaded( const NSString * _name, const NSString * _ext, NSBundle * _bundle = nil );
		BOOL isLoaded( const NSString * _filePath );
		
		const E3DSprite * load( const NSString * _name, const NSString * _ext, NSBundle * _bundle = nil );
		const E3DSprite * load( const NSString * _filePath );
		
		void release( const E3DSprite * _texture );
		
		void clear();
		
#pragma mark ---------------------------------------------------------
#pragma mark End Public Functions
#pragma mark ---------------------------------------------------------
		
#pragma mark ---------------------------------------------------------
#pragma mark Private Functions
#pragma mark ---------------------------------------------------------
	private: // Functions
		
		E3DSprite *	loadSprite( const NSString * _filePath );
		
#pragma mark ---------------------------------------------------------
#pragma mark End Private Functions
#pragma mark ---------------------------------------------------------
		
#pragma mark ---------------------------------------------------------
#pragma mark Private Data
#pragma mark ---------------------------------------------------------
	private: // Data
		
		E3D::E3DTextureManager *			m_texturefactory;
		
		std::map<NSUInteger,E3DSprite*>			m_sprites;
		
#pragma mark ---------------------------------------------------------
#pragma mark End Private Data
#pragma mark ---------------------------------------------------------
	};
	
};

#endif