/*
 *  GLTextureSprite.mm
 *  Electric3D
 *
 *  Created by robert on 17/04/2009.
 *  Copyright 2009 Electric TopHat. All rights reserved.
 *
 */

#include "GLTextureSprite.h"

namespace GLTextures 
{
	#pragma mark ---------------------------------------------------------
	#pragma mark Constructor / Destructor
	#pragma mark ---------------------------------------------------------

	// --------------------------------------------------
	// Constructor
	// --------------------------------------------------
	GLTextureSprite::GLTextureSprite(const NSString * _name, GLint _bindID, CGSize _size, NSUInteger _frameCount, CGSize _frameSize)
	:GLTexture(_name, _bindID, _size)
	{	
		// calculate the frame
		m_frameCount = _frameCount;
		
		m_uvMin.reserve(_frameCount);
		m_uvMax.reserve(_frameCount);
		
		if ( _size.width < _frameSize.width )
		{
			_frameSize.width = _size.width;
		}

		if ( _size.height < _frameSize.height )
		{
			_frameSize.height = _size.height;
		}
		
		GLfloat moveX = _frameSize.width / _size.width;
		GLfloat moveY = _frameSize.height / _size.height;
		GLfloat minX = 0.0f;
		GLfloat minY = 0.0f;
		GLfloat maxX = moveX;
		GLfloat maxY = moveY;
		for ( int i=0; i<_frameCount; i++ )
		{
			// do we need to shift down?
			if ( maxX > 1.0f )
			{
				minX = 0.0f;
				maxX = moveX;
				minY += moveY;
				maxY += moveY;
				
				// have we gone off the edge of
				// the texture?
				if ( maxY > 1.0f )
				{
					NSLog(@"Warnning to many frames for sprite size, frames have been cut.");
					_frameCount = i;
					break;
				}
			}
			
			// add the uv cordinates
			m_uvMin.push_back( CGPointMake(minX, minY) );
			m_uvMax.push_back( CGPointMake(maxX, maxY) );
			
			// move to the right of the
			// texture
			minX += moveX;
			maxX += moveX;
			
			m_frameSizes.push_back( _frameSize );
		}
	}

	// --------------------------------------------------
	// Constructor
	// --------------------------------------------------
	GLTextureSprite::GLTextureSprite(const NSString * _name, GLint _bindID, CGSize _size, NSArray * _frames)
	:GLTexture(_name, _bindID, _size)
	{
		// grab the frame count
		m_frameCount = [_frames count] / 4;
		
		GLfloat minX = 0.0f;
		GLfloat minY = 0.0f;
		GLfloat maxX = 0.0f;
		GLfloat maxY = 0.0f;
		CGSize  size = CGSizeZero;
		for ( int i=0; i<[_frames count]; i+=4 )
		{
			minX = [[_frames objectAtIndex:i] floatValue];
			minY = [[_frames objectAtIndex:i+1] floatValue];
			maxX = [[_frames objectAtIndex:i+2] floatValue];
			maxY = [[_frames objectAtIndex:i+3] floatValue];
			
			CGPoint min = CGPointMake(minX / _size.width, minY / _size.height);
			CGPoint max = CGPointMake(maxX / _size.width, maxY / _size.height);
			
			// add the uv cordinates
			m_uvMin.push_back( min );
			m_uvMax.push_back( max );
			
			size = CGSizeMake( maxX - minX, maxY - minY );
			m_frameSizes.push_back( size );
		}
	}

	// --------------------------------------------------
	// Destructor
	// --------------------------------------------------
	GLTextureSprite::~GLTextureSprite()
	{
	}

	#pragma mark ---------------------------------------------------------
	#pragma mark End Constructor / Destructor
	#pragma mark ---------------------------------------------------------

};