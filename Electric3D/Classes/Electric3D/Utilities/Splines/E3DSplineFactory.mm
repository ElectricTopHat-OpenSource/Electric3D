/*
 *  E3DSplineFactory.mm
 *  Electric3D
 *
 *  Created by Robert McDowell on 18/10/2010.
 *  Copyright 2010 Electric TopHat Ltd. All rights reserved.
 *
 */

#include "E3DSplineFactory.h"

#include "E3DSplineHermite.h"

#pragma mark ---------------------------------------------------------

#pragma mark MAX3DSScene
#import "MAX3DSScene.h"
#pragma mark End MAX3DSScene

#pragma mark ---------------------------------------------------------

namespace E3D
{
#pragma mark ---------------------------------------------------------
#pragma mark Internal Consts 
#pragma mark ---------------------------------------------------------
	
	typedef enum 
	{
		eSplineFileExt_plist = 0,
		eSplineFileExt_3DS,
		
	} eSplineFileExt;
	
#pragma mark ---------------------------------------------------------
#pragma mark End Internal Consts 
#pragma mark ---------------------------------------------------------
	
#pragma mark ---------------------------------------------------------
#pragma mark Constructor / Destructor
#pragma mark ---------------------------------------------------------
	
	// --------------------------------------------------
	// Constructor
	// --------------------------------------------------
	E3DSplineFactory::E3DSplineFactory()
	{
		m_extHash = [[NSDictionary alloc] initWithObjectsAndKeys:
					 [NSNumber numberWithInt:eSplineFileExt_plist], @"plist",
					 [NSNumber numberWithInt:eSplineFileExt_3DS], @"3ds",
					 nil];
	}
	
	// --------------------------------------------------
	// Destructor
	// --------------------------------------------------
	E3DSplineFactory::~E3DSplineFactory()
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
	// is the spline loaded
	// --------------------------------------------------
	BOOL E3DSplineFactory::isLoaded( const NSString * _name, const NSString * _ext, NSBundle * _bundle )
	{
		NSBundle * bundle	= ( _bundle ) ? _bundle : [NSBundle mainBundle];
		NSString * path		= [bundle pathForResource:_name ofType:_ext];
		if ( path )
		{
			return isLoaded( path );
		}
		return nil;
	}
	
	// --------------------------------------------------
	// is the spline loaded
	// --------------------------------------------------
	BOOL E3DSplineFactory::isLoaded( const NSString * _filePath )
	{
		std::map<NSUInteger,E3DSpline*>::iterator lb = m_splines.lower_bound(_filePath.hash);
		if (lb != m_splines.end() && !(m_splines.key_comp()(_filePath.hash, lb->first)))
		{
			return true;
		}
		return false;
	}
	
	// --------------------------------------------------
	// load a spline
	// --------------------------------------------------
	const E3DSpline * E3DSplineFactory::load( const NSString * _name, const NSString * _ext, NSBundle * _bundle )
	{
		NSBundle * bundle	= ( _bundle ) ? _bundle : [NSBundle mainBundle];
		NSString * path		= [bundle pathForResource:_name ofType:_ext];
		if ( path )
		{
			return load( path );
		}
		return nil;
	}
	
	// --------------------------------------------------
	// load a mesh
	// --------------------------------------------------
	const E3DSpline * E3DSplineFactory::load( const NSString * _filePath )
	{
		E3DSpline * spline = nil;
		
		std::map<NSUInteger,E3DSpline*>::iterator lb = m_splines.lower_bound(_filePath.hash);
		if (lb != m_splines.end() && !(m_splines.key_comp()(_filePath.hash, lb->first)))
		{
			spline = lb->second;
			spline->incrementReferenceCount();
		}
		else // Load the texture and convert it.
		{
			NSString * ext = [[_filePath pathExtension] lowercaseString];
			switch ([[m_extHash objectForKey:ext] intValue]) 
			{
				case eSplineFileExt_plist:
				{
					spline = loadplist( _filePath );
					break;
				}
				case eSplineFileExt_3DS:
				{
					spline = load3DS( _filePath );
					break;
				}
				default:
					DPrint( @"ERROR : Failed to load spline file %@ as the file format is not supported.", _filePath );
					break;
			}
			
			if ( spline )
			{
				m_splines[spline->hash()] = spline;
			}
		}
		
		return spline;
	}
	
	// --------------------------------------------------
	// release a mesh
	// --------------------------------------------------
	void E3DSplineFactory::release( const E3DSpline * _spline )
	{
		if ( _spline )
		{
			NSUInteger key = _spline->hash();
			std::map<NSUInteger,E3DSpline*>::iterator lb = m_splines.lower_bound(key);
			if (lb != m_splines.end() && !(m_splines.key_comp()(key, lb->first)))
			{
				E3DSpline * spline = lb->second;
				spline->decrementReferenceCount();
				
				if ( spline->referenceCount() <= 0 )
				{	
					// remove the object reference
					// from the map
					m_splines.erase( lb );			
					
					// delete the object
					delete( spline );
				}
			}
		}
	}
	
	// --------------------------------------------------
	// clear all the meshes
	// --------------------------------------------------
	void E3DSplineFactory::clear()
	{
		std::map<NSUInteger,E3DSpline*>::iterator objt;
		for (objt = m_splines.begin(); objt != m_splines.end(); ++objt) 
		{
			E3DSpline * spline = objt->second;
			delete( spline );
		}
		// remove all the dead pointers
		m_splines.clear();
	}
	
#pragma mark ---------------------------------------------------------
#pragma mark === End Public Functions  ===
#pragma mark ---------------------------------------------------------
	
#pragma mark ---------------------------------------------------------
#pragma mark === Private Functions  ===
#pragma mark ---------------------------------------------------------
	
	// --------------------------------------------------
	// load an spline from a plist
	// --------------------------------------------------
	E3DSpline * E3DSplineFactory::loadplist( const NSString * _filePath )
	{
		NSArray * file = [NSArray arrayWithContentsOfFile:_filePath];
		if ( file && [file count] )
		{
			E3DSplineHermite * spline = new E3DSplineHermite(_filePath, [file count]);
			
			CGMaths::CGVector3D point;
			for ( NSDictionary * data in file )
			{
				point.x = [[data objectForKey:@"x"] floatValue];
				point.y = [[data objectForKey:@"y"] floatValue];
				point.z = [[data objectForKey:@"z"] floatValue];
				
				spline->add( point );
			}
			
			return spline;
		}
		return nil;
	}
	
	// --------------------------------------------------
	// load a spline from a 3DS model
	// --------------------------------------------------
	E3DSpline * E3DSplineFactory::load3DS( const NSString * _filePath )
	{
		NSFileHandle * file = [NSFileHandle fileHandleForReadingAtPath:_filePath];
		if ( file )
		{
			NSData * data = [file readDataToEndOfFile];
			
			//NSLog( @"load3DS file of size %d", [data length] );
			
			MAX3DS::MAX3DSScene model( data );
			
			if ( model.valid() && model.count() )
			{
				const MAX3DS::MAX3DS_OBJECT * mesh = model.objectAtIndex(0);
				
				if ( mesh && mesh->header.numVerts > 1 )
				{
					NSUInteger numVerts = mesh->header.numVerts;
					E3DSplineHermite * spline = new E3DSplineHermite(_filePath, numVerts);
				
					CGMaths::CGVector3D point;
					int i;
					for ( i=0; i<numVerts; i++ )
					{
						// translate from max to our cordinates
						// MAX is z is up and y is into the screen
						point.x = mesh->verts[i].x;
						point.y = mesh->verts[i].y;
						point.z = mesh->verts[i].z;
						
						spline->add( point.x, point.z, -point.y );
					}
				
					return spline;
				}
			}
		}
		
		return nil;
	}
	
#pragma mark ---------------------------------------------------------
#pragma mark === End Private Functions  ===
#pragma mark ---------------------------------------------------------
};