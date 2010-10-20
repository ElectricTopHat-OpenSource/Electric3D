/*
 *  E3DSplineFactory.h
 *  Electric3D
 *
 *  Created by Robert McDowell on 18/10/2010.
 *  Copyright 2010 Electric TopHat Ltd. All rights reserved.
 *
 */

#if !defined(__E3DSplineFactory_h__)
#define __E3DSplineFactory_h__

#import <map>

namespace E3D { class E3DSpline; };

namespace E3D
{
	class E3DSplineFactory 
	{
#pragma mark ---------------------------------------------------------
#pragma mark Constructor / Destructor
#pragma mark ---------------------------------------------------------
	public: // Functions
		
		E3DSplineFactory();
		virtual ~E3DSplineFactory();
		
#pragma mark ---------------------------------------------------------
#pragma mark End Constructor / Destructor
#pragma mark ---------------------------------------------------------
		
#pragma mark ---------------------------------------------------------
#pragma mark === Public Functions  ===
#pragma mark ---------------------------------------------------------
	public: // Functions
		
		BOOL isLoaded( const NSString * _name, const NSString * _ext, NSBundle * _bundle = nil );
		BOOL isLoaded( const NSString * _filePath );
		
		// load a spline into the bank
		const E3DSpline * load( const NSString * _name, const NSString * _ext, NSBundle * _bundle = nil );
		const E3DSpline * load( const NSString * _filePath );
		
		// release the spline
		void release( const E3DSpline * _spline );
		
		// clear the entire spline bank
		void clear();
		
#pragma mark ---------------------------------------------------------
#pragma mark === End Public Functions  ===
#pragma mark ---------------------------------------------------------
		
#pragma mark ---------------------------------------------------------
#pragma mark === Private Functions  ===
#pragma mark ---------------------------------------------------------
	private: // Functions
		
		E3DSpline * loadplist( const NSString * _filePath );
		E3DSpline * load3DS( const NSString * _filePath );
		
#pragma mark ---------------------------------------------------------
#pragma mark === End Private Functions  ===
#pragma mark ---------------------------------------------------------
		
#pragma mark ---------------------------------------------------------
#pragma mark === Private Data  ===
#pragma mark ---------------------------------------------------------
	private: // Data
		
		NSDictionary *					m_extHash; // extention hash
		
		std::map<NSUInteger,E3DSpline*>	m_splines;
		
#pragma mark ---------------------------------------------------------
#pragma mark === Private Data  ===
#pragma mark ---------------------------------------------------------
	};
	
};

#endif
