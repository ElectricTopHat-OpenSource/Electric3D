//
//  MD2ModelConvertor.m
//  Electric3D
//
//  Created by Robert McDowell on 23/09/2010.
//  Copyright 2010 Electric TopHat Ltd. All rights reserved.
//

#import "MD2ModelConvertor.h"
#import "MD2Model.h"

namespace MD2
{
	// Precomputed normal vector array (162 vectors)
	static const vec3_t _kAnorms[] = 
	{
	#include "Anorms.h"
	};
		
	// ---------------------------------------------------------------
	// convert Frame to Verts
	// ---------------------------------------------------------------
	BOOL convertFrameToVerts( const MD2Model * _model, unsigned int _frame, GLInterleavedVert3D * _verts )
	{
		if ( _model->valid() && ( _model->numframes() > _frame ) && ( _model->numverts() ) )
		{
			const Md2Header *	header		= _model->header();
			const Md2Triangle * triangles	= _model->triangles();
			const Md2Frame *	frame		= _model->frame( _frame );
			const Md2TexCoord * texCords	= _model->texCoords();
			
			int numtris  = header->num_tris;
			
			int i, v;
			// loop over the triangles in the model
			for ( i=0; i<numtris; i++ )
			{
				const Md2Triangle * triangle = &triangles[i];
				
				// loop over the triangle and pull out the 
				// vert and normal
				for ( v=0; v<3; v++ )
				{
					int vertIndex	= (i*3) + (2-v);
					int xyzIndex	= triangle->vertex[v];
					int stIndex		= triangle->st[v];
					
					// grab the interleaved vertex object
					GLInterleavedVert3D * vert = &_verts[vertIndex];
					
					// copy the frames vert information
					const Md2Vertex * modelVert = &frame->verts[xyzIndex];
					vert->vert.x =  (modelVert->v[0] * frame->scale[0] + frame->translate[0]);
					vert->vert.z = -(modelVert->v[1] * frame->scale[1] + frame->translate[1]);
					vert->vert.y =  (modelVert->v[2] * frame->scale[2] + frame->translate[2]);
					
					
					// copy the normal information
					int normIndex	= modelVert->normalIndex;
					vert->normal.x = _kAnorms[ normIndex ][0];
					vert->normal.z = -_kAnorms[ normIndex ][1];
					vert->normal.y = _kAnorms[ normIndex ][2];
					
					// copy the texture uv cordinates
					vert->uv.x = texCords[stIndex].s / 256.0f;
					vert->uv.y = texCords[stIndex].t / 256.0f;
					
#if GLInterleavedVert3D_color
					// set the vertex colors
					vert->color.red		= 0;
					vert->color.green	= 0;
					vert->color.blue	= 0;
					vert->color.alpha	= 255;
#endif
				}
			}
			
			return true;
		}
		
		return false;
	}
	
	BOOL convertFrameUVToVertsUV( const MD2Model * _model, unsigned int _frame, GLInterleavedVert3D * _verts )
	{
		if ( _model->valid() && ( _model->numframes() > _frame ) && ( _model->numverts() ) )
		{
			const Md2Header *	header		= _model->header();
			const Md2Triangle * triangles	= _model->triangles();
			const Md2TexCoord * texCords	= _model->texCoords();
			
			int numtris  = header->num_tris;
			
			int i, v;
			// loop over the triangles in the model
			for ( i=0; i<numtris; i++ )
			{
				const Md2Triangle * triangle = &triangles[i];
				
				// loop over the triangle and pull out the 
				// vert and normal
				for ( v=0; v<3; v++ )
				{
					int vertIndex	= (i*3) + (2-v);
					int stIndex		= triangle->st[v];
					
					// grab the interleaved vertex object
					GLInterleavedVert3D * vert = &_verts[vertIndex];
					
					// copy the texture uv cordinates
					vert->uv.x = texCords[stIndex].s / header->skinwidth;
					vert->uv.y = texCords[stIndex].t / header->skinheight;
				}
			}
			
			return true;
		}
		
		return false;
	}

	BOOL convertFrameToVerts( const MD2Model * _model, unsigned int _frame, GLInterleavedVertNormal3D * _verts )
	{
		if ( _model->valid() && ( _model->numframes() > _frame ) && ( _model->numverts() ) )
		{
			const Md2Header *	header		= _model->header();
			const Md2Triangle * triangles	= _model->triangles();
			const Md2Frame *	frame		= _model->frame( _frame );
			
			int numtris  = header->num_tris;
			
			int i, v;
			// loop over the triangles in the model
			for ( i=0; i<numtris; i++ )
			{
				const Md2Triangle * triangle = &triangles[i];
				
				// loop over the triangle and pull out the 
				// vert and normal
				for ( v=0; v<3; v++ )
				{
					int vertIndex	= (i*3) + (2-v);
					int xyzIndex	= triangle->vertex[v];
					
					// grab the interleaved vertex object
					GLInterleavedVertNormal3D * vert = &_verts[vertIndex];
					
					// copy the frames vert information
					const Md2Vertex * modelVert = &frame->verts[xyzIndex];
					vert->vert.x =  (modelVert->v[0] * frame->scale[0] + frame->translate[0]);
					vert->vert.z = -(modelVert->v[1] * frame->scale[1] + frame->translate[1]);
					vert->vert.y =  (modelVert->v[2] * frame->scale[2] + frame->translate[2]);
					
					// copy the normal information
					int normIndex	= modelVert->normalIndex;
					vert->normal.x = _kAnorms[ normIndex ][0];
					vert->normal.z = -_kAnorms[ normIndex ][1];
					vert->normal.y = _kAnorms[ normIndex ][2];
				}
			}
			
			return true;
		}
		
		return false;
	}
};