//
//  trainCapView.m
//  trainCap
//
//  Created by 曹政 on 2017/9/22.
//  Copyright © 2017年 caozheng. All rights reserved.
//

#import "trainCapView.h"

@interface RedView : NSView

@end

@implementation RedView

- (void)drawRect:(NSRect)dirtyRect{
    [super drawRect:dirtyRect];
    [[NSColor redColor] setFill];
    NSRectFill(dirtyRect);
}

@end

@implementation trainCapView{
    NSView *_ball1;
    NSView *_ball2;
    NSView *_ball3;
    NSSize _size;
    CGFloat _hInteval;
    CGFloat _vInteval;
}

- (instancetype)initWithFrame:(NSRect)frame isPreview:(BOOL)isPreview
{
    self = [super initWithFrame:frame isPreview:isPreview];
    if (self) {
        [self setAnimationTimeInterval:1/30.0];
        _size = CGSizeMake(20, 20);
        CGFloat total = self.bounds.size.width;
        NSInteger num = total/_size.width/2;
        _hInteval = (total-num*_size.width)/(num-1);
        
        total = self.bounds.size.height;
        num = total/_size.height/2;
        _vInteval = (total-num*_size.height)/(num-1);
        
        _ball1 = [[RedView alloc] initWithFrame:NSMakeRect(NSMinX(self.bounds),NSMinY(self.bounds), _size.width, _size.height)];
        _ball2 = [[RedView alloc] initWithFrame:NSMakeRect(NSMaxX(_ball1.frame)+_hInteval,NSMinY(_ball1.frame), _size.width, _size.height)];
        _ball3 = [[RedView alloc] initWithFrame:NSMakeRect(NSMaxX(_ball2.frame)+_hInteval,NSMinY(_ball2.frame), _size.width, _size.height)];
        [self addSubview:_ball1];
        [self addSubview:_ball2];
        [self addSubview:_ball3];
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
}

- (void)animateOneFrame
{
    _ball1.frame = [self nextFrame:_ball1.frame];
    _ball2.frame = [self nextFrame:_ball2.frame];
    _ball3.frame = [self nextFrame:_ball3.frame];
}

- (CGRect)nextFrame:(CGRect)frame{
    if (NSMinY(frame)==NSMinY(self.bounds)) {    //紧贴下边
        if (NSMaxX(frame)>=NSMaxX(self.bounds)){
            frame.origin.x = NSMaxX(self.bounds) - _size.width;
            frame.origin.y = NSMaxY(frame) + _vInteval;
        }else{
            frame.origin.x = NSMaxX(frame) + _hInteval;
        }
    }else if (NSMaxX(frame)==NSMaxX(self.bounds)){   //紧贴右边
        if (NSMaxY(frame)>=NSMaxY(self.bounds)){
            frame.origin.y = NSMaxY(self.bounds) - _size.height;
            frame.origin.x = NSMinX(frame) - _hInteval - _size.width;
        }else{
            frame.origin.y = NSMaxY(frame) + _vInteval;
        }
    }else if (NSMaxY(frame)==NSMaxY(self.bounds)){   //紧贴上边
        if (NSMinX(frame)<=NSMinX(self.bounds)){
            frame.origin.x = NSMinX(self.bounds);
            frame.origin.y = NSMinY(frame) - _vInteval - _size.height;
        }else{
            frame.origin.x = NSMinX(frame) - _hInteval - _size.width;
        }
    }else if (NSMinX(frame)==NSMinX(self.bounds)){   //紧贴左边
        if (NSMinY(frame)<=NSMinY(self.bounds)) {
            frame.origin.y = NSMinY(self.bounds);
            frame.origin.x = NSMaxX(frame) + _hInteval;
        } else {
            frame.origin.y = NSMinY(frame) - _vInteval - _size.height;
        }
    }
    return frame;
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
