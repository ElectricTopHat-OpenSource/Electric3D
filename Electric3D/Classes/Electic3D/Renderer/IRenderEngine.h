/*
 *  IRenderEngine.h
 *  Electric3D
 *
 *  Created by Robert McDowell on 22/09/2010.
 *  Copyright 2010 Electric TopHat Ltd. All rights reserved.
 *
 */


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
	
	virtual void initialize() = 0;
	virtual void teardown() = 0;
	
	virtual void setClearColor( float _red, float _green, float _blue ) = 0;
	
	virtual void Update( float _timeStep ) = 0;
	virtual void Render() = 0;
	virtual void OnRotate( eDeviceOrientation _newOrientation ) = 0;
};

