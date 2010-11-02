//
//  E3DSprite.h
//  Electric3D
//
//  Created by Robert McDowell on 24/09/2010.
//  Copyright 2010 Electric TopHat Ltd. All rights reserved.
//

#if !defined(__E3DSprite_h__)
#define __E3DSprite_h__

#import <vector>

namespace E3D { class E3DTexture; };

namespace E3D 
{
	class E3DSpriteManager;
	
	class E3DSprite
	{
#pragma mark ---------------------------------------------------------
#pragma mark Friend
#pragma mark ---------------------------------------------------------
		
		friend class E3DSpriteManager;
		
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
		E3DSprite(const NSString * _name, const E3D::E3DTexture * _texture, NSUInteger _frameCount, CGSize _frameSize);
		E3DSprite(const NSString * _name, const E3D::E3DTexture * _texture, NSArray * _frames);
		
		// --------------------------------------------------
		// Destructor
		// --------------------------------------------------
		virtual ~E3DSprite();
		
#pragma mark ---------------------------------------------------------
#pragma mark End Constructor / Destructor
#pragma mark ---------------------------------------------------------
		
#pragma mark ---------------------------------------------------------
#pragma mark Public Functions
#pragma mark ---------------------------------------------------------
	public:	// Functions
		
		inline const NSString *					name() const { return [m_name lastPathComponent]; }
		inline NSUInteger						hash() const { return m_hash; };
		
		inline const E3D::E3DTexture *	texture() const { return m_texture; };
		
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
		
		const E3D::E3DTexture *	m_texture;
		
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
