//
//  CDSlideView.m
//  zcool
//
//  Created by mzule on 3/7/14.
//  Copyright (c) 2014 mzule. All rights reserved.
//

#import "CDSlideView.h"
#import "CDPositionIndicatorView.h"

@interface CDSlideView()
{
    CDPositionIndicatorView *_positionIndicator;
}

@end

/**
 *  Default auto scroll time interval in seconds.
 */
const int DEFAULT_AUTO_SCROLL_INTERVAL = 5;

@implementation CDSlideView

#pragma mark - Initialize

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        _positionIndicator = [[CDPositionIndicatorView alloc]init];
        [self addSubview:self.scrollView];
        [self addSubview:_positionIndicator];
        // auto scroll content views.
        [NSTimer scheduledTimerWithTimeInterval:self.autoScrollInterval
                                         target:self
                                       selector:@selector(doAutoScroll)
                                       userInfo:nil
                                        repeats:YES];
    }
    return self;
}

#pragma mark - Getters
-(UIScrollView *)scrollView
{
    if (_scrollView) {
        return _scrollView;
    }
    // same size for this view and scroll view.
    _scrollView = [[UIScrollView alloc]initWithFrame:self.frame];
    // set scroll view delegate to self
    _scrollView.delegate = self;
    [_scrollView setPagingEnabled:YES];
    _scrollView.showsHorizontalScrollIndicator = NO;
    _scrollView.showsVerticalScrollIndicator = NO;
    return _scrollView;
}

-(NSMutableArray *)contentViews
{
    if (_contentViews) {
        return _contentViews;
    }
    _contentViews = [NSMutableArray new];
    return _contentViews;
}

-(CGFloat)autoScrollInterval
{
    if (_autoScrollInterval == 0) {
        return DEFAULT_AUTO_SCROLL_INTERVAL;
    }
    return _autoScrollInterval;
}

#pragma mark - Instance method

-(void) addContentView:(UIView *)view
{
    // adjust content views array
    if ([self.contentViews count] == 0){
        [self.contentViews addObject:[self copyView:view]];
        [self.contentViews addObject:view];
        [self.contentViews addObject:[self copyView:view]];
    }else{
        [self.contentViews setObject:[self copyView:view] atIndexedSubscript:0];
        [self.contentViews insertObject:view atIndex:[self.contentViews count]-1];
    }
}

-(UIView *)copyView:(UIView *)view
{
    id copyOfView = [NSKeyedUnarchiver unarchiveObjectWithData:[NSKeyedArchiver archivedDataWithRootObject:view]];
    return copyOfView;
}

-(void)layoutSubviews
{
    // adjust scroll view
    for (int i = 0 ;i < [self.contentViews count]; i++){
        CGFloat x = i * self.frame.size.width;
        CGFloat y = 0;
        UIView *view = [self.contentViews objectAtIndex:i];
        [view setFrame:CGRectMake(x, y, self.frame.size.width, self.frame.size.height)];
        [self.scrollView addSubview:view];
    }
    [self.scrollView setContentSize:CGSizeMake(self.frame.size.width * [self.contentViews count], self.frame.size.height)];
    [self.scrollView setContentOffset:CGPointMake(self.frame.size.width, 0)];
    [self.scrollView setFrame:self.frame];
    // indicators
    [_positionIndicator setCount:[self.contentViews count] - 2];
    CGPoint center = self.center;
    center.y = self.frame.size.height - _positionIndicator.size * 2;
    _positionIndicator.center = center;
}
/**
 *  Do auto scroll view contents in every given time interval.
 */
-(void)doAutoScroll
{
    int x = (self.currentPage + 2) * self.scrollView.frame.size.width;
    [self.scrollView setContentOffset:CGPointMake(x, 0) animated:YES];
    
}

#pragma mark - UIScrollViewDelegate implementations

-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    CGPoint offset = scrollView.contentOffset;
    CGFloat offsetX = offset.x;
    CGFloat offsetY = offset.y;
    if (offsetX == 0) {
        [scrollView setContentOffset:CGPointMake(self.frame.size.width * ([self.contentViews count] - 2), offsetY)];
    }
    if (offsetX == self.frame.size.width * ([self.contentViews count] - 1)) {
        [scrollView setContentOffset:CGPointMake(self.frame.size.width, offsetY)];
    }
    // change current page
    NSUInteger invalidPage = offsetX / self.scrollView.frame.size.width;
    _currentPage = (invalidPage - 1) % ([self.contentViews count] - 2);
    // update position indicator
    [_positionIndicator setHighlightPosition:self.currentPage];
}

@end
