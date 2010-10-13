/*
 *  IRenderEngine.h
 *  Electric3D
 *
 *  Created by Robert McDowell on 22/09/2010.
 *  Copyright 2010 Electric TopHat Ltd. All rights reserved.
 *
 */

#if !defined(__IRenderEngine_h__)
#define __IRenderEngine_h__

#import "CGMaths.h"

namespace GLCameras { class GLCamera; };
namespace GLCameras { class GLViewport; };
namespace GLObjects { class GLScene; };

namespace GLRenderers 
{

	// Physical orientation of a handheld device,
	// independent equivalent to UIDeviceOrientation
	typedef enum
	{
		eDeviceOrientationUnknown,
		eDeviceOrientationPortrait,
		eDeviceOrientationPortraitUpsideDown,
		eDeviceOrientationLandscapeLeft,
		eDeviceOrientationLandscapeRight,
		eDeviceOrientationFaceUp,
		eDeviceOrientationFaceDown,
		
	} eDeviceOrientation;
	
	class IRenderEngine
	{
	public:
		virtual ~IRenderEngine() {};
		
		virtual void createRenderBuffer() = 0;
		virtual void createFrameBuffer() = 0;
		virtual void createDepthBuffer() = 0;
		
		virtual void destroyRenderBuffer() = 0;
		virtual void destroyFrameBuffer() = 0;
		virtual void destroyDepthBuffer() = 0;
		
		virtual void rebindBuffers() = 0;
		
		virtual void initialize() = 0;
		virtual void teardown() = 0;
		
		virtual void setClearColor( float _red, float _green, float _blue ) = 0;
		
		virtual void update( float _timeStep ) = 0;
		virtual void render() = 0;
		virtual void onRotate( eDeviceOrientation _newOrientation ) = 0;
		
		virtual GLCameras::GLCamera & camera() = 0;
		virtual GLCameras::GLViewport & viewport() = 0;
		
		virtual BOOL contains( GLObjects::GLScene * _scene ) = 0;
		virtual void add( GLObjects::GLScene * _scene ) = 0;
		virtual void remove( GLObjects::GLScene * _scene ) = 0;
	};
	
};

#endif 