//
//  E3DScene.m
//  Electric3D
//
//  Created by Robert McDowell on 19/10/2010.
//  Copyright 2010 Electric TopHat Ltd. All rights reserved.
//

#import "E3DScene.h"

namespace E3D  
{
#pragma mark ---------------------------------------------------------
#pragma mark Constructor / Destructor
#pragma mark ---------------------------------------------------------
	
	// --------------------------------------------------
	// Constructor
	// --------------------------------------------------
	E3DScene::E3DScene( NSString * _name, eE3DSceneType _type )
	: m_root	( _name )
	, m_camera	( _name )
	{
		// -----------------------------
		// set up the scene header
		// -----------------------------
		m_header.type		= _type;
		m_header.numcameras	= 0;
		m_header.numlights	= 0;
		// -----------------------------
		
		// -----------------------------
		// set the root nodes scene
		// -----------------------------
		m_root.m_scene = this;
		// -----------------------------
	}
	
	// --------------------------------------------------
	// Destructor
	// --------------------------------------------------
	E3DScene::~E3DScene()
	{
	}
	
#pragma mark ---------------------------------------------------------
#pragma mark End Constructor / Destructor
#pragma mark ---------------------------------------------------------	
};
