//
//  GLTestTextureFactory.m
//  Electric3D
//
//  Created by Robert McDowell on 23/09/2010.
//  Copyright 2010 Electric TopHat Ltd. All rights reserved.
//

#import "GLTestTextureFactory.h"
#import "GLTextureFactory.h"

@interface GLTestTextureFactory (PrivateMethods)

- (void) initialization;
- (void) teardown;

- (void) print:(NSString*)_text;

@end

@implementation GLTestTextureFactory

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
// update Function
// ------------------------------------------
- (void) update
{
	NSString * text = nil;
	/*
	 if ( !factory->isLoaded( @"MD2Test", @"md2" ) )
	 {
	 if ( factory->load( @"MD2Test", @"md2" ) )
	 {
	 text = @"Loaded MD2Test.md2 model into memory";
	 }
	 }
	 */
	
	if ( text )
	{
		NSString * currentText = [display text];
		[display setText:[NSString stringWithFormat:@"%@%@\n",currentText, text]];
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
	
	factory = new GLTextures::GLTextureFactory();
}

// ------------------------------------------
// Teardown
// ------------------------------------------
- (void) teardown
{
	SAFE_DELETE( factory );
	
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
		[display setText:[NSString stringWithFormat:@"%@%@\n",currentText, _text]];
	}
}

#pragma mark ---------------------------------------------------------
#pragma mark === End Private Functions  ===
#pragma mark ---------------------------------------------------------

@end
