//
//  MAX3DSModelConvertor.m
//  Electric3D
//
//  Created by Robert McDowell on 04/10/2010.
//  Copyright 2010 Electric TopHat Ltd. All rights reserved.
//

#import "MAX3DSModelConvertor.h"
#import "MAX3DSUtility.h"

namespace MAX3DS 
{
	BOOL convertFrameToVerts( const MAX3DS_OBJECT * _model, GLInterleavedVert3D * _verts )
	{
		if ( ( _model ) && 
			 ( _model->header.numVerts ) && 
			 ( _model->header.numVerts == _model->header.numUVs ) )
		{
			int i;
			// calculate the normals
			for ( i=0; i<_model->header.numFaces; i++ )
			{
				MAX3DS_FACE * face = &_model->faces[i];
				
				int vertIndexA = face->a;
				int vertIndexB = face->b;
				int vertIndexC = face->c;
				
				// grab the interleaved vertex object
				MAX3DS_VERTEX * vertA	= &_model->verts[vertIndexA];
				MAX3DS_VERTEX * vertB	= &_model->verts[vertIndexB];
				MAX3DS_VERTEX * vertC	= &_model->verts[vertIndexC];
				
				// Calculate the face's normal
				float n[3];
				float v1[3];
				float v2[3];
				float v3[3];
				
				v1[0] = vertA->x;
				v1[1] = vertA->y;
				v1[2] = vertA->z;
				v2[0] = vertB->x;
				v2[1] = vertB->y;
				v2[2] = vertB->z;
				v3[0] = vertC->x;
				v3[1] = vertC->y;
				v3[2] = vertC->z;
				
				// calculate the normal
				float u[3], v[3];
				
				// V2 - V3;
				u[0] = v2[0] - v3[0];
				u[1] = v2[1] - v3[1];
				u[2] = v2[2] - v3[2];
				
				// V2 - V1;
				v[0] = v2[0] - v1[0];
				v[1] = v2[1] - v1[1];
				v[2] = v2[2] - v1[2];
				
				n[0] = (u[1]*v[2] - u[2]*v[1]);
				n[1] = (u[2]*v[0] - u[0]*v[2]);
				n[2] = (u[0]*v[1] - u[1]*v[0]);
				
				// Add this normal to its verts' normals
				_verts[vertIndexA].normal.x		+= n[0];
				_verts[vertIndexA].normal.y		+= n[1];
				_verts[vertIndexA].normal.z		+= n[2];
				
				_verts[vertIndexB].normal.x	+= n[0];
				_verts[vertIndexB].normal.y	+= n[1];
				_verts[vertIndexB].normal.z	+= n[2];
				
				_verts[vertIndexC].normal.x	+= n[0];
				_verts[vertIndexC].normal.y	+= n[1];
				_verts[vertIndexC].normal.z	+= n[2];				
			}
			
			for ( i=0; i<_model->header.numVerts; i++ )
			{				
				// grab the interleaved vertex object
				GLInterleavedVert3D * vert	= &_verts[i];
				
				// grab the verts and uv objects
				MAX3DS_VERTEX * modelVert	= &_model->verts[i];
				MAX3DS_UV *		modelUV		= &_model->uvs[i];
				
				// copy the verts ( not may need to offset these using the transform )
				vert->vert.x = modelVert->x;
				vert->vert.y = modelVert->y;
				vert->vert.z = modelVert->z;
				
				// copy the uv's
				vert->uv.x = modelUV->u;
				vert->uv.y = modelUV->v;
				
				// normalize the normal
				float len = sqrtf( ( vert->normal.x * vert->normal.x ) + 
								   ( vert->normal.y * vert->normal.y ) + 
								   ( vert->normal.z * vert->normal.z ) );
				vert->normal.x /= len;
				vert->normal.y /= len;
				vert->normal.z /= len;
				
#if GLInterleavedVert3D_color
				// set the vertex colors
				vert->color.red		= 255;
				vert->color.green	= 255;
				vert->color.blue	= 255;
				vert->color.alpha	= 255;
#endif
			}
			
			return TRUE;
		}
		return FALSE;
	}
	
};