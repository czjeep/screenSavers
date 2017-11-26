//
//  fallBallView.m
//  fallBall
//
//  Created by 曹政 on 2017/11/26.
//  Copyright © 2017年 cz. All rights reserved.
//


#import "fallBallView.h"
@interface ColorView : NSView

@end

@implementation ColorView
-(void)drawRect:(NSRect)dirtyRect{
    [super drawRect:dirtyRect];
    [NSColor.blueColor setFill];
    NSRectFill(dirtyRect);
}
@end

@implementation fallBallView{
    CGFloat _diameter;
    NSView *_ball;
    double _a;  //竖直向下为正
    double _v;
    double _timeInterval;
}

- (instancetype)initWithFrame:(NSRect)frame isPreview:(BOOL)isPreview
{
    self = [super initWithFrame:frame isPreview:isPreview];
    if (self) {
        _diameter = 50;
        _ball = [[ColorView alloc] init];
        _ball.wantsLayer = true;
        CGRect const bounds = self.bounds;
        _ball.frame = NSMakeRect(NSMidX(bounds)-_diameter/2, NSMaxY(bounds)-_diameter, _diameter, _diameter);
        _ball.layer.cornerRadius = _diameter/2;
        [self addSubview:_ball];
        double widthCM = 4.7*2.54*9/sqrt(16*16+9*9);    //参照iphone8屏幕数据
        double widthPT = 375;
        _a = 0.25*10*10*widthPT/widthCM; //__m/s
        _v = 0;
        _timeInterval = 1/30.0;
        [self setAnimationTimeInterval:_timeInterval];
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
    [NSColor.whiteColor setFill];
    NSRectFill(rect);
}

- (void)animateOneFrame
{
    CGFloat const lastY = _ball.frame.origin.y;
    double s = _v*_timeInterval + 0.5*_a*pow(_timeInterval, 2);
    CGFloat currentY = lastY - s;
    if ((currentY <= NSMaxY(self.bounds)- _diameter) && (currentY >= NSMinY(self.bounds))) {
        CGRect frame = _ball.frame;
        frame.origin.y = currentY;
        _ball.frame = frame;
    }else{
        _v = -_v;
        s = _v*_timeInterval + 0.5*_a*pow(_timeInterval, 2);
        currentY = lastY - s;
        CGRect frame = _ball.frame;
        frame.origin.y = currentY;
        _ball.frame = frame;
    }
    _v += _timeInterval*_a;
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
