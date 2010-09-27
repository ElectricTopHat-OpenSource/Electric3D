//
//  GLScene.m
//  Electric3D
//
//  Created by Robert McDowell on 25/09/2010.
//  Copyright 2010 Electric TopHat Ltd. All rights reserved.
//

#import "GLScene.h"
#import "GLObject.h"

namespace GLObjects 
{
#pragma mark ---------------------------------------------------------
#pragma mark Constructor / Destructor
#pragma mark ---------------------------------------------------------
	
	// --------------------------------------------------
	// Constructor
	// --------------------------------------------------
	GLScene::GLScene( NSString * _name )
	{
		m_name = [_name copy]; 
		m_referenceCount=1; 
		static NSUInteger val=0; 
		m_hash=val++; 
	}
	
	// --------------------------------------------------
	// Destructor
	// --------------------------------------------------
	GLScene::~GLScene()
	{
		clear();
	}
	
#pragma mark ---------------------------------------------------------
#pragma mark End Constructor / Destructor
#pragma mark ---------------------------------------------------------
	
#pragma mark ---------------------------------------------------------
#pragma mark === Public Functions  ===
#pragma mark ---------------------------------------------------------
	
	// --------------------------------------------------
	// check to see if the scene contains the object
	// --------------------------------------------------
	BOOL GLScene::contains( const GLObjects::GLObject * _object ) const
	{
		NSUInteger key = _object->hash();
		_SceneListConstIterator lb = m_objects.lower_bound(key);
		return (lb != m_objects.end() && !(m_objects.key_comp()(key, lb->first)));
	}
	
	// --------------------------------------------------
	// add an object into the scene
	// --------------------------------------------------
	void GLScene::add( GLObjects::GLObject * _object )
	{
		if ( !contains( _object ) )
		{
			// We don't have the object add it
			m_objects[_object->hash()] = _object;
		}
	}
	
	// --------------------------------------------------
	// remove an object from the scene
	// --------------------------------------------------
	void GLScene::remove( GLObjects::GLObject * _object )
	{
		NSUInteger key = _object->hash();
		_SceneListIterator lb = m_objects.lower_bound(key);
		if (lb != m_objects.end() && !(m_objects.key_comp()(key, lb->first)))
		{
			// remove the object reference
			// from the map
			m_objects.erase( lb );
		}
	}
	
	// --------------------------------------------------
	// remove all the objects from the scene
	// --------------------------------------------------
	void GLScene::clear()
	{
		m_objects.clear();
	}
	
#pragma mark ---------------------------------------------------------
#pragma mark === End Public Functions  ===
#pragma mark ---------------------------------------------------------
};