//
//  E3DManagers.mm
//  Electric3D
//
//  Created by Robert McDowell on 28/10/2010.
//  Copyright 2010 Electric TopHat Ltd. All rights reserved.
//

#import "E3DManagers.h"

#import "E3DMeshManager.h"
#import "E3DTextureManager.h"
#import "E3DSpriteManager.h"
#import "E3DSplineManager.h"

namespace E3D
{
#pragma mark ---------------------------------------------------------
#pragma mark Constructor / Destructor
#pragma mark ---------------------------------------------------------
	
	// --------------------------------------------------
	// Constructor
	// --------------------------------------------------
	E3DManagers::E3DManagers()
	{
		// --------------------------------------
		// Create the container objects
		// --------------------------------------
		m_meshManager		= new E3D::E3DMeshManager();
		m_textureManager	= new E3D::E3DTextureManager();
		
		m_spriteManager		= new E3D::E3DSpriteManager( m_textureManager );
		m_splineManager		= new E3D::E3DSplineManager();
		// --------------------------------------
	}
	
	// --------------------------------------------------
	// Destructor
	// --------------------------------------------------
	E3DManagers::~E3DManagers()
	{
		// --------------------------------------
		// Teardown the container classes
		// --------------------------------------
		SAFE_DELETE( m_splineManager	);
		SAFE_DELETE( m_spriteManager	);
		SAFE_DELETE( m_textureManager	);
		SAFE_DELETE( m_meshManager		);
		// --------------------------------------
	}
	
#pragma mark ---------------------------------------------------------
#pragma mark End Constructor / Destructor
#pragma mark ---------------------------------------------------------	
};