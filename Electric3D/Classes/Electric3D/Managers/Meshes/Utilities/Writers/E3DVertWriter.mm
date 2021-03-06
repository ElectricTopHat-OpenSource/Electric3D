//
//  E3DVertWriter.m
//  Electric3D
//
//  Created by Robert McDowell on 27/09/2010.
//  Copyright 2010 Electric TopHat Ltd. All rights reserved.
//

#import "E3DVertWriter.h"

namespace E3D
{
	BOOL writeToHeader( NSString * _filePath, NSString * _meshName,const GLInterleavedVert3D * _verts, NSUInteger _numverts )
	{
		NSString * fileNameExt	= [_filePath lastPathComponent];
		NSString * fileExt		= [_filePath pathExtension];
		NSString * fileName		= [fileNameExt stringByDeletingPathExtension];
		
		NSMutableString * fileString = [NSMutableString stringWithCapacity:1000];
		
		[fileString appendString:@"//\r\n"];
		[fileString appendFormat:@"//  %@\r\n", fileNameExt];
		[fileString appendString:@"//  Electric3D\r\n"];
		[fileString appendString:@"//\r\n"];
		[fileString appendFormat:@"//  Created by E3DMeshWriter on %@\r\n", [NSDate date]];
		[fileString appendString:@"//  Copyright 2010 Electric TopHat Ltd. All rights reserved.\r\n"];
		[fileString appendString:@"//\r\n"];
		[fileString appendString:@"\r\n"];
		[fileString appendFormat:@"#if !defined(__%@_%@__)\r\n", fileName, fileExt];
		[fileString appendFormat:@"#define __%@_%@__\r\n", fileName, fileExt];
		[fileString appendString:@"\r\n"];
		[fileString appendString:@"#import \"GLVertexTypes.h\"\r\n"];
		[fileString appendString:@"\r\n"];
		[fileString appendString:@"namespace E3D\r\n"];
		[fileString appendString:@"{\r\n"];
		
		[fileString appendString:@"\r\n"];
		
		[fileString appendFormat:@"\tstatic const GLInterleavedVert3D _%@Verts[] =\r\n", _meshName];
		[fileString appendString:@"\t{\r\n"];
		
#if 0
		[fileString appendFormat:@"\t\t"];
		
		unsigned char * p = (unsigned char *)_verts;
		int size = sizeof(GLInterleavedVert3D) * size;
		int i;
		for ( i=0; i<size; i++ )
		{
			[fileString appendFormat:@"0x%02x", p[i]];
			if ( i<size-1 )
			{
				[fileString appendString:@","];
				
				if ( ( i > 0 ) && ( (i+1) % 10 ) == 0 )
				{
					[fileString appendFormat:@"\r\n\t\t"];
				}
			}
		}
		[fileString appendString:@"\r\n"];
#else
		
		int i;
		for ( i=0; i<_numverts; i++ )
		{
			const GLInterleavedVert3D * vert = &_verts[i];
			
			[fileString appendFormat:@"\t\t%f, %f, %f,\r\n", vert->vert.x, vert->vert.y, vert->vert.z];
			[fileString appendFormat:@"\t\t%f, %f, %f,\r\n", vert->normal.x, vert->normal.y, vert->normal.z];
			
			[fileString appendString:@"#if GLInterleavedVert3D_color\r\n"];
#if GLInterleavedVert3D_color
			[fileString appendFormat:@"\t\t%d,\r\n", vert->color.value];
#else
			[fileString appendString:@"\t\t%d,\r\n", -1];
#endif
			[fileString appendString:@"#endif\r\n"];
			
			[fileString appendFormat:@"\t\t%f, %f", vert->uv.x, vert->uv.y ];
			if ( i<_numverts-1 )
			{
				[fileString appendString:@","];
			}
			[fileString appendString:@"\r\n"];
		}
#endif
		[fileString appendString:@"\t};\r\n"];
		
		[fileString appendString:@"\r\n"];
		
		[fileString appendFormat:@"\tNSUInteger num%@Verts() { return %d; };\r\n", _meshName, _numverts];
		[fileString appendFormat:@"\tconst GLInterleavedVert3D * %@() { return &_%@Verts[0]; };\r\n", _meshName, _meshName];
		[fileString appendFormat:@"\tBOOL copy%@ToVerts( GLInterleavedVert3D * _verts ) { if ( _verts ) { memcpy(_verts, &_%@Verts[0], sizeof(_%@Verts)); return TRUE; } return FALSE; };\r\n", _meshName, _meshName, _meshName ];
		
		[fileString appendString:@"\r\n"];
		[fileString appendString:@"};\r\n"];
		[fileString appendString:@"\r\n"];
		[fileString appendString:@"#endif\r\n"];
		
		
		return [fileString writeToFile:_filePath atomically:YES encoding:NSUTF8StringEncoding error:nil];
	}
}
