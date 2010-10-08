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
	CGMaths::CGMatrix4x4 getNodeTransform( const PODNode * _node, unsigned int _animFrame, const PODNode * _nodelist )
	{
		if ( _node )
		{
			CGMaths::CGMatrix4x4 matrix;
			if(_node->animMatrixs)
			{
				if(_node->animFlags & ePODHasMatrixAni)
				{
					unsigned int offset = _animFrame * 16;
					memcpy(&matrix.m, &_node->animMatrixs[offset], sizeof(CGMaths::CGMatrix4x4));
				}
				else
				{
					memcpy(&matrix.m, _node->animMatrixs, sizeof(CGMaths::CGMatrix4x4));
				}
			}
			else
			{
				matrix = CGMaths::CGMatrix4x4Identity;
				
				// Scale
				if(_node->animScales)
				{
					unsigned int offset = (_node->animFlags & ePODHasScaleAni) ? _animFrame * 3 : 0;
					CGMaths::CGMatrix4x4SetScale( matrix, _node->animScales[offset+0], _node->animScales[offset+1], _node->animScales[offset+2] );
				}
				
				// Rotation
				if(_node->animRotations)
				{
					CGMaths::CGQuaternion quat;
					unsigned int offset = (_node->animFlags & ePODHasRotationAni) ? _animFrame * 4 : 0;
					memcpy(&quat, &_node->animRotations[offset], sizeof(CGMaths::CGQuaternion));
					matrix = CGMatrix4x4Multiply( matrix, CGMaths::CGMatrix4x4Make( quat ) );
				}
				
				// Translation
				if(_node->animPositions)
				{
					unsigned int offset = (_node->animFlags & ePODHasPositionAni) ? _animFrame * 3 : 0;
					CGMaths::CGMatrix4x4SetTranslation( matrix, _node->animPositions[offset+0], _node->animPositions[offset+1], _node->animPositions[offset+2] );
				}
			}
			
			// add the parent if there is one
			if ( ( _nodelist ) && ( _node->idxParent >= 0 ) )
			{
				CGMaths::CGMatrix4x4 parent = getNodeTransform( &_nodelist[_node->idxParent], _animFrame, _nodelist );
				matrix = CGMatrix4x4Multiply( matrix, parent );
			}
			
			return matrix;
		}
		return CGMaths::CGMatrix4x4Identity;
	}
	
	BOOL convertToVerts( const PODMesh * _model, GLInterleavedVert3D * _verts, const CGMaths::CGMatrix4x4 & _transform )
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
				const PODData * mUVW		= &_model->UVWs[_model->numUVW-1];
				
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
						
						if ( mvertColor->numVertexes )
						{
							mcolordata	= _model->interleaved;
						}
						if ( mUVW->numVertexes )
						{
							muvwdata	= _model->interleaved;
						}
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
						
						CGMaths::CGVector3D pos = CGMaths::CGMatrix4x4TransformVector( _transform, v->x, v->y ,v->z );
						
						vert->vert.x = pos.x;
						vert->vert.y = pos.y;
						vert->vert.z = pos.z;
						
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
						
						if ( muvwdata )
						{
							// -------------------------------------------
							// pull the uvs
							// -------------------------------------------
							PODVec2f * uv = (PODVec2f *)&muvwdata[uvwpos];
							
							vert->uv.x =  uv->x;
							vert->uv.y = -uv->y; // ?? don't know why i have to negate this ??
							
							uvwpos += mUVW->stride;
							// -------------------------------------------
						}
						
#if GLInterleavedVert3D_color
						if ( mcolordata )
						{
							// -------------------------------------------
							// pull the colors out
							// -------------------------------------------
							PODVec4c * col = (PODVec4c *)&mcolordata[colpos];
							//memcpy(&col, &mcolordata[colpos], sizeof(PODVec4c));
							if ( mvertColor->type == EPODDataRGBA )
							{	
								// err something seems to be wrong with 
								// the way pod exporter is doing this
								vert->color.red		= col->y;
								vert->color.green	= col->z;
								vert->color.blue	= col->w;
								vert->color.alpha	= col->x;
							}
							else if ( ( mvertColor->type == EPODDataARGB ) ||
									  ( mvertColor->type == EPODDataD3DCOLOR ) )
							{
								// not sure why this works but it does???
								vert->color.red		= col->x;
								vert->color.green	= col->y;
								vert->color.blue	= col->z;
								vert->color.alpha	= col->w;
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
	
	BOOL convertToIndices( const PODMesh * _model, GLVertIndice * _indices, unsigned int _offset )
	{
		if ( _model && _indices )
		{
			if ( _model->numFaces )
			{
				const PODData * mfaces	= &_model->faces;
				if ( mfaces->data )
				{
					const NSInteger	numindices	= _model->numFaces*3;
					if ( mfaces->stride == sizeof(short) && _offset == 0 )
					{
						memcpy(_indices, mfaces->data, sizeof(short)*numindices);
					}
					else 
					{
						int i;
						for ( i=0; i<numindices; i++ )
						{
							unsigned short value = mfaces->data[i*mfaces->stride];
							_indices[i] = value + _offset;
						}
					}
					
					return TRUE;
				}
			}
		}
		return false;
	}
};