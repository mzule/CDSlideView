//
//  ZCLRootViewController.m
//  zcool
//
//  Created by mzule on 3/7/14.
//  Copyright (c) 2014 mzule. All rights reserved.
//

#import "CDRootViewController.h"
#import "CDSlideView.h"

@implementation CDRootViewController

-(id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nil bundle:nil];
    if (self) {
    }
    return self;
}

-(void)viewDidLoad
{
    [super viewDidLoad];
    [self.slideView addContentView:[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"m1"]]];
    [self.slideView addContentView:[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"m2"]]];
    [self.slideView addContentView:[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"m3"]]];
    [self.slideView addContentView:[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"m4"]]];
    [self.slideView addContentView:[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"m5"]]];
    [self.view addSubview:self.slideView];
    UIGestureRecognizer *tapGestureRecognizer = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(selectViewInSlideView)];
    [self.slideView addGestureRecognizer:tapGestureRecognizer];
    self.slideView.translatesAutoresizingMaskIntoConstraints = NO;
    // constraint
    NSArray *constraintX = [NSLayoutConstraint constraintsWithVisualFormat:@"H:|-0-[_slideView]-0-|"
                                                                  options:0
                                                                  metrics:nil
                                                                    views:NSDictionaryOfVariableBindings(_slideView)];
    NSArray *constraintY = [NSLayoutConstraint constraintsWithVisualFormat:@"V:|-0-[_slideView]"
                                                                   options:0
                                                                   metrics:nil
                                                                     views:NSDictionaryOfVariableBindings(_slideView)];
    NSLayoutConstraint *constraintHeight = [NSLayoutConstraint constraintWithItem:self.slideView
                                                                        attribute:NSLayoutAttributeHeight
                                                                        relatedBy:NSLayoutRelationEqual
                                                                           toItem:self.slideView
                                                                        attribute:NSLayoutAttributeWidth
                                                                       multiplier:298/653.0
                                                                         constant:0];
    [self.view addConstraints:constraintX];
    [self.view addConstraints:constraintY];
    [self.view addConstraint:constraintHeight];
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    CGRect f = self.view.bounds;
    NSLog(@"%@",NSStringFromCGRect(f));
}

-(CDSlideView *)slideView
{
    if (_slideView) {
        return _slideView;
    }
    _slideView = [[CDSlideView alloc]initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height / 3)];
    return _slideView;
}

-(void)selectViewInSlideView
{
    NSUInteger page = self.slideView.currentPage;
    NSLog(@"current page %d",page);
}
@end
