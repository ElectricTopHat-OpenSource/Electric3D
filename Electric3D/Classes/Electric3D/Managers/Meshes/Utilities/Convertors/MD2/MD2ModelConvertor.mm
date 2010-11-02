//
//  MD2ModelConvertor.m
//  Electric3D
//
//  Created by Robert McDowell on 23/09/2010.
//  Copyright 2010 Electric TopHat Ltd. All rights reserved.
//

#import "MD2ModelConvertor.h"
#import "MD2Model.h"
#import "CGMaths.h"

namespace MD2
{
	typedef float _vect3_t[3];
	
	// Precomputed normal vector array (162 vectors)
	static const _vect3_t _kAnorms[] = 
	{
	#include "Anorms.h"
	};
	
	BOOL convertFrameUVToVertsUV( const MD2Model * _model, unsigned int _frame, GLInterleavedVert3D * _verts )
	{
		if ( _model->valid() && ( _model->numframes() > _frame ) && ( _model->numverts() ) )
		{
/*
#if MD2_USE_INDEXED_TRIANLGES
			const int *			glCmd		= _model->glcmds();
			
			if ( glCmd ) 
			{
				int i		= 0;
				int step	= 0;
				int count	= glCmd[step];
				while ( count != 0)
				{
					if ( count < 0 )
					{
						// Triangle FAN 
						// so flip the counter els it's a STRIP
						count = -count;
					}
					
					step += 1;
					for ( i=0; i<count; i++ )
					{
						const Md2Glcmd * cmd = (const Md2Glcmd *)&glCmd[step];
						
						// grab the interleaved vertex object
						GLInterleavedVert3D * vert = &_verts[cmd->index];
						
						vert->uv.x = cmd->s;
						vert->uv.y = cmd->t;
						
						NSLog( @"index %d, %f %f", cmd->index, vert->uv.x, vert->uv.y );
						
						step += 3;
					}
					count	= glCmd[step];
				}				
			}
#else*/
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
					int xyzIndex	= triangle->vertex[v];
					int stIndex		= triangle->st[v];
					
					// grab the interleaved vertex object
					GLInterleavedVert3D * vert = &_verts[xyzIndex];
					
					// copy the texture uv cordinates
					vert->uv.x = texCords[stIndex].s / 256.0f;
					vert->uv.y = texCords[stIndex].t / 256.0f;
				}
			}
//#endif
			return true;
		}
		
		return false;
	}
		
	// ---------------------------------------------------------------
	// convert Frame to Verts
	// ---------------------------------------------------------------
	BOOL convertFrameToVerts( const MD2Model * _model, unsigned int _frame, GLInterleavedVert3D * _verts )
	{
		if ( _model->valid() && ( _model->numframes() > _frame ) && ( _model->numverts() ) )
		{
#if MD2_USE_INDEXED_TRIANLGES		//  indexed triangle list ( issue with the texture cordinates )
			
			const Md2Header *	header		= _model->header();
			const Md2Frame *	frame		= _model->frame( _frame );
			
			int numverts	= header->num_vertices;
			
			int i;
			for ( i=0; i<numverts; i++ )
			{
				// grab the interleaved vertex object
				GLInterleavedVert3D * vert = &_verts[i];
				
				// copy the frames vert information
				const Md2Vertex * modelVert = &frame->verts[i];
				vert->vert.x =  (modelVert->v[0] * frame->scale[0] + frame->translate[0]);
				vert->vert.z = -(modelVert->v[1] * frame->scale[1] + frame->translate[1]);
				vert->vert.y =  (modelVert->v[2] * frame->scale[2] + frame->translate[2]);
				
				// copy the normal information
				int normIndex	= modelVert->normalIndex;
				vert->normal.x =  _kAnorms[ normIndex ][0];
				vert->normal.z = -_kAnorms[ normIndex ][1];
				vert->normal.y =  _kAnorms[ normIndex ][2];
				
				// zero the texture uv cordinates
				vert->uv.x = 0.0f;
				vert->uv.y = 0.0f;
				
#if GLInterleavedVert3D_color
				// set the vertex colors
				vert->color.red		= 255;
				vert->color.green	= 255;
				vert->color.blue	= 255;
				vert->color.alpha	= 255;
#endif
			}
			
			return convertFrameUVToVertsUV( _model, _frame, _verts );
#else
			const Md2Header *	header		= _model->header();
			const Md2Triangle * triangles	= _model->triangles();
			const Md2Frame *	frame		= _model->frame( _frame );
			const Md2TexCoord * texCords	= _model->texCoords();
			
			CGMaths::CGMatrix4x4 rot		= CGMaths::CGMatrix4x4MakeRotation( 0, 1, 0, CGMaths::Degrees2Radians(-90.0f) );
			
			// --------------------------------------------
			// this is wrong should really use the glcomands 
			// data but it's difficult to map back to our
			// new verts. What needs to be done is to make
			// them into an indexed vert list at some point
			// or drop support for this format... as it's old
			// --------------------------------------------
			
			int numtris		= header->num_tris;
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
					
					CGMaths::CGVector3D vec = CGMaths::CGMatrix4x4TransformVector( rot, vert->vert.x, vert->vert.y, vert->vert.z );
					vert->vert.x = vec.x;
					vert->vert.y = vec.y;
					vert->vert.z = vec.z;
					
					// copy the normal information
					int normIndex	= modelVert->normalIndex;
					vert->normal.x = _kAnorms[ normIndex ][0];
					vert->normal.z = -_kAnorms[ normIndex ][1];
					vert->normal.y = _kAnorms[ normIndex ][2];
					
					// zero the texture uv cordinates
					vert->uv.x = texCords[stIndex].s / 256.0f;
					vert->uv.y = texCords[stIndex].t / 256.0f;
					
#if GLInterleavedVert3D_color
					// set the vertex colors
					vert->color.red		= 255;
					vert->color.green	= 255;
					vert->color.blue	= 255;
					vert->color.alpha	= 255;
#endif
				}
			}
			
			return true;
#endif
			
		}
		
		return false;
	}

	BOOL convertFrameToVerts( const MD2Model * _model, unsigned int _frame, _GLVert3D * _verts )
	{
		if ( _model->valid() && ( _model->numframes() > _frame ) && ( _model->numverts() ) )
		{
			CGMaths::CGMatrix4x4 rot		= CGMaths::CGMatrix4x4MakeRotation( 0, 1, 0, CGMaths::Degrees2Radians(-90.0f) );
			const Md2Header *	header		= _model->header();
			const Md2Frame *	frame		= _model->frame( _frame );
			
#if MD2_USE_INDEXED_TRIANLGES			
			int i;
			for ( i=0; i<header->num_vertices; i++ )
			{
				// grab the interleaved vertex object
				_GLVert3D * vert = &_verts[i];
				
				// copy the frames vert information
				const Md2Vertex * modelVert = &frame->verts[i];
				vert->vert.x =  (modelVert->v[0] * frame->scale[0] + frame->translate[0]);
				vert->vert.z = -(modelVert->v[1] * frame->scale[1] + frame->translate[1]);
				vert->vert.y =  (modelVert->v[2] * frame->scale[2] + frame->translate[2]);
				
				CGMaths::CGVector3D vec = CGMaths::CGMatrix4x4TransformVector( rot, vert->vert.x, vert->vert.y, vert->vert.z );
				vert->vert.x = vec.x;
				vert->vert.y = vec.y;
				vert->vert.z = vec.z;
			}
#else
			const Md2Triangle * triangles	= _model->triangles();			
			int i, v;
			// loop over the triangles in the model
			for ( i=0; i<header->num_tris; i++ )
			{
				const Md2Triangle * triangle = &triangles[i];
				
				// loop over the triangle and pull out the 
				// vert and normal
				for ( v=0; v<3; v++ )
				{
					int vertIndex	= (i*3) + (2-v);
					int xyzIndex	= triangle->vertex[v];
					
					// grab the interleaved vertex object
					_GLVert3D * vert = &_verts[vertIndex];
					
					// copy the frames vert information
					const Md2Vertex * modelVert = &frame->verts[xyzIndex];
					vert->x =  (modelVert->v[0] * frame->scale[0] + frame->translate[0]);
					vert->z = -(modelVert->v[1] * frame->scale[1] + frame->translate[1]);
					vert->y =  (modelVert->v[2] * frame->scale[2] + frame->translate[2]);
					
					CGMaths::CGVector3D vec = CGMaths::CGMatrix4x4TransformVector( rot, vert->x, vert->y, vert->z );
					vert->x = vec.x;
					vert->y = vec.y;
					vert->z = vec.z;
				}
			}
#endif
			return true;
		}
		
		return false;
	}
	
	BOOL convertToIndices( const MD2Model * _model, unsigned int _frame, GLVertIndice * _indices )
	{
		if ( _indices && _model->valid() && ( _model->numframes() > _frame ) && ( _model->numverts() ) )
		{
			const Md2Header *	header		= _model->header();
			const Md2Triangle * triangles	= _model->triangles();
			
			int numtris  = header->num_tris;
			
			int i, pos = 0;
			for ( i=0; i<numtris; i++ )
			{
				const Md2Triangle * triangle = &triangles[i];
				
				_indices[pos]	= triangle->vertex[2];
				_indices[pos+1] = triangle->vertex[1];
				_indices[pos+2] = triangle->vertex[0];
					
				pos += 3;
			}
			return true;
		}
		return false;
		
	}
};