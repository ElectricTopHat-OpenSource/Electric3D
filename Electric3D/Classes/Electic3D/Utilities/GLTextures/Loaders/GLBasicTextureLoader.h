//
//  GLTextureLoader.h
//  Electric2D
//
//  Created by Robert McDowell on 16/10/2009.
//  Copyright 2009 Electric TopHat Ltd.. All rights reserved.
//

#if !defined(__GLBasicTextureLoader_h__)
#define __GLBasicTextureLoader_h__

#import <UIKit/UIKit.h>
#import <OpenGLES/ES1/gl.h>

namespace GLTextures 
{
	/// -------------------------------------
	/// Basic Texture Loader for .png, .jpg,
	/// .bmp Files
	/// -------------------------------------
	class GLBasicTextureLoader
	{
	public:
		
		/// ----------------------------------------------------
		/// Function : Load the texture if present.
		///            
		/// returns the gl refrence id and the
		/// size of the texture.
		/// ----------------------------------------------------
		static Boolean load( const NSString * _name, const NSString * _ext, GLuint & _bindID, CGSize & _size );
		static Boolean load( const NSString * _path, GLuint & _bindID, CGSize & _size );
		
	};
	
};

#endif // __GLBasicTextureLoader_h__