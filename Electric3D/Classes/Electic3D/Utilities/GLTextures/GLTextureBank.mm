/*
 *  GLTextureBank.mm
 *  Electric3D
 *
 *  Created by robert on 16/04/2009.
 *  Copyright 2009 Electric TopHat. All rights reserved.
 *
 */

#include "GLTextureBank.h"
#include "GLTexture.h"
#include "GLTextureSprite.h"

#include "GLBasicTextureLoader.h"
#include "GLPVRTextureLoader.h"

namespace GLTextures 
{
	#pragma mark ---------------------------------------------------------
	#pragma mark Constructor / Destructor
	#pragma mark ---------------------------------------------------------

	// --------------------------------------------------
	// Constructor
	// --------------------------------------------------
	GLTextureBank::GLTextureBank()
	{	
	}

	// --------------------------------------------------
	// Destructor
	// --------------------------------------------------
	GLTextureBank::~GLTextureBank()
	{
	}

	#pragma mark ---------------------------------------------------------
	#pragma mark End Constructor / Destructor
	#pragma mark ---------------------------------------------------------

	#pragma mark ---------------------------------------------------------
	#pragma mark Public Functions
	#pragma mark ---------------------------------------------------------

	// --------------------------------------------------
	// add a texture to the bank
	// --------------------------------------------------
	const GLTexture * GLTextureBank::load( const NSString * _name )
	{
		GLTexture * texture = nil;
		
		std::map<NSUInteger,GLTexture*>::iterator lb = m_textures.lower_bound(_name.hash);
		if (lb != m_textures.end() && !(m_textures.key_comp()(_name.hash, lb->first)))
		{
			texture = lb->second;
			texture->incrementReferenceCount();
		}
		else // Load the texture and convert it.
		{
			// load the texture and bind it to 
			// an openGL texture
			CGSize size = CGSizeZero;
			GLuint bindID = loadTexture(_name, size);
			
			if ( bindID )
			{
				texture = new GLTexture(_name, bindID, size);
				
				// add it into the map
				m_textures[_name.hash] =  texture;
			}
		}
		
		return texture;
	}

	// --------------------------------------------------
	// add a sprite texture to the texture bank
	// --------------------------------------------------
	const GLTextureSprite * GLTextureBank::loadSprite( NSString * _name, NSString * _extention )
	{	
		GLTextureSprite * texture = nil;
		
		std::map<NSUInteger,GLTextureSprite*>::iterator lb = m_sprites.lower_bound(_name.hash);
		if (lb != m_sprites.end() && !(m_sprites.key_comp()(_name.hash, lb->first)))
		{
			texture = lb->second;
			texture->incrementReferenceCount();
		}
		else // Load the texture and convert it.
		{
			NSString * path = [[NSBundle mainBundle] pathForResource:_name ofType:_extention];
			
			if ( path )
			{
				NSDictionary * dictionary = [[NSDictionary alloc] initWithContentsOfFile:path];

				if ( dictionary )
				{
					NSString * textureName = [dictionary objectForKey:@"Texture"];

					// load the texture and bind it to 
					// an openGL texture
					CGSize size = CGSizeZero;
					GLuint bindID = loadTexture(textureName, size);
			
					if ( bindID )
					{
						if ( ( [dictionary objectForKey:@"Height"] != nil ) && 
							 ( [dictionary objectForKey:@"Width"] != nil ) )
						{
							NSUInteger frameCount  = [[dictionary objectForKey:@"Frames"] intValue];
							NSUInteger frameHeight = [[dictionary objectForKey:@"Height"] intValue];
							NSUInteger frameWidth = [[dictionary objectForKey:@"Width"] intValue];
						
							texture = new GLTextureSprite(_name, bindID, size, frameCount, CGSizeMake(frameWidth, frameHeight) );
						}
						else if ( [dictionary objectForKey:@"Frames"] )
						{
							NSArray * array = [dictionary objectForKey:@"Frames"];
							
							texture = new GLTextureSprite(_name, bindID, size, array);
						}
				
						m_sprites[_name.hash] = texture;
					}
					
					[dictionary release];
				}
				else
				{
					NSLog(@"Sprite Load fail for %@, file is not a valid plist object.", _name);
					CGSize size = CGSizeZero;
					GLuint bindID = defaultTexture(size);
					texture = new GLTextureSprite(_name, bindID, size, 1, CGSizeMake(64, 64) );
					
					m_sprites[_name.hash] = texture;
				}
			}
			else
			{
				NSLog(@"Sprite Load fail for %@, Sprite File is missing.", _name);
				CGSize size = CGSizeZero;
				GLuint bindID = defaultTexture(size);
				texture = new GLTextureSprite(_name, bindID, size, 1, CGSizeMake(64, 64) );
				
				m_sprites[_name.hash] = texture;
			}
		}
		
		return texture;
	}

	// --------------------------------------------------
	// try to remove the texture from the bank
	// --------------------------------------------------
	void GLTextureBank::release( const GLTexture * _texture )
	{	
		NSUInteger key = [_texture->name() hash];
		std::map<NSUInteger,GLTexture*>::iterator lb = m_textures.lower_bound(key);
		if (lb != m_textures.end() && !(m_textures.key_comp()(key, lb->first)))
		{
			GLTexture * texture = lb->second;
			texture->decrementReferenceCount();
			
			if ( texture->referenceCount() <= 0 )
			{
				// remove the object reference
				// from the map
				m_textures.erase( lb );
				
				// free the texture
				freeTexture(texture->name(), texture->bindID());
				
				// delete the object
				delete( texture );
			}
		}
	}

	// --------------------------------------------------
	// try to remove the texture from the bank
	// --------------------------------------------------
	void GLTextureBank::release( const GLTextureSprite * _texture )
	{	
		NSUInteger key = [_texture->name() hash];
		std::map<NSUInteger,GLTextureSprite*>::iterator lb = m_sprites.lower_bound(key);
		if (lb != m_sprites.end() && !(m_sprites.key_comp()(key, lb->first)))
		{
			GLTextureSprite * texture = lb->second;
			texture->decrementReferenceCount();
			
			if ( texture->referenceCount() <= 0 )
			{
				// remove the object reference
				// from the map
				m_sprites.erase( lb );
				
				// free the texture
				freeTexture(texture->name(), texture->bindID());
				
				// delete the object
				delete( texture );
			}
		}
	}

	// --------------------------------------------------
	// Clear the current texture bank
	// --------------------------------------------------
	void GLTextureBank::clear()
	{
		std::map<NSUInteger,GLTexture*>::iterator objt;
		for (objt = m_textures.begin(); objt != m_textures.end(); ++objt) 
		{
			GLTexture * texture = objt->second;
			delete( texture );
		}
		// remove all the dead pointers
		m_textures.clear();
		
		std::map<NSUInteger,GLTextureSprite*>::iterator objs;
		for (objs = m_sprites.begin(); objs != m_sprites.end(); ++objs) 
		{
			GLTextureSprite * texture = objs->second;
			delete( texture );
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
	// create a defalt texture
	// --------------------------------------------------
	GLuint GLTextureBank::defaultTexture( CGSize & _size )
	{
		GLuint bindID = 0;
		NSInteger size  = 2;
		_size.width = _size.height	= size;
		GLubyte data[12] = { 255, 0, 255, 0, 255, 0, 255, 0, 255, 0, 255, 0 };
		glPixelStorei(GL_UNPACK_ALIGNMENT, 1);
		glGenTextures(1, &bindID);
		glBindTexture(GL_TEXTURE_2D, bindID);
		glTexImage2D(GL_TEXTURE_2D, 0, GL_RGB, size, size, 0, GL_RGB, GL_UNSIGNED_BYTE, data);
		return bindID;
	}

	// --------------------------------------------------
	// load a Texture
	// --------------------------------------------------
	GLuint GLTextureBank::loadTexture( const NSString * _name, CGSize & _size )
	{	
		// OpenGL name for the texture 
		GLuint textureName = 0;
		
		if ( !GLBasicTextureLoader::load( _name, @"png", textureName, _size ) &&
			 !GLPVRTextureLoader::load( _name, @"pvr", textureName, _size ) ) 
		{
			NSLog(@"Texture Load fail for %@.", _name);
			textureName = defaultTexture( _size );
		}
		else 
		{
			NSLog(@"Loaded texture %@", _name);
		}
		
		return textureName;
	}

	// --------------------------------------------------
	// Free the Texture
	// --------------------------------------------------
	void GLTextureBank::freeTexture( const NSString * _name, GLuint _bindID )
	{
		NSLog(@"Freed texture %@", _name);
		
		GLuint name[1] = { _bindID };
		glDeleteTextures(1, name);
	}

	#pragma mark ---------------------------------------------------------
	#pragma mark End Private Functions
	#pragma mark ---------------------------------------------------------

};