//
//  GLTestMeshFactory.m
//  Electric3D
//
//  Created by Robert McDowell on 23/09/2010.
//  Copyright 2010 Electric TopHat Ltd. All rights reserved.
//

#import "GLTestMeshFactory.h"
#import "GLMeshFactory.h"
#import "GLMesh.h"
#import "GLMeshWriteHeader.h"

@implementation GLTestMeshFactory_container

@end


@interface GLTestMeshFactory (PrivateMethods)

- (void) initialization;
- (void) teardown;

- (void) print:(NSString*)_text;

- (void) updateContainerTest:(GLTestMeshFactory_container*)_container;

@end

@implementation GLTestMeshFactory

#pragma mark ---------------------------------------------------------
#pragma mark === Constructor / Destructor Functions  ===
#pragma mark ---------------------------------------------------------

// ------------------------------------------
// intialisation via nib
// ------------------------------------------
- (id)initWithCoder:(NSCoder*)coder 
{
	if ((self = [super initWithCoder:coder])) 
	{
		// Initialization code
		[self initialization];
	}
	return self;
}

// ------------------------------------------
// intialisation using the frame
// ------------------------------------------
- (id)initWithFrame:(CGRect)frame 
{
    if (self = [super initWithFrame:frame]) 
	{
        // Initialization code
		[self initialization];
    }
    return self;
}

// ------------------------------------------
// dealloc
// ------------------------------------------
- (void)dealloc 
{	
	[self teardown];
	
    [super dealloc];
}

#pragma mark ---------------------------------------------------------
#pragma mark === End Constructor / Destructor Functions  ===
#pragma mark ---------------------------------------------------------

#pragma mark ---------------------------------------------------------
#pragma mark === Public Functions  ===
#pragma mark ---------------------------------------------------------

// ------------------------------------------
// canRotate
// ------------------------------------------
- (BOOL) canRotate
{
	return FALSE;
}

// ------------------------------------------
// update Function
// ------------------------------------------
- (void) update:(id)_sender
{
	if ( !md2animated->complete )
	{
		[self updateContainerTest:md2animated];
	}
	else if ( !md2static->complete )
	{
		[self updateContainerTest:md2static];
	}
	else if ( !md2MAX3DS->complete )
	{
		[self updateContainerTest:md2MAX3DS];
	}
	else if ( !md2PVRPOD->complete )
	{
		[self updateContainerTest:md2PVRPOD];
	}
}

#pragma mark ---------------------------------------------------------
#pragma mark === End Public Functions  ===
#pragma mark ---------------------------------------------------------

#pragma mark ---------------------------------------------------------
#pragma mark === Private Functions  ===
#pragma mark ---------------------------------------------------------

// ------------------------------------------
// Initialization
// ------------------------------------------
- (void) initialization
{
	display = [[UITextView alloc] initWithFrame:[self bounds]];
	[display setUserInteractionEnabled:FALSE];
	[self addSubview:display];
	[self print:@"Running...."];
	[self print:@""];
	
	md2animated = [[GLTestMeshFactory_container alloc] init];
	md2animated->bundleMesh		= @"MD2AnimatedMeshTest.md2";
	md2animated->localfileMesh	= [[DOCUMENTS_PATH stringByAppendingPathComponent:@"MVATest.mva"] copy];
	md2animated->meshA			= nil;
	md2animated->meshB			= nil;
	md2animated->deleted		= FALSE;
	md2animated->complete		= FALSE;
	
	md2static	= [[GLTestMeshFactory_container alloc] init];
	md2static->bundleMesh		= @"MD2StaticMeshTest.md2";
	md2static->localfileMesh	= [[DOCUMENTS_PATH stringByAppendingPathComponent:@"MSTest.ms"] copy];
	md2static->meshA			= nil;
	md2static->meshB			= nil;
	md2static->deleted			= FALSE;
	md2static->complete			= FALSE;
	
	md2MAX3DS = [[GLTestMeshFactory_container alloc] init];
	md2MAX3DS->bundleMesh		= @"vertexpaintcube.3DS";//@"Box.3ds";
	md2MAX3DS->localfileMesh	= [[DOCUMENTS_PATH stringByAppendingPathComponent:@"MSBox.ms"] copy];
	md2MAX3DS->meshA			= nil;
	md2MAX3DS->meshB			= nil;
	md2MAX3DS->deleted			= FALSE;
	md2MAX3DS->complete			= FALSE;
	
	md2PVRPOD = [[GLTestMeshFactory_container alloc] init];
	md2PVRPOD->bundleMesh		= @"vertex_cube.POD";
	md2PVRPOD->localfileMesh	= [[DOCUMENTS_PATH stringByAppendingPathComponent:@"MSCube.ms"] copy];
	md2PVRPOD->meshA			= nil;
	md2PVRPOD->meshB			= nil;
	md2PVRPOD->deleted			= FALSE;
	md2PVRPOD->complete			= FALSE;
	
	factory = new GLMeshes::GLMeshFactory();
	
	const GLMeshes::GLMesh * cone		= factory->load( @"E3D_cone", @"md2" );
	const GLMeshes::GLMesh * cylinder = factory->load( @"E3D_cylinder", @"md2" );
	const GLMeshes::GLMesh * cube		= factory->load( @"E3D_cube", @"md2" );
	const GLMeshes::GLMesh * sphere	= factory->load( @"E3D_sphere", @"md2" );
	
	if ( GLMeshWriter::writeToHeader( [DOCUMENTS_PATH stringByAppendingPathComponent:@"GLMeshCone.h"],		@"cone",		cone->verts(), cone->numverts() ) )
	{
		[self print:@"Written GLMeshCone.h"];
	}
	
	GLMeshWriter::writeToHeader( [DOCUMENTS_PATH stringByAppendingPathComponent:@"GLMeshCylinder.h"],	@"cylinder",	cylinder->verts(), cylinder->numverts() );
	GLMeshWriter::writeToHeader( [DOCUMENTS_PATH stringByAppendingPathComponent:@"GLMeshCube.h"],		@"cube",		cube->verts(), cube->numverts() );
	GLMeshWriter::writeToHeader( [DOCUMENTS_PATH stringByAppendingPathComponent:@"GLMeshSphere.h"],		@"sphere",		sphere->verts(), sphere->numverts() );
	
	factory->release( cone );
	factory->release( cylinder );
	factory->release( cube );
	factory->release( sphere );
}

// ------------------------------------------
// Teardown
// ------------------------------------------
- (void) teardown
{
	SAFE_DELETE( factory );
	
	SAFE_RELEASE( md2animated );
	SAFE_RELEASE( md2static );
	SAFE_RELEASE( md2MAX3DS );
	SAFE_RELEASE( md2PVRPOD );
	
	[display removeFromSuperview];
	SAFE_RELEASE( display );
}

// ------------------------------------------
// print text in the window
// ------------------------------------------
- (void) print:(NSString*)_text
{
	if ( _text)
	{
		NSString * currentText = [display text];
		NSString * newText = [NSString stringWithFormat:@"\n%@%@", _text, currentText];
		[display setText:newText];
	}
}

- (void) updateContainerTest:(GLTestMeshFactory_container*)_container
{	
	if ( !_container->deleted && [[NSFileManager defaultManager] fileExistsAtPath:_container->localfileMesh] )
	{
		NSTimeInterval start = [[NSDate date] timeIntervalSinceReferenceDate];
		if ( [[NSFileManager defaultManager] removeItemAtPath:_container->localfileMesh error:nil] )
		{
			NSTimeInterval end = [[NSDate date] timeIntervalSinceReferenceDate];
			
			[self print:[NSString stringWithFormat: @"Deleted file %@ in %.3f.", [_container->localfileMesh lastPathComponent], end-start ]];
		}
		else 
		{
			[self print:@"Failed to delete file."];
		}
	}
	else if ( !factory->isLoaded( _container->bundleMesh, @"" ) )
	{
		[self print:[NSString stringWithFormat:@"Loading %@", _container->bundleMesh]];
		
		NSTimeInterval start = [[NSDate date] timeIntervalSinceReferenceDate];
		_container->meshA = factory->load( _container->bundleMesh, @"" );
		NSTimeInterval end = [[NSDate date] timeIntervalSinceReferenceDate];
		
		if ( _container->meshA )
		{
			[self print:[NSString stringWithFormat:@"Loaded %@ model into memory in %.3f", _container->bundleMesh, end-start]];
		}
		else 
		{
			[self print:[NSString stringWithFormat:@"Failed to load %@", [_container->bundleMesh lastPathComponent]]];
			[self print:@""];
			_container->complete = TRUE;
		}
	}
	else if ( _container->meshA && ![[NSFileManager defaultManager] fileExistsAtPath:_container->localfileMesh] )
	{
		[self print:[NSString stringWithFormat:@"Writing %@", [_container->localfileMesh lastPathComponent]]];
		
		NSTimeInterval start = [[NSDate date] timeIntervalSinceReferenceDate];
		if ( _container->meshA->write( _container->localfileMesh ) )
		{
			NSTimeInterval end = [[NSDate date] timeIntervalSinceReferenceDate];
			
			[self print:[NSString stringWithFormat:@"Written file %@ in %.3f", [_container->localfileMesh lastPathComponent], end-start]];
		}
	}
	else if ( !factory->isLoaded( _container->localfileMesh ) )
	{
		[self print:[NSString stringWithFormat:@"Loading %@", [_container->localfileMesh lastPathComponent]]];
		
		NSTimeInterval start = [[NSDate date] timeIntervalSinceReferenceDate];
		_container->meshB = factory->load( _container->localfileMesh );
		NSTimeInterval end = [[NSDate date] timeIntervalSinceReferenceDate];
		
		if ( _container->meshB )
		{	
			[self print:[NSString stringWithFormat:@"Loaded %@ model into memory in %.3f", [_container->localfileMesh lastPathComponent], end-start]];
		}
		else 
		{
			[self print:[NSString stringWithFormat:@"Failed to load %@", [_container->localfileMesh lastPathComponent]]];
			[self print:@""];
			_container->complete = TRUE;
		}
	}
	else 
	{
		[self print:@""];
		_container->complete = TRUE;
	}

	_container->deleted = TRUE;
}

#pragma mark ---------------------------------------------------------
#pragma mark === End Private Functions  ===
#pragma mark ---------------------------------------------------------

@end
