//
//  CDPositionIndicatorView.m
//  zcool
//
//  Created by mzule on 3/10/14.
//  Copyright (c) 2014 mzule. All rights reserved.
//

#import "CDPositionIndicatorView.h"

const int SIZE_PER_POSITION_INDICATOR = 4;
const int INSET_PER_POSITION = 8;

@implementation CDPositionIndicatorView

#pragma mark - Initialize

- (id)initWithPositionCount:(NSUInteger) count
{
    self = [super init];
    if (self) {
        self.count = count;
    }
    return self;
}
#pragma mark - Getters

-(UIColor *)normalColor
{
    if (_normalColor) {
        return _normalColor;
    }
    _normalColor = [UIColor whiteColor];
    return _normalColor;
}

-(UIColor *)highlightColor
{
    if (_highlightColor) {
        return _highlightColor;
    }
    _highlightColor = [UIColor grayColor];
    return _highlightColor;
}

-(NSUInteger)size
{
    if (_size) {
        return _size;
    }
    _size = SIZE_PER_POSITION_INDICATOR;
    return _size;
}

-(NSUInteger)inset
{
    if (_inset) {
        return _inset;
    }
    _inset = INSET_PER_POSITION;
    return _inset;
}

#pragma mark - Instance methods.

-(void) setHighlightPosition:(NSUInteger)highlightPosition
{
    _highlightPosition = highlightPosition;
    [self setNeedsLayout];
}

-(void)setCount:(NSUInteger)count
{
    _count = count;
    // calculate new frame.
    self.frame = CGRectMake(self.frame.origin.x, self.frame.origin.y, (SIZE_PER_POSITION_INDICATOR + INSET_PER_POSITION) * self.count - INSET_PER_POSITION, SIZE_PER_POSITION_INDICATOR);
    [self setNeedsLayout];
}

-(void) layoutSubviews
{
    // remove all subviews before drawing
    for (UIView *view in self.subviews) {
        [view removeFromSuperview];
    }
    // drawing
    self.frame = CGRectMake(self.frame.origin.x, self.frame.origin.y, (SIZE_PER_POSITION_INDICATOR + INSET_PER_POSITION) * self.count - INSET_PER_POSITION, SIZE_PER_POSITION_INDICATOR);
    for (int i = 0 ; i < self.count; i ++) {
        UIView *view = [self indicator];
        [view setBackgroundColor:self.normalColor];
        if (i == self.highlightPosition) {
            [view setBackgroundColor:self.highlightColor];
        }
        view.frame = CGRectMake(i * (SIZE_PER_POSITION_INDICATOR + INSET_PER_POSITION), 0, SIZE_PER_POSITION_INDICATOR, SIZE_PER_POSITION_INDICATOR);
        [self addSubview:view];
    }
}

-(UIView *) indicator
{
    NSUInteger size = SIZE_PER_POSITION_INDICATOR;
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0,0,size,size)];
    return view;
}

@end
