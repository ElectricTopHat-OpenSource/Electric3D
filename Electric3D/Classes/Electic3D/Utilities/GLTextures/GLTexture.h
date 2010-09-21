/*
 *  Texture.h
 *  Electric3D
 *
 *  Created by robert on 15/04/2009.
 *  Copyright 2009 Electric TopHat. All rights reserved.
 *
 */

#if !defined(__GLTexture_h__)
#define __GLTexture_h__

#import <UIKit/UIKit.h>
#import <OpenGLES/ES1/gl.h>

namespace GLTextures 
{
	class GLTextureBank;

	// --------------------------------------------------
	// GLTexture Container
	// --------------------------------------------------
	class GLTexture
	{
	#pragma mark ---------------------------------------------------------
	#pragma mark Friend
	#pragma mark ---------------------------------------------------------
		
		friend class GLTextureBank;
		
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
		GLTexture(const NSString * _name, GLint _bindID, CGSize _size);
		
		// --------------------------------------------------
		// Destructor
		// --------------------------------------------------
		~GLTexture();
		
	#pragma mark ---------------------------------------------------------
	#pragma mark End Constructor / Destructor
	#pragma mark ---------------------------------------------------------
		
	#pragma mark ---------------------------------------------------------
	#pragma mark Public Functions
	#pragma mark ---------------------------------------------------------
	public:	// Functions
		
		// name of the underlying texture
		inline const NSString * name() const { return m_name; }
		
		// access the bind name
		inline GLuint bindID() const { return m_bindID; }
		
		// access the size
		inline CGSize size() const { return m_size; }
			
	#pragma mark ---------------------------------------------------------
	#pragma mark End Public Functions
	#pragma mark ---------------------------------------------------------
		
	#pragma mark ---------------------------------------------------------
	#pragma mark Private Functions
	#pragma mark ---------------------------------------------------------
	private: // Functions
		
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
		
		const NSString *		m_name;
		GLuint					m_bindID;
		CGSize					m_size;
		NSInteger				m_referenceCount;

	#pragma mark ---------------------------------------------------------
	#pragma mark End Private Data
	#pragma mark ---------------------------------------------------------
	};
	
};

#endif