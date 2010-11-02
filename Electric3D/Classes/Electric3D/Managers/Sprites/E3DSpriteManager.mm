//
//  E3DSpriteManager.m
//  Electric3D
//
//  Created by Robert McDowell on 24/09/2010.
//  Copyright 2010 Electric TopHat Ltd. All rights reserved.
//

#import "E3DSpriteManager.h"
#import "E3DSprite.h"

#import "E3DTextureManager.h"
#import "E3DTexture.h"

namespace E3D 
{
#pragma mark ---------------------------------------------------------
#pragma mark Constructor / Destructor
#pragma mark ---------------------------------------------------------
	
	// --------------------------------------------------
	// Constructor
	// --------------------------------------------------
	E3DSpriteManager::E3DSpriteManager( E3D::E3DTextureManager * _texturefactory )
	{	
	}
	
	// --------------------------------------------------
	// Destructor
	// --------------------------------------------------
	E3DSpriteManager::~E3DSpriteManager()
	{
		clear();
	}
	
#pragma mark ---------------------------------------------------------
#pragma mark End Constructor / Destructor
#pragma mark ---------------------------------------------------------
	
#pragma mark ---------------------------------------------------------
#pragma mark Public Functions
#pragma mark ---------------------------------------------------------
	
	// --------------------------------------------------
	// is the file in memory
	// --------------------------------------------------
	BOOL E3DSpriteManager::isLoaded( const NSString * _name, const NSString * _ext, NSBundle * _bundle )
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
	// is the file in memory
	// --------------------------------------------------
	BOOL E3DSpriteManager::isLoaded( const NSString * _filePath )
	{
		std::map<NSUInteger,E3DSprite*>::iterator lb = m_sprites.lower_bound(_filePath.hash);
		if (lb != m_sprites.end() && !(m_sprites.key_comp()(_filePath.hash, lb->first)))
		{
			return true;
		}
		return false;
	}
	
	// --------------------------------------------------
	// load a texture
	// --------------------------------------------------
	const E3DSprite * E3DSpriteManager::load( const NSString * _name, const NSString * _ext, NSBundle * _bundle )
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
	// load a sprite
	// --------------------------------------------------
	const E3DSprite * E3DSpriteManager::load( const NSString * _filePath )
	{
		E3DSprite * sprite = nil;
		
		std::map<NSUInteger,E3DSprite*>::iterator lb = m_sprites.lower_bound(_filePath.hash);
		if (lb != m_sprites.end() && !(m_sprites.key_comp()(_filePath.hash, lb->first)))
		{
			sprite = lb->second;
			sprite->incrementReferenceCount();
		}
		else // Load the texture and convert it.
		{
			sprite = loadSprite( _filePath ); 
			
			if ( sprite )
			{
				m_sprites[sprite->hash()] = sprite;
			}
		}
		
		return sprite;
	}
	
	// --------------------------------------------------
	// try to remove a sprite
	// --------------------------------------------------
	void E3DSpriteManager::release( const E3DSprite * _sprite )
	{	
		if ( _sprite )
		{
			NSUInteger key = _sprite->hash();
			std::map<NSUInteger,E3DSprite*>::iterator lb = m_sprites.lower_bound(key);
			if (lb != m_sprites.end() && !(m_sprites.key_comp()(key, lb->first)))
			{
				E3DSprite * sprite = lb->second;
				sprite->decrementReferenceCount();
				
				if ( sprite->referenceCount() <= 0 )
				{
					// remove the object reference
					// from the map
					m_sprites.erase( lb );
					
					// release the texture
					m_texturefactory->release( sprite->texture() );
					
					// idicate that the textures been removed
					sprite->textureRemoved();
					
					// delete the object
					delete( sprite );
				}
			}
		}
	}
	
	// --------------------------------------------------
	// Clear the current texture bank
	// --------------------------------------------------
	void E3DSpriteManager::clear()
	{
		std::map<NSUInteger,E3DSprite*>::iterator objt;
		for (objt = m_sprites.begin(); objt != m_sprites.end(); ++objt) 
		{
			E3DSprite * sprite = objt->second;
			
			// release the texture
			m_texturefactory->release( sprite->texture() );
			
			// idicate that the textures been removed
			sprite->textureRemoved();
			
			delete( sprite );
		}
		// remove all the dead pointers
		m_sprites.clear();
	}
	
#pragma mark ---------------------------------------------------------
#pragma mark End Public Functions
#pragma mark ---------------------------------------------------------
	
#pragma mark ---------------------------------------------------------
#pragma mark Private Functions
#pragma mark ---------------------------------------------------------
		
	// --------------------------------------------------
	// load a sprite texture
	// --------------------------------------------------
	E3DSprite * E3DSpriteManager::loadSprite( const NSString * _filePath )
	{
		E3DSprite * sprite = nil;
		
		if  ( m_texturefactory )
		{
			NSDictionary * dictionary = [NSDictionary dictionaryWithContentsOfFile:_filePath];
			
			if ( dictionary )
			{
				NSString * textureName	= [dictionary objectForKey:@"Texture"];
				
				NSString * textureDir	= [_filePath stringByDeletingLastPathComponent];
				NSString * texturePath	= [textureDir stringByAppendingPathComponent:textureName];
				
				// use the standard load function to load the 
				// basic texture
				const E3D::E3DTexture * texture = m_texturefactory->load( texturePath );
				
				if ( ( [dictionary objectForKey:@"Height"] != nil ) && 
					 ( [dictionary objectForKey:@"Width"]  != nil ) )
				{
					NSUInteger frameCount  = [[dictionary objectForKey:@"Frames"] intValue];
					NSUInteger frameHeight = [[dictionary objectForKey:@"Height"] intValue];
					NSUInteger frameWidth  = [[dictionary objectForKey:@"Width"] intValue];
					
					sprite = new E3DSprite(_filePath, texture, frameCount, CGSizeMake(frameWidth, frameHeight) );
				}
				else if ( [dictionary objectForKey:@"Frames"] )
				{
					NSArray * array = [dictionary objectForKey:@"Frames"];
					
					sprite = new E3DSprite(_filePath, texture, array);
				}
			}
			else
			{
				DPrint(@"ERROR :: Sprite Load fail for %@, file is not a valid plist object.", _filePath);
				const E3D::E3DTexture * texture = m_texturefactory->load( @"default" );
				sprite = new E3DSprite(_filePath, texture, 1, CGSizeMake(64, 64) );
			}
		}
		else 
		{
			DPrint(@"ERROR :: Sprite Load fail for %@, Texture Factory not avalaible.", _filePath);
		}

		return sprite;
	}
	
#pragma mark ---------------------------------------------------------
#pragma mark End Private Functions
#pragma mark ---------------------------------------------------------
	
};
