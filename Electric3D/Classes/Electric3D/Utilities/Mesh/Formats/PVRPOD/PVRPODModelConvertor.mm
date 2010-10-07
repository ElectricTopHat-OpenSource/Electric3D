//
//  PVRPODModelConvertor.m
//  Electric3D
//
//  Created by Robert McDowell on 04/10/2010.
//  Copyright 2010 Electric TopHat Ltd. All rights reserved.
//

#import "PVRPODModelConvertor.h"


namespace PVRPOD
{
	BOOL convertToVerts( const PODMesh * _model, GLInterleavedVert3D * _verts )
	{
		if ( ( _model ) && 
			( _model->numVertices ) )
		{
			if ( _model->numUVW )
			{
				//const PODData * mfaces		= &_model->faces;
				const PODData * mverts		= &_model->vertices;
				const PODData * mnormals	= &_model->normals;
				const PODData * mvertColor	= &_model->vtxColours;
				const PODData * mUVW		= &_model->UVWs[0];
				
				if ( mverts->numVertexes == 3 )
				{
					//unsigned char * mfacesdata	= mfaces->data;
					unsigned char * mvertsdata	= nil;
					unsigned char * mnormaldata = nil;
					unsigned char * mcolordata	= nil;
					unsigned char * muvwdata	= nil;
					
					int vertpos = 0;
					int normpos = 0;
					int colpos  = 0;
					int uvwpos	= 0;
					
					if ( _model->interleaved )
					{
						vertpos = (int)mverts->data;
						normpos = (int)mnormals->data;
						colpos  = (int)mvertColor->data;
						uvwpos	= (int)mUVW->data;
						
						mvertsdata	= _model->interleaved;
						mnormaldata	= _model->interleaved;
						mcolordata	= _model->interleaved;
						muvwdata	= _model->interleaved;
					}
					else // not interleaved data 
					{
						mvertsdata	= mverts->data;
						mnormaldata	= mnormals->data;
						mcolordata	= mvertColor->data;
						muvwdata	= mUVW->data;
					}
					
					const NSInteger	numVerts			= _model->numVertices;
					
					int i;
					for ( i=0; i<numVerts; i++ )
					{	
						// grab the interleaved vertex object
						GLInterleavedVert3D * vert	= &_verts[i];
						
						// -------------------------------------------
						// pull the verts
						// -------------------------------------------
						PODVec3f * v = (PODVec3f *)&mvertsdata[vertpos];
						
						vert->vert.x = v->x;
						vert->vert.y = v->y;
						vert->vert.z = v->z;
						
						vertpos += mverts->stride;
						// -------------------------------------------
						
						// -------------------------------------------
						// pull the normals
						// -------------------------------------------
						PODVec3f * n = (PODVec3f *)&mnormaldata[normpos];
						
						vert->normal.x = n->x;
						vert->normal.y = n->y;
						vert->normal.z = n->z;
						
						normpos += mnormals->stride;
						// -------------------------------------------
						
						// -------------------------------------------
						// pull the uvs
						// -------------------------------------------
						PODVec2f * uv = (PODVec2f *)&muvwdata[uvwpos];
						
						vert->uv.x = uv->x;
						vert->uv.y = uv->y;
						
						uvwpos += mUVW->stride;
						// -------------------------------------------
						
#if GLInterleavedVert3D_color
						if ( mcolordata )
						{
							// -------------------------------------------
							// pull the colors out
							// -------------------------------------------
							PODVec4c * c = (PODVec4c *)&mcolordata[colpos];
							if ( mvertColor->type == EPODDataRGBA )
							{	
								vert->color.red		= c->x;
								vert->color.green	= c->y;
								vert->color.blue	= c->z;
								vert->color.alpha	= c->w;
							}
							else if ( ( mvertColor->type == EPODDataARGB ) ||
									 ( mvertColor->type == EPODDataD3DCOLOR ) )
							{
								vert->color.red		= c->y;
								vert->color.green	= c->z;
								vert->color.blue	= c->w;
								vert->color.alpha	= c->x;
							}
							colpos += mvertColor->stride;
							// -------------------------------------------
						}
						else
						{
							vert->color.red		= 255;
							vert->color.green	= 255;
							vert->color.blue	= 255;
							vert->color.alpha	= 255;
						}
						
#endif
					}
					return TRUE;	
				}
			}
		}
		return false;
	}
	
	BOOL convertToIndices( const PODMesh * _model, GLVertIndice * _indices )
	{
		if ( _model && _indices )
		{
			if ( _model->numFaces )
			{
				const PODData * mfaces	= &_model->faces;
				if ( mfaces->data )
				{
					const NSInteger	numindices	= _model->numFaces*3;
					if ( mfaces->stride == sizeof(short) )
					{
						memcpy(_indices, mfaces->data, sizeof(short)*numindices);
					}
					else 
					{
						// TODO :: iterate over the index list
					}
					
					return TRUE;
				}
			}
		}
		return false;
	}
};