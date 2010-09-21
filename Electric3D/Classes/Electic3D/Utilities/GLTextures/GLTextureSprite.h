/*
 *  GLTextureSprite.h
 *  Electric3D
 *
 *  Created by robert on 17/04/2009.
 *  Copyright 2009 Electric TopHat. All rights reserved.
 *
 */

#if !defined(__GLTextureSprite_h__)
#define __GLTextureSprite_h__

#import "GLTexture.h"
#import <vector>

namespace GLTextures 
{
	class GLTextureSprite : public GLTexture
	{
	#pragma mark ---------------------------------------------------------
	#pragma mark Constructor / Destructor
	#pragma mark ---------------------------------------------------------
	public: // Functions
			
		// --------------------------------------------------
		// Constructor
		// --------------------------------------------------
		GLTextureSprite(const NSString * _name, GLint _bindID, CGSize _size, NSUInteger _frameCount, CGSize _frameSize);
		GLTextureSprite(const NSString * _name, GLint _bindID, CGSize _size, NSArray * _frames);
		
		// --------------------------------------------------
		// Destructor
		// --------------------------------------------------
		~GLTextureSprite();
		
	#pragma mark ---------------------------------------------------------
	#pragma mark End Constructor / Destructor
	#pragma mark ---------------------------------------------------------
		
	#pragma mark ---------------------------------------------------------
	#pragma mark Public Functions
	#pragma mark ---------------------------------------------------------
	public:	// Functions
		
		// access the frame count
		inline NSUInteger frameCount() const { return m_frameCount; }
		
		// access the size of a single frame
		inline CGSize frameSize( NSUInteger _frame ) const { return m_frameSizes[_frame]; };
		
		// uv coordinates
		inline const CGPoint & uvMin( NSUInteger _frame ) const { return m_uvMin[_frame]; };
		inline const CGPoint & uvMax( NSUInteger _frame ) const { return m_uvMax[_frame]; };
		
	#pragma mark ---------------------------------------------------------
	#pragma mark End Public Functions
	#pragma mark ---------------------------------------------------------
		
	#pragma mark ---------------------------------------------------------
	#pragma mark Private Functions
	#pragma mark ---------------------------------------------------------
	private: // Functions
		
	#pragma mark ---------------------------------------------------------
	#pragma mark End Private Functions
	#pragma mark ---------------------------------------------------------
		
	#pragma mark ---------------------------------------------------------
	#pragma mark Private Data
	#pragma mark ---------------------------------------------------------
	protected: // Data
		
		NSUInteger		m_frameCount;
		
		std::vector<CGPoint> m_uvMin;
		std::vector<CGPoint> m_uvMax;
		std::vector<CGSize>  m_frameSizes;
		
	#pragma mark ---------------------------------------------------------
	#pragma mark End Private Data
	#pragma mark ---------------------------------------------------------
	};
	
};

#endif