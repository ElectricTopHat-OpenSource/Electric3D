//
//  GLTextureFactory.m
//  Electric3D
//
//  Created by Robert McDowell on 24/09/2010.
//  Copyright 2010 Electric TopHat Ltd. All rights reserved.
//

#import "GLTextureFactory.h"
#import "GLTexture.h"

#import "GLBasicTextureLoader.h"
#import "GLPVRTextureLoader.h"

namespace GLTextures 
{
#pragma mark ---------------------------------------------------------
#pragma mark Constructor / Destructor
#pragma mark ---------------------------------------------------------
	
	// --------------------------------------------------
	// Constructor
	// --------------------------------------------------
	GLTextureFactory::GLTextureFactory()
	{	
	}
	
	// --------------------------------------------------
	// Destructor
	// --------------------------------------------------
	GLTextureFactory::~GLTextureFactory()
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
	BOOL GLTextureFactory::isLoaded( const NSString * _name, const NSString * _ext, NSBundle * _bundle )
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
	BOOL GLTextureFactory::isLoaded( const NSString * _filePath )
	{
		std::map<NSUInteger,GLTexture*>::iterator lb = m_textures.lower_bound(_filePath.hash);
		if (lb != m_textures.end() && !(m_textures.key_comp()(_filePath.hash, lb->first)))
		{
			return true;
		}
		return false;
	}
	
	// --------------------------------------------------
	// load a texture
	// --------------------------------------------------
	const GLTexture * GLTextureFactory::load( const NSString * _name, const NSString * _ext, NSBundle * _bundle )
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
	// add a texture to the bank
	// --------------------------------------------------
	const GLTexture * GLTextureFactory::load( const NSString * _filePath )
	{
		GLTexture * texture = nil;
		
		std::map<NSUInteger,GLTexture*>::iterator lb = m_textures.lower_bound(_filePath.hash);
		if (lb != m_textures.end() && !(m_textures.key_comp()(_filePath.hash, lb->first)))
		{
			texture = lb->second;
			texture->incrementReferenceCount();
		}
		else // Load the texture and convert it.
		{
			texture = loadTexture( _filePath ); 
			
			if ( texture )
			{
				m_textures[[_filePath hash]] = texture;
			}
		}
		
		return texture;
	}
		
	// --------------------------------------------------
	// try to remove the texture from the bank
	// --------------------------------------------------
	void GLTextureFactory::release( const GLTexture * _texture )
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
				
				// indicate the texture has been released
				texture->textureRemoved();
				
				// delete the object
				delete( texture );
			}
		}
	}
		
	// --------------------------------------------------
	// Clear the current texture bank
	// --------------------------------------------------
	void GLTextureFactory::clear()
	{
		std::map<NSUInteger,GLTexture*>::iterator objt;
		for (objt = m_textures.begin(); objt != m_textures.end(); ++objt) 
		{
			GLTexture * texture = objt->second;
						
			// free the texture
			freeTexture(texture->name(), texture->bindID());
			
			// indicate the texture has been released
			texture->textureRemoved();
			
			// delete the object
			delete( texture );
		}
		// remove all the dead pointers
		m_textures.clear();
	}
	
#pragma mark ---------------------------------------------------------
#pragma mark End Public Functions
#pragma mark ---------------------------------------------------------
	
#pragma mark ---------------------------------------------------------
#pragma mark Private Functions
#pragma mark ---------------------------------------------------------
	
	// --------------------------------------------------
	// load a basic texture
	// --------------------------------------------------
	GLTexture *	GLTextureFactory::loadTexture( const NSString * _filePath )
	{
		// load the texture and bind it to 
		// an openGL texture
		CGSize size = CGSizeZero;
		GLuint bindID = loadTexture( _filePath, size );
		
		if ( bindID )
		{
			return new GLTexture( _filePath, bindID, size );
		}
		return nil;
	}
	
	// --------------------------------------------------
	// create a defalt texture
	// --------------------------------------------------
	GLuint GLTextureFactory::defaultTexture( CGSize & _size )
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
	GLuint GLTextureFactory::loadTexture( const NSString * _filePath, CGSize & _size )
	{	
		// OpenGL name for the texture 
		GLuint bindID = 0;
		
		if ( [[[_filePath pathExtension] lowercaseString] hash] == [@"pvr" hash] )
		{
			if ( !GLPVRTextureLoader::load( _filePath, bindID, _size ) ) 
			{
				DPrint(@"ERROR :: Texture Load fail for %@.", _filePath);
				bindID = defaultTexture( _size );
			}
			else 
			{
				DPrint(@"Loaded texture %@", _filePath);
			}	
		}
		else 
		{
			if ( !GLBasicTextureLoader::load( _filePath, bindID, _size ) ) 
			{
				DPrint(@"Texture Load fail for %@.", _filePath);
				bindID = defaultTexture( _size );
			}
			else 
			{
				DPrint(@"Loaded texture %@", _filePath);
			}
		}
		
		return bindID;
	}
	
	// --------------------------------------------------
	// Free the Texture
	// --------------------------------------------------
	void GLTextureFactory::freeTexture( const NSString * _name, GLuint _bindID )
	{
		NSLog(@"Freed texture %@", _name);
		
		GLuint name[1] = { _bindID };
		glDeleteTextures(1, name);
	}
	
#pragma mark ---------------------------------------------------------
#pragma mark End Private Functions
#pragma mark ---------------------------------------------------------
	
};