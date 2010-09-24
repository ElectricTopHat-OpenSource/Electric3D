//
//  GLTextureLoader.mm
//  Electric2D
//
//  Created by Robert McDowell on 16/10/2009.
//  Copyright 2009 Electric TopHat Ltd.. All rights reserved.
//

#import "GLBasicTextureLoader.h"

namespace GLTextures 
{
	
	// --------------------------------------------------
	// Consts
	// --------------------------------------------------

	#define kMaxTextureSize	 1024

	// --------------------------------------------------

	// --------------------------------------------------
	// load a Texture
	// --------------------------------------------------
	Boolean GLBasicTextureLoader::load( const NSString * _path, GLuint & _bindID, CGSize & _size )
	{
		if ( _path )
		{
			// Creates a Core Graphics image from an image file
			UIImage* img = [UIImage imageWithContentsOfFile:_path];
							
			if (img) 
			{
				// grab the ImageRef
				CGImageRef imageref = img.CGImage;
				
				// Get the width and height of the image
				size_t width = CGImageGetWidth(imageref);
				size_t height = CGImageGetHeight(imageref);
				// Texture dimensions must be a power of 2. If you write an application that allows users to supply an image,
				// you'll want to add code that checks the dimensions and takes appropriate action if they are not a power of 2.
				
				// make sure the image is a power of two
				BOOL					sizeToFit = NO;
				if((width != 1) && (width & (width - 1))) {
					int i = 1;
					while((sizeToFit ? 2 * i : i) < width)
					{
						i *= 2;
					}
					width = i;
				}
				if((height != 1) && (height & (height - 1))) {
					int i = 1;
					while((sizeToFit ? 2 * i : i) < height)
					{
						i *= 2;
					}
					height = i;
				}
				
				// limit the image size
				CGAffineTransform		transform = CGAffineTransformIdentity;
				while((width > kMaxTextureSize) || (height > kMaxTextureSize)) 
				{
					width *= 0.5f;
					height *= 0.5f;
					transform = CGAffineTransformScale(transform, 0.5f, 0.5f);
				}
				
				
				CGImageAlphaInfo		info = CGImageGetAlphaInfo(imageref);
				Boolean					hasAlpha = ((info == kCGImageAlphaPremultipliedLast) || (info == kCGImageAlphaPremultipliedFirst) || (info == kCGImageAlphaLast) || (info == kCGImageAlphaFirst) ? YES : NO);
				
				GLubyte * imageData;
				CGContextRef imageContext;
				
				NSInteger pixelFormat = -1;
				if(CGImageGetColorSpace(imageref)) 
				{
					NSInteger bitmapinfo = 0;
					if(hasAlpha)
					{
						pixelFormat = 0;
						bitmapinfo = kCGImageAlphaPremultipliedLast | kCGBitmapByteOrder32Big;
					}
					else
					{
						pixelFormat = 1;
						bitmapinfo = kCGImageAlphaNoneSkipLast | kCGBitmapByteOrder32Big;
					}
					
					CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
					imageData = (GLubyte *) malloc(width * height * 4);
					imageContext = CGBitmapContextCreate(imageData, width, height, 8, 4 * width, colorSpace, bitmapinfo);
					CGColorSpaceRelease(colorSpace);
				} 
				else  //NOTE: No colorspace means a mask image
				{
					pixelFormat = 2;
					imageData = (GLubyte *) malloc(height * width);
					imageContext = CGBitmapContextCreate(imageData, width, height, 8, width, NULL, kCGImageAlphaOnly);
				}
				
				// After you create the context, you can draw the sprite image to the context.
				CGRect frame = CGRectMake(0, 0, width, height);
				CGContextClearRect(imageContext, frame);
				CGContextDrawImage(imageContext, frame, imageref);
				
				//Convert "RRRRRRRRRGGGGGGGGBBBBBBBBAAAAAAAA" to "RRRRRGGGGGGBBBBB"
				if(!hasAlpha) 
				{
					GLubyte * tempData = (GLubyte *) malloc(height * width * 2);
					unsigned int* inPixel32 = (unsigned int*)imageData;
					unsigned short* outPixel16 = (unsigned short*)tempData;
					for(int i = 0; i < width * height; ++i, ++inPixel32)
					{
						*outPixel16++ = ((((*inPixel32 >> 0) & 0xFF) >> 3) << 11) | ((((*inPixel32 >> 8) & 0xFF) >> 2) << 5) | ((((*inPixel32 >> 16) & 0xFF) >> 3) << 0);
					}
					free(imageData);
					imageData = tempData;
				}
				
				// You don't need the context at this point, so you need to release it to avoid memory leaks.
				CGContextRelease(imageContext);
				
				// Use OpenGL ES to generate a name for the texture.
				glGenTextures(1, &_bindID);
				
				// Bind the texture name. 
				glBindTexture(GL_TEXTURE_2D, _bindID);
				
				// Speidfy a 2D texture image, provideing the a pointer to the image data in memory
				switch(pixelFormat) {
						
					case 0:
						glTexImage2D(GL_TEXTURE_2D, 0, GL_RGBA, width, height, 0, GL_RGBA, GL_UNSIGNED_BYTE, imageData);
						break;
					case 1:
						glTexImage2D(GL_TEXTURE_2D, 0, GL_RGB, width, height, 0, GL_RGB, GL_UNSIGNED_SHORT_5_6_5, imageData);
						break;
					case 2:
						glTexImage2D(GL_TEXTURE_2D, 0, GL_ALPHA, width, height, 0, GL_ALPHA, GL_UNSIGNED_BYTE, imageData);
						break;
					default:
						[NSException raise:NSInternalInconsistencyException format:@""];
						
				}
				
				// Release the image data
				free(imageData);
				
				// Set the texture parameters to use a minifying filter and a linear filer (weighted average)
				glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_MIN_FILTER, GL_LINEAR);
				glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_MAG_FILTER, GL_LINEAR);
				
				_size.width = width;
				_size.height = height;
				
				return TRUE;
			}
			
		}
		
		return FALSE;
	}
	
};
