//
//  GLSprite.h
//  Electric3D
//
//  Created by Robert McDowell on 24/09/2010.
//  Copyright 2010 Electric TopHat Ltd. All rights reserved.
//

#if !defined(__GLSprite_h__)
#define __GLSprite_h__

#import <vector>

namespace GLTextures { class GLTexture; };

namespace GLSprites 
{
	class GLSpriteFactory;
	
	class GLSprite
	{
#pragma mark ---------------------------------------------------------
#pragma mark Friend
#pragma mark ---------------------------------------------------------
		
		friend class GLSpriteFactory;
		
#pragma mark ---------------------------------------------------------
#pragma mark End Friend
#pragma mark ---------------------------------------------------------
		
#pragma mark ---------------------------------------------------------
#pragma mark Constructor / Destructor
#pragma mark ---------------------------------------------------------
	public: // Functions
		
		// --------------------------------------------------
		// Constructor
		// --------------------------------------------------
		GLSprite(const NSString * _name, const GLTextures::GLTexture * _texture, NSUInteger _frameCount, CGSize _frameSize);
		GLSprite(const NSString * _name, const GLTextures::GLTexture * _texture, NSArray * _frames);
		
		// --------------------------------------------------
		// Destructor
		// --------------------------------------------------
		virtual ~GLSprite();
		
#pragma mark ---------------------------------------------------------
#pragma mark End Constructor / Destructor
#pragma mark ---------------------------------------------------------
		
#pragma mark ---------------------------------------------------------
#pragma mark Public Functions
#pragma mark ---------------------------------------------------------
	public:	// Functions
		
		inline const NSString *					name() const { return [m_name lastPathComponent]; }
		inline NSUInteger						hash() const { return m_hash; };
		
		inline const GLTextures::GLTexture *	texture() const { return m_texture; };
		
		inline NSUInteger						numframes() const { return m_frameCount; }
		
		inline CGSize							frameSize( NSUInteger _frame ) const { return m_frameSizes[_frame]; };
		
		inline const CGPoint &					uvMin( NSUInteger _frame ) const { return m_uvMin[_frame]; };
		inline const CGPoint &					uvMax( NSUInteger _frame ) const { return m_uvMax[_frame]; };
		
#pragma mark ---------------------------------------------------------
#pragma mark End Public Functions
#pragma mark ---------------------------------------------------------
		
#pragma mark ---------------------------------------------------------
#pragma mark Private Functions
#pragma mark ---------------------------------------------------------
	private:
		inline void	textureRemoved() { m_texture == 0; };
		
		inline NSInteger referenceCount() const { return m_referenceCount; };
		inline void incrementReferenceCount() { m_referenceCount++; };
		inline void decrementReferenceCount() { m_referenceCount--; };

#pragma mark ---------------------------------------------------------
#pragma mark End Private Functions
#pragma mark ---------------------------------------------------------
		
#pragma mark ---------------------------------------------------------
#pragma mark Private Data
#pragma mark ---------------------------------------------------------
	protected: // Data
		
		const GLTextures::GLTexture *	m_texture;
		
		NSString *						m_name;
		NSUInteger						m_hash;
		
		NSUInteger						m_frameCount;
		NSInteger						m_referenceCount;
		
		std::vector<CGPoint>			m_uvMin;
		std::vector<CGPoint>			m_uvMax;
		std::vector<CGSize>				m_frameSizes;
		
#pragma mark ---------------------------------------------------------
#pragma mark End Private Data
#pragma mark ---------------------------------------------------------
	};
	
};

#endif
