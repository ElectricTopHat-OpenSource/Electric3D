//
//  GLPVRTextureLoader.h
//  Electric2D
//
//  Created by Robert McDowell on 16/10/2009.
//  Copyright 2009 Electric TopHat Ltd.. All rights reserved.
//

#if !defined(__GLPVRTextureLoader_h__)
#define __GLPVRTextureLoader_h__

#import <UIKit/UIKit.h>
#import <OpenGLES/ES1/gl.h>

namespace E3D 
{
	/// -------------------------------------
	/// Texture Loader for compressed Power
	/// VR textures.
	/// -------------------------------------
	class GLPVRTextureLoader
	{
	public: // Functions
		
		static Boolean load( const NSString * _path, GLuint & _bindID, CGSize & _size );
		
	private: // Functions
		
		static Boolean UnPackData( const NSData * _data, NSMutableArray * _imageData, int & _width, int & _height, GLenum & _internalFormat, Boolean & _hasAlpha );
		
	};
};
	
#endif // __E3DTextureLoader_h__
