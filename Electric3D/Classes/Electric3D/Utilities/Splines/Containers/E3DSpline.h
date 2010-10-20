/*
 *  E3DSpline.h
 *  Electric3D
 *
 *  Created by Robert McDowell on 18/10/2010.
 *  Copyright 2010 Electric TopHat Ltd. All rights reserved.
 *
 */

#if !defined(__E3DSpline_h__)
#define __E3DSpline_h__

#import "E3DSplineTypes.h"
#import "CGMaths.h"

namespace E3D { class E3DSplineFactory; };

namespace E3D 
{	
	class E3DSpline 
	{
#pragma mark ---------------------------------------------------------
#pragma mark Friend
#pragma mark ---------------------------------------------------------
		
		friend class E3DSplineFactory;
		
#pragma mark ---------------------------------------------------------
#pragma mark End Friend
#pragma mark ---------------------------------------------------------
		
#pragma mark ---------------------------------------------------------
#pragma mark Constructor / Destructor
#pragma mark ---------------------------------------------------------
	public: // Functions
		
		E3DSpline( NSString * _name ) 
		{ 
			m_name = [_name copy]; 
			m_hash = [m_name hash]; 
			m_referenceCount=1; 
			m_aabb = CGMaths::CGAABBInvalid;
		};
		virtual ~E3DSpline() {};
		
#pragma mark ---------------------------------------------------------
#pragma mark End Constructor / Destructor
#pragma mark ---------------------------------------------------------
		
#pragma mark ---------------------------------------------------------
#pragma mark === Public Functions  ===
#pragma mark ---------------------------------------------------------
	public: // Functions
		
		virtual eE3DSplineType type() const = 0;
		
		inline const NSString *				name() const { return [m_name lastPathComponent]; };
		inline const NSUInteger				hash() const { return m_hash; };
		inline const CGMaths::CGAABB &		aabb() const { return m_aabb; };
		
		// add a point to the spline
		virtual BOOL add( float _x, float _y, float _z ) = 0;
		virtual BOOL add( const CGMaths::CGVector3D & _point ) = 0;
		virtual BOOL add( const CGMaths::CGVector3D * _point, NSInteger _count ) = 0;
		
		// get a point in the spline
		virtual const CGMaths::CGVector3D & getPoint( NSUInteger _index ) const = 0;
		
		// update a point in the spline
		virtual void updatePoint( NSUInteger _index, const CGMaths::CGVector3D & _point ) = 0;
		
		// get the number of points in the spline
		virtual NSUInteger count() = 0;
		virtual NSUInteger capacity() = 0;
		
		// clear the entire spline points
		virtual void clear() = 0;
		
		// interpolate the point on the spline
		virtual CGMaths::CGVector3D interpolate( float _interp ) const = 0;
		
#pragma mark ---------------------------------------------------------
#pragma mark === End Public Functions  ===
#pragma mark ---------------------------------------------------------

#pragma mark ---------------------------------------------------------
#pragma mark Protected Functions
#pragma mark ---------------------------------------------------------
	protected: // Functions

		// calculate the splines aabb
		void calculateAABB()
		{
			m_aabb = CGMaths::CGAABBInvalid;
			int i;
			for ( i=0; i<count(); i++ )
			{
				CGMaths::CGAABBAddPoint( m_aabb, getPoint( i ) );
			}
		}
		
#pragma mark ---------------------------------------------------------
#pragma mark End Protected Functions
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
#pragma mark Protected Data
#pragma mark ---------------------------------------------------------
	protected:
		CGMaths::CGAABB	m_aabb;

#pragma mark ---------------------------------------------------------
#pragma mark End Protected Data
#pragma mark ---------------------------------------------------------
		
#pragma mark ---------------------------------------------------------
#pragma mark Private Data
#pragma mark ---------------------------------------------------------
	private: // Data
		
		NSString *		m_name;
		NSUInteger		m_hash;
		NSInteger		m_referenceCount;
		
#pragma mark ---------------------------------------------------------
#pragma mark End Private Data
#pragma mark ---------------------------------------------------------
	};
};

#endif