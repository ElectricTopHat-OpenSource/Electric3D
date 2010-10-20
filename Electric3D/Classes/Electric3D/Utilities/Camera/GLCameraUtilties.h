/*
 *  GLCameraUtilties.h
 *  Electric3D
 *
 *  Created by Robert McDowell on 12/10/2010.
 *  Copyright 2010 Electric TopHat Ltd. All rights reserved.
 *
 */

#if !defined(__GLCameraUtilties_h__)
#define __GLCameraUtilties_h__

#import <OpenGLES/ES1/gl.h>

#import "CGMaths.h"
#import "GLCamera.h"
#import "GLViewport.h"

namespace GLCameras 
{
	inline const CGMaths::CGMatrix4x4 & createProjectionMatrix( const GLCamera & _camera, const GLViewport & _viewport )
	{
		float deltaz  = _camera.far() - _camera.near();
		float aspect  = _viewport.width() / _viewport.height();
		float radians = CGMaths::Degrees2Radians( _camera.fov() / 2.0f );
		float sine = sinf(radians);
		if ( (deltaz != 0) && (sine != 0) && (aspect != 0) ) 
		{
			static CGMaths::CGMatrix4x4 matrix;
			
			float cotangent = cosf(radians) / sine;
			matrix.m[0]  = cotangent / aspect;
			matrix.m[1]	 = 0; 
			matrix.m[2]	 = 0; 
			matrix.m[3]	 = 0;
			matrix.m[4]	 = 0;
			matrix.m[5]  = cotangent;
			matrix.m[6]	 = 0;
			matrix.m[7]	 = 0;
			matrix.m[8]	 = 0;
			matrix.m[9]	 = 0;
			matrix.m[10] = 1;
			matrix.m[11] = 0;
			matrix.m[12] = 0;
			matrix.m[10] = -(_camera.far() + _camera.near()) / deltaz;
			matrix.m[11] = -1;
			matrix.m[12] = 0;
			matrix.m[13] = 0;
			matrix.m[14] = -2 * _camera.near() * _camera.far() / deltaz;
			matrix.m[15] = 0;
			
			return matrix;
		}	
		return CGMaths::CGMatrix4x4Identity;
	}
	
	inline const CGMaths::CGMatrix4x4 & createModelMatrix( const GLCamera & _camera )
	{
		const CGMaths::CGMatrix4x4 & mat = _camera.transform();
		static CGMaths::CGMatrix4x4 rot;
		
		// --------------------------------------
		// copy the right up and at axis ( flip the last )
		// --------------------------------------
		rot.m[0]  = mat.m[0]; 	rot.m[1]  = mat.m[1];	rot.m[2]  = -mat.m[2];	 rot.m[3] = 0.0f;
		rot.m[4]  = mat.m[4];	rot.m[5]  = mat.m[5];	rot.m[6]  = -mat.m[6];	 rot.m[7] = 0.0f;
		rot.m[8]  = mat.m[8];	rot.m[9]  = mat.m[9];	rot.m[10] = -mat.m[10];	 rot.m[11] = 0.0f;
		rot.m[12] = 0.0f;		rot.m[13] = 0.0f;		rot.m[14] = 0.0f;		 rot.m[15] = 1.0f;
		// --------------------------------------
		
		// --------------------------------------
		// Transform the positional information
		// --------------------------------------
		CGMaths::CGVector3D p = CGMaths::CGMatrix4x4TransformVector( rot, -mat.m[12], -mat.m[13], -mat.m[14] );
		// --------------------------------------
		
		// --------------------------------------
		// copy the traslated point into the mat 
		// --------------------------------------
		rot.m[12] = p.x; rot.m[13] = p.y; rot.m[14] = p.z;
		// --------------------------------------
		
		return rot;
	}
	
	// Project a point into the world
	inline CGMaths::CGVector3D worldToScreen( const CGMaths::CGVector3D & _point, const GLCamera & _camera, const GLViewport & _viewport )
	{
		const CGMaths::CGMatrix4x4 & model		= createModelMatrix( _camera );
		const CGMaths::CGMatrix4x4 & projection = createProjectionMatrix( _camera, _viewport );
		
		CGMaths::CGVector4D t0 = CGMaths::CGMatrix4x4TransformVector( model, _point.x, _point.y, _point.z, 1.0f );
		CGMaths::CGVector4D t1 = CGMaths::CGMatrix4x4TransformVector( projection, t0 );
		if ( t1.w != 0.0f )
		{
			t1.x /= t1.w;
			t1.y /= t1.w;
			
			// Map x, y to range 0-1 
			// Map z to the real depth in meters
			// Map x,y to viewport 
			CGMaths::CGVector3D point = CGMaths::CGVector3DMake( ( t1.x * 0.5 + 0.5 ) * _viewport.width() + _viewport.x(),
																 ( t1.y * 0.5 + 0.5 ) * _viewport.height() + _viewport.y(),
																 ( t1.w ) );

			return point;
		}
		return CGMaths::CGVector3DZero;
	}
	
	// the z cordinate specifies the distance into the screen
	inline CGMaths::CGVector3D screenToWorld( const CGMaths::CGVector3D & _point, const GLCamera & _camera, const GLViewport & _viewport )
	{	
		const CGMaths::CGMatrix4x4 & model		= createModelMatrix( _camera );
		const CGMaths::CGMatrix4x4 & projection = createProjectionMatrix( _camera, _viewport );

		CGMaths::CGMatrix4x4 matrix		= CGMaths::CGMatrix4x4MakeMultiply( model, projection );
		if ( CGMaths::CGMatrix4x4Invert( matrix ) )
		{
			float x		= (_point.x - _viewport.x()) / _viewport.width() * 2.0 - 1.0f;
			float y		= (_point.y - _viewport.y()) / _viewport.height() * 2.0 - 1.0f;
			float minz	= ( 2.0f * 0.0f - 1.0f );
			float maxz	= ( 2.0f * 1.0f - 1.0f );
			
			CGMaths::CGVector4D t0 = CGMaths::CGMatrix4x4TransformVector( matrix, x, y, minz, 1.0f );
			CGMaths::CGVector4D t1 = CGMaths::CGMatrix4x4TransformVector( matrix, x, y, maxz, 1.0f );
			
			CGMaths::CGVector3D p0 = CGMaths::CGVector3DMake( t0.x / t0.w, t0.y / t0.w, t0.z / t0.w );
			CGMaths::CGVector3D p1 = CGMaths::CGVector3DMake( t1.x / t1.w, t1.y / t1.w, t1.z / t1.w );
			
			float scale = ( _point.z - _camera.near() ) / ( _camera.far() - _camera.near() );
			CGMaths::CGVector3D point = CGMaths::CGVector3DMakeAdd( p0, CGMaths::CGVector3DMakeScale( CGMaths::CGVector3DMakeSub( p1, p0 ), scale ) );
			
			return point;
		
		}
		return CGMaths::CGVector3DZero;
	}
};

#endif