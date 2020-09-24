//
//  colorsView.m
//  colors
//
//  Created by mobi on 2020/9/24.
//  Copyright © 2020 mobi. All rights reserved.
//

#import "colorsView.h"

@implementation colorsView

- (instancetype)initWithFrame:(NSRect)frame isPreview:(BOOL)isPreview
{
    self = [super initWithFrame:frame isPreview:isPreview];
    if (self) {
        [self setAnimationTimeInterval:3];
        NSText *t = [[NSText alloc] init];
        t.string = @"made by cZ";
        t.textColor = NSColor.blackColor;
        t.font = [NSFont systemFontOfSize:12];
        t.alignment = NSTextAlignmentRight;
        t.backgroundColor = NSColor.clearColor;
        t.frame = NSMakeRect(self.bounds.size.width-100-10, 10, 100, 15);
        [self addSubview:t];
    }
    return self;
}

- (void)startAnimation
{
    [super startAnimation];
}

- (void)stopAnimation
{
    [super stopAnimation];
}

- (void)drawRect:(NSRect)rect
{
    [super drawRect:rect];
    CGFloat red = arc4random_uniform(256);
    CGFloat green = arc4random_uniform(256);
    CGFloat blue = arc4random_uniform(256);
    
    NSColor* color = [NSColor colorWithRed:red/255 green:green/255 blue:blue/255 alpha:1];
    [color setFill];
    NSRectFill(rect);
}

- (void)animateOneFrame
{
    [self setNeedsDisplay:TRUE];
    return;
}

- (BOOL)hasConfigureSheet
{
    return NO;
}

- (NSWindow*)configureSheet
{
    return nil;
}

@end
