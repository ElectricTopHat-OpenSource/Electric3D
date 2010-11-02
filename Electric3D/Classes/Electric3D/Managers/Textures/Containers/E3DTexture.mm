//
//  E3DTexture.m
//  Electric3D
//
//  Created by Robert McDowell on 24/09/2010.
//  Copyright 2010 Electric TopHat Ltd. All rights reserved.
//

#import "E3DTexture.h"

namespace E3D 
{
#pragma mark ---------------------------------------------------------
#pragma mark Constructor / Destructor
#pragma mark ---------------------------------------------------------
	
	// --------------------------------------------------
	// Constructor
	// --------------------------------------------------
	E3DTexture::E3DTexture(NSString * _name, GLint _bindID, CGSize _size)
	: m_referenceCount	( 1 )
	, m_name			( [_name copy] )
	, m_bindID			( _bindID )
	, m_size			( _size )
	{	
		m_hash = [_name hash];
	}
	
	// --------------------------------------------------
	// Destructor
	// --------------------------------------------------
	E3DTexture::~E3DTexture()
	{
		if ( m_bindID )
		{
			DPrint( @"WARNING : Texture being deleted and may not have been released %@", m_name );
		}
	}
	
#pragma mark ---------------------------------------------------------
#pragma mark End Constructor / Destructor
#pragma mark ---------------------------------------------------------
};
