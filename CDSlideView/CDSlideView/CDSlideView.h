//
//  CDSlideView.h
//  zcool
//
//  Created by mzule on 3/7/14.
//  Copyright (c) 2014 mzule. All rights reserved.
//

#import <UIKit/UIKit.h>
@interface CDSlideView : UIView<UIScrollViewDelegate>
/**
 *  The internal implements of slide view.
 */
@property (strong,nonatomic) UIScrollView *scrollView;

/**
 *  Array of UIViews. Displayed in this slide view.
 */
@property (strong,nonatomic) NSMutableArray *contentViews;

/**
 *  The current page of this slide view.
 */
@property (readonly) NSUInteger currentPage;

/**
 *  The time interval in seconds of view auto scroll.
 */
@property (nonatomic) CGFloat autoScrollInterval;

/**
 *  Views scroll automatically or not.
 */
@property (nonatomic) BOOL autoScroll;

/**
 *  Add any UIView as a content view to this slide view.
 *
 *  @param view any UIView object.
 */
-(void) addContentView:(UIView *) view;
@end
