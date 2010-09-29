//
//  GLModel.m
//  Electric3D
//
//  Created by Robert McDowell on 22/09/2010.
//  Copyright 2010 Electric TopHat Ltd. All rights reserved.
//

#import "GLModel.h"
#import "GLMesh.h"

namespace GLObjects
{
	
#pragma mark ---------------------------------------------------------
#pragma mark Constructor / Destructor
#pragma mark ---------------------------------------------------------
	
	// --------------------------------------------------
	// Constructor
	// --------------------------------------------------
	GLModel::GLModel( NSString * _name ) 
	: GLObject		(_name) 
	, m_transform	(CGMaths::CGMatrix4x4Identity)
	, m_texture		( nil )
	{
	}
	
	// --------------------------------------------------
	// Destructor
	// --------------------------------------------------
	GLModel::~GLModel()
	{
	}
	
#pragma mark ---------------------------------------------------------
#pragma mark End Constructor / Destructor
#pragma mark ---------------------------------------------------------
	
#pragma mark ---------------------------------------------------------
#pragma mark === Public Functions  ===
#pragma mark ---------------------------------------------------------
	
	
#pragma mark ---------------------------------------------------------
#pragma mark === End Public Functions  ===
#pragma mark ---------------------------------------------------------
	
};