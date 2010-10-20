//
//  PVRPODScene.h
//  Electric3D
//
//  Created by Robert McDowell on 04/10/2010.
//  Copyright 2010 Electric TopHat Ltd. All rights reserved.
//

#ifndef __PVRPODScene_H__
#define __PVRPODScene_H__	

#import "PVRPODTypes.h"

namespace PVRPOD 
{
	
	class PVRPODScene 
	{
	public: // Functions
		
		PVRPODScene(NSData * _data = nil);
		PVRPODScene(const void * data, int len);
		~PVRPODScene();
		
	public: // Functions
		
		inline BOOL valid() const { return m_data != 0; };
		
		BOOL isUsingIndexedTriangles() const;
		
		void invalidate();
		
		BOOL set( NSData * _data );
		BOOL set( const void * _data, int _len );
		
		const PODScene * scene() const { return &m_scene; };
		
	private: // Functions
		
		void * mpool( unsigned int _size );
		void * mpoolcpy( unsigned int _size, const void * _data );
		
		BOOL fill( const void * _data, int _len );
		BOOL read_SCENE( const unsigned char * _data, int _len );
		
		int read_CAMERA( const unsigned char * _data, int _len, PODCamera * _cam );
		int read_LIGHT( const unsigned char * _data, int _len, PODLight * _light );
		int read_MATERIAL( const unsigned char * _data, int _len, PODMaterial * _material );
		int read_MESH( const unsigned char * _data, int _len, PODMesh * _mesh );
		int read_NODE( const unsigned char * _data, int _len, PODNode * _node );
		int read_TEXTURE( const unsigned char * _data, int _len, PODTexture * _texture );
		
		int read_PODData( const unsigned char * _data, int _len, ePODFileName _spec, bool _validData, PODData * _data );
		
	private: // Data
		NSData *					m_data;
		NSInteger					m_offset;
		PODScene					m_scene;
	};
	
};

#endif

