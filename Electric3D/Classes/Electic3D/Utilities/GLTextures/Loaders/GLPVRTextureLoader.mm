//
//  GLPVRTextureLoader.mm
//  Electric2D
//
//  Created by Robert McDowell on 16/10/2009.
//  Copyright 2009 Electric TopHat Ltd.. All rights reserved.
//

#import "GLPVRTextureLoader.h"
#import <stdint.h>
#import <OpenGLES/ES1/glext.h>

namespace GLTextures 
{	
	// --------------------------------------------------
	// Consts
	// --------------------------------------------------
	#define PVR_TEXTURE_FLAG_TYPE_MASK	0xff

	const char gPVRTexIdentifier[5] = "PVR!";

	enum
	{
		kPVRTextureFlagTypePVRTC_2 = 24,
		kPVRTextureFlagTypePVRTC_4
	};

	typedef struct _PVRTexHeader
	{
		uint32_t headerLength;
		uint32_t height;
		uint32_t width;
		uint32_t numMipmaps;
		uint32_t flags;
		uint32_t dataLength;
		uint32_t bpp;
		uint32_t bitmaskRed;
		uint32_t bitmaskGreen;
		uint32_t bitmaskBlue;
		uint32_t bitmaskAlpha;
		uint32_t pvrTag;
		uint32_t numSurfs;
	} PVRTexHeader;
	// --------------------------------------------------

	// --------------------------------------------------
	// load a Texture
	// --------------------------------------------------
	Boolean GLPVRTextureLoader::load( const NSString * _name, const NSString * _ext, GLuint & _bindID, CGSize & _size )
	{
		NSString * path = [[NSBundle mainBundle] pathForResource:_name ofType:_ext];
		return load(path, _bindID, _size);
	}

	// --------------------------------------------------
	// load a Texture
	// --------------------------------------------------
	Boolean GLPVRTextureLoader::load( const NSString * _path, GLuint & _bindID, CGSize & _size )
	{
		Boolean success = FALSE;
		
		if ( _path )
		{
			NSData * data = [NSData dataWithContentsOfFile:_path];
			
			if ( data )
			{
				GLenum internalFormat = GL_COMPRESSED_RGBA_PVRTC_4BPPV1_IMG;
				Boolean hasAlpha = FALSE;
				int width = 0;
				int height = 0;
				
				NSMutableArray * imageData = [[NSMutableArray alloc] initWithCapacity:10];
				
				// Unpack the image data into the data array
				if ( UnPackData(data, imageData, width, height, internalFormat, hasAlpha) )
				{
					success = TRUE;
					_size.width = width;
					_size.height = height;
					
					glGenTextures(1, &_bindID);
					glBindTexture(GL_TEXTURE_2D, _bindID);
					
					// GL_NEAREST, GL_LINEAR, GL_NEAREST_MIPMAP_NEAREST, GL_NEAREST_MIPMAP_LINEAR
					glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_MIN_FILTER, GL_NEAREST);
					// GL_NEAREST, GL_LINEAR
					glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_MAG_FILTER, GL_NEAREST);
					// 1.0f, 2.0f
					glTexParameterf(GL_TEXTURE_2D, GL_TEXTURE_MAX_ANISOTROPY_EXT, 2.0f);
					glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_WRAP_S, GL_CLAMP_TO_EDGE);
					glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_WRAP_T, GL_CLAMP_TO_EDGE);
					
					GLenum err;
					NSData * textureLayer;
					for (int i=0; i < [imageData count]; i++)
					{
						textureLayer = [imageData objectAtIndex:i];
						glCompressedTexImage2D(GL_TEXTURE_2D, i, internalFormat, width, height, 0, [textureLayer length], [textureLayer bytes]);
						
						err = glGetError();
						if (err != GL_NO_ERROR)
						{
							NSLog(@"Error uploading compressed texture level: %d. glError: 0x%04X", i, err);
							glDeleteTextures(1, &_bindID);
							
							success = FALSE;
							
							break;
						}
						
						width = MAX(width >> 1, 1);
						height = MAX(height >> 1, 1);
					}
				}
				
				[imageData release];
			}
		}
		
		return success;
	}

	// --------------------------------------------------
	// Unpack the Texture data
	// --------------------------------------------------
	Boolean GLPVRTextureLoader::UnPackData( const NSData * _data, NSMutableArray * _imageData, int & _width, int & _height, GLenum & _internalFormat, Boolean & _hasAlpha )
	{
		BOOL				success = FALSE;
		PVRTexHeader *		header = NULL;
		uint32_t			flags;
		uint32_t			pvrTag;
		uint32_t			dataLength = 0;
		uint32_t			dataOffset = 0;
		uint32_t			dataSize = 0;
		uint32_t			blockSize = 0;
		uint32_t			widthBlocks = 0;
		uint32_t			heightBlocks = 0;
		uint32_t			width		= 0;
		uint32_t			height		= 0;
		uint32_t			bpp			= 4;
		uint8_t *			bytes		= NULL;
		uint32_t			formatFlags;
		
		header = (PVRTexHeader *)[_data bytes];
		
		pvrTag = CFSwapInt32LittleToHost(header->pvrTag);
		
		if (gPVRTexIdentifier[0] != ((pvrTag >>  0) & 0xff) ||
			gPVRTexIdentifier[1] != ((pvrTag >>  8) & 0xff) ||
			gPVRTexIdentifier[2] != ((pvrTag >> 16) & 0xff) ||
			gPVRTexIdentifier[3] != ((pvrTag >> 24) & 0xff))
		{
			return FALSE;
		}
		
		flags = CFSwapInt32LittleToHost(header->flags);
		formatFlags = flags & PVR_TEXTURE_FLAG_TYPE_MASK;
		
		if ( formatFlags == kPVRTextureFlagTypePVRTC_4 || 
			 formatFlags == kPVRTextureFlagTypePVRTC_2 )
		{
			[_imageData removeAllObjects];
			
			if (formatFlags == kPVRTextureFlagTypePVRTC_4)
				_internalFormat = GL_COMPRESSED_RGBA_PVRTC_4BPPV1_IMG;
			else if (formatFlags == kPVRTextureFlagTypePVRTC_2)
				_internalFormat = GL_COMPRESSED_RGBA_PVRTC_2BPPV1_IMG;
			
			_width = width = CFSwapInt32LittleToHost(header->width);
			_height = height = CFSwapInt32LittleToHost(header->height);
			
			if (CFSwapInt32LittleToHost(header->bitmaskAlpha))
				_hasAlpha = TRUE;
			else
				_hasAlpha = FALSE;
			
			dataLength = CFSwapInt32LittleToHost(header->dataLength);
			
			bytes = ((uint8_t *)[_data bytes]) + sizeof(PVRTexHeader);
			
			// Calculate the data size for each texture level and respect the minimum number of blocks
			while (dataOffset < dataLength)
			{
				if (formatFlags == kPVRTextureFlagTypePVRTC_4)
				{
					blockSize = 4 * 4; // Pixel by pixel block size for 4bpp
					widthBlocks = width / 4;
					heightBlocks = height / 4;
					bpp = 4;
				}
				else
				{
					blockSize = 8 * 4; // Pixel by pixel block size for 2bpp
					widthBlocks = width / 8;
					heightBlocks = height / 4;
					bpp = 2;
				}
				
				// Clamp to minimum number of blocks
				if (widthBlocks < 2)
					widthBlocks = 2;
				if (heightBlocks < 2)
					heightBlocks = 2;
				
				dataSize = widthBlocks * heightBlocks * ((blockSize  * bpp) / 8);
				
				[_imageData addObject:[NSData dataWithBytes:bytes+dataOffset length:dataSize]];
				
				dataOffset += dataSize;
				
				width = MAX(width >> 1, 1);
				height = MAX(height >> 1, 1);
			}
			
			success = TRUE;
		}
		
		return success;
	}

};