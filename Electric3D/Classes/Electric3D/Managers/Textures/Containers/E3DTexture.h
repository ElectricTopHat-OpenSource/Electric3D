//
//  E3DTexture.h
//  Electric3D
//
//  Created by Robert McDowell on 24/09/2010.
//  Copyright 2010 Electric TopHat Ltd. All rights reserved.
//

#if !defined(__E3DTexture_h__)
#define __E3DTexture_h__

#import <OpenGLES/ES2/gl.h>

namespace E3D { class E3DTextureManager; };

namespace E3D 
{
	class E3DTexture
	{	
#pragma mark ---------------------------------------------------------
#pragma mark Friend
#pragma mark ---------------------------------------------------------
		
		friend class E3DTextureManager;
		
#pragma mark ---------------------------------------------------------
#pragma mark End Friend
#pragma mark ---------------------------------------------------------
		
#pragma mark ---------------------------------------------------------
#pragma mark Constructor / Destructor
#pragma mark ---------------------------------------------------------
	private: // Functions
		
		// --------------------------------------------------
		// Constructor
		// --------------------------------------------------
		E3DTexture(NSString * _name, GLint _bindID, CGSize _size);
		
		// --------------------------------------------------
		// Destructor
		// --------------------------------------------------
		virtual ~E3DTexture();
		
#pragma mark ---------------------------------------------------------
#pragma mark End Constructor / Destructor
#pragma mark ---------------------------------------------------------
		
#pragma mark ---------------------------------------------------------
#pragma mark Public Functions
#pragma mark ---------------------------------------------------------
	public:	// Functions
				
		inline const NSString * name() const { return [m_name lastPathComponent]; }
		inline NSUInteger		hash() const { return [m_name hash]; };
		
		inline GLuint bindID() const { return m_bindID; }
		
		inline CGSize size() const { return m_size; }
		
#pragma mark ---------------------------------------------------------
#pragma mark End Public Functions
#pragma mark ---------------------------------------------------------
		
#pragma mark ---------------------------------------------------------
#pragma mark Private Functions
#pragma mark ---------------------------------------------------------
	private:		
		inline void	textureRemoved() { m_bindID == 0; };
		
		inline NSInteger referenceCount() const { return m_referenceCount; };
		inline void incrementReferenceCount() { m_referenceCount++; };
		inline void decrementReferenceCount() { m_referenceCount--; };
		
#pragma mark ---------------------------------------------------------
#pragma mark End Private Functions
#pragma mark ---------------------------------------------------------
		
#pragma mark ---------------------------------------------------------
#pragma mark Private Data
#pragma mark ---------------------------------------------------------
	private: // Data
		
		NSString *				m_name;
		NSUInteger				m_hash;
		GLuint					m_bindID;
		CGSize					m_size;
		NSInteger				m_referenceCount;
		
#pragma mark ---------------------------------------------------------
#pragma mark End Private Data
#pragma mark ---------------------------------------------------------
	};
};

#endif
