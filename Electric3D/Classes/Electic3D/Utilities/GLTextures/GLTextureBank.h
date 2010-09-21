/*
 *  GLTextureBank.h
 *  Electric3D
 *
 *  Created by robert on 16/04/2009.
 *  Copyright 2009 Electric TopHat. All rights reserved.
 *
 */

#if !defined(__GLTextureBank_h__)
#define __GLTextureBank_h__

#import <UIKit/UIKit.h>
#import <OpenGLES/ES1/gl.h>
#import <map>

namespace GLTextures 
{
	#pragma mark ---------------------------------------------------------
	#pragma mark Forward Declaration
	#pragma mark ---------------------------------------------------------
	class GLTexture;
	class GLTextureSprite;
	#pragma mark ---------------------------------------------------------

	class GLTextureBank
	{
	#pragma mark ---------------------------------------------------------
	#pragma mark Constructor / Destructor
	#pragma mark ---------------------------------------------------------
	public: // Functions
		
		// --------------------------------------------------
		// Constructor
		// --------------------------------------------------
		GLTextureBank();
		
		// --------------------------------------------------
		// Destructor
		// --------------------------------------------------
		~GLTextureBank();
		
	#pragma mark ---------------------------------------------------------
	#pragma mark End Constructor / Destructor
	#pragma mark ---------------------------------------------------------
		
	#pragma mark ---------------------------------------------------------
	#pragma mark Public Functions
	#pragma mark ---------------------------------------------------------
	public:	// Functions
			
		// add a texture to the bank
		const GLTexture * load( const NSString * _name );
		
		// add a texture sprite to the bank
		const GLTextureSprite * loadSprite( NSString * _name, NSString * _extention = @"sprite" );

		// remove the texture from the bank
		void release( const GLTexture * _texture );
		void release( const GLTextureSprite * _texture );
		
		// clear the entire texture bank
		void clear();
		
	#pragma mark ---------------------------------------------------------
	#pragma mark End Public Functions
	#pragma mark ---------------------------------------------------------
		
	#pragma mark ---------------------------------------------------------
	#pragma mark Private Functions
	#pragma mark ---------------------------------------------------------
	private: // Functions
		
		// create the default texture
		GLuint defaultTexture( CGSize & _size );
		
		// convert the UIImage into a format that can 
		// be used by OpenGL
		GLuint loadTexture( const NSString * _name, CGSize & _size );
			
		// unbind the texture
		void freeTexture( const NSString * _name, GLuint _bindID );
		
	#pragma mark ---------------------------------------------------------
	#pragma mark End Private Functions
	#pragma mark ---------------------------------------------------------
		
	#pragma mark ---------------------------------------------------------
	#pragma mark Private Data
	#pragma mark ---------------------------------------------------------
	private: // Data
		
		std::map<NSUInteger,GLTexture*>			m_textures;
		std::map<NSUInteger,GLTextureSprite*>	m_sprites;
		
	#pragma mark ---------------------------------------------------------
	#pragma mark End Private Data
	#pragma mark ---------------------------------------------------------
	};
	
};

#endif