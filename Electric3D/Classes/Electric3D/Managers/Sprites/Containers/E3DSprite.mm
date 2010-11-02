//
//  E3DSprite.mm
//  Electric3D
//
//  Created by Robert McDowell on 24/09/2010.
//  Copyright 2010 Electric TopHat Ltd. All rights reserved.
//

#import "E3DSprite.h"
#import "E3DTexture.h"

namespace E3D 
{
#pragma mark ---------------------------------------------------------
#pragma mark Constructor / Destructor
#pragma mark ---------------------------------------------------------
	
	// --------------------------------------------------
	// Constructor
	// --------------------------------------------------
	E3DSprite::E3DSprite(const NSString * _name, const E3D::E3DTexture * _texture, NSUInteger _frameCount, CGSize _frameSize)
	: m_referenceCount	( 1 )
	, m_texture			( _texture )
	, m_name			( _name )
	, m_frameCount		( _frameCount )
	{	
		m_hash = [_name hash];
		
		m_uvMin.reserve(_frameCount);
		m_uvMax.reserve(_frameCount);
		
		CGSize tSize = _texture->size();
		
		if ( tSize.width < _frameSize.width )
		{
			_frameSize.width = tSize.width;
		}
		
		if ( tSize.height < _frameSize.height )
		{
			_frameSize.height = tSize.height;
		}
		
		GLfloat moveX = _frameSize.width / tSize.width;
		GLfloat moveY = _frameSize.height / tSize.height;
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
					DPrint(@"Warnning to many frames for sprite size, frames have been cut.");
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
	E3DSprite::E3DSprite(const NSString * _name, const E3D::E3DTexture * _texture, NSArray * _frames)
	: m_referenceCount	( 1 )
	, m_texture			( _texture )
	, m_name			( _name )
	{
		// grab the frame count
		m_frameCount = [_frames count] / 4;
		
		CGSize tSize = _texture->size();
		
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
			
			CGPoint min = CGPointMake(minX / tSize.width, minY / tSize.height);
			CGPoint max = CGPointMake(maxX / tSize.width, maxY / tSize.height);
			
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
	E3DSprite::~E3DSprite()
	{
		if ( m_texture )
		{
			DPrint( @"WARNING : Texture Sprite being deleted and still refrences texture %@", m_texture->name() );
		}
	}
	
#pragma mark ---------------------------------------------------------
#pragma mark End Constructor / Destructor
#pragma mark ---------------------------------------------------------
	
};
