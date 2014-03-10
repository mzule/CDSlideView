//
//  CDPositionIndicatorView.h
//  zcool
//
//  Created by mzule on 3/10/14.
//  Copyright (c) 2014 mzule. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CDPositionIndicatorView : UIView
/**
 *  The total count of this position indicator view.
 */
@property (nonatomic) NSUInteger count;
/**
 *  The hightlight position index at this view.
 */
@property (nonatomic) NSUInteger highlightPosition;
/**
 *  The color of normal indicator.
 */
@property (nonatomic,strong) UIColor *normalColor;
/**
 *  The color of highlight indicator.
 */
@property (nonatomic,strong) UIColor *highlightColor;
/**
 *  The size of each indicator.
 */
@property (nonatomic) NSUInteger size;
/**
 *  The inset between each indicator.
 */
@property (nonatomic) NSUInteger inset;
/**
 *  Initialize with given count.
 *
 *  @param count The total positions count.
 *
 *  @return inited self
 */
- (id)initWithPositionCount:(NSUInteger) count;
@end
