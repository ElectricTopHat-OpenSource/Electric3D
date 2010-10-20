//
//  E3DSceneNode.m
//  Electric3D
//
//  Created by Robert McDowell on 19/10/2010.
//  Copyright 2010 Electric TopHat Ltd. All rights reserved.
//

#import "E3DSceneNode.h"
#import <algorithm>

namespace E3D  
{
#pragma mark ---------------------------------------------------------
#pragma mark Constructor / Destructor
#pragma mark ---------------------------------------------------------
	
	// --------------------------------------------------
	// Constructor
	// --------------------------------------------------
	E3DSceneNode::E3DSceneNode( NSString * _name )
	: m_name	( [_name copy] )
	, m_hidden	( FALSE )
	{
		static NSUInteger val=0; 
		m_hash=val++;
	}
	
	// --------------------------------------------------
	// Destructor
	// --------------------------------------------------
	E3DSceneNode::~E3DSceneNode()
	{
	}
	
#pragma mark ---------------------------------------------------------
#pragma mark End Constructor / Destructor
#pragma mark ---------------------------------------------------------	

#pragma mark ---------------------------------------------------------
#pragma mark === Public Functions  ===
#pragma mark ---------------------------------------------------------
	
	// --------------------------------------------------
	// Add a child node
	// --------------------------------------------------
	void E3DSceneNode::addChild( E3DSceneNode * _child )
	{
		m_children.push_back( _child );
	}
	
	// --------------------------------------------------
	// Remove a child node
	// --------------------------------------------------
	void E3DSceneNode::removeChild( E3DSceneNode * _child )
	{
		m_children.erase(std::remove(m_children.begin(), m_children.end(), _child), m_children.end());
	}
	
	// --------------------------------------------------
	// Remove all children nodes
	// --------------------------------------------------
	void E3DSceneNode::removeAllChildren()
	{
		m_children.clear();
	}
	
#pragma mark ---------------------------------------------------------
#pragma mark === End Public Functions  ===
#pragma mark ---------------------------------------------------------
	
};
