//
//  MSPageViewControllerExample.m
//  MSPageViewController
//
//  Created by Nacho Soto on 2/16/14.
//  Copyright (c) 2014 MindSnacks. All rights reserved.
//

#import "MSPageViewControllerExample.h"

@implementation MSPageViewControllerExample

+ (void)initialize {
    if (self == MSPageViewControllerExample.class) {
      //  UIPageControl *pageControl = UIPageControl.appearance;
       // pageControl.pageIndicatorTintColor = UIColor.blackColor;
       // pageControl.currentPageIndicatorTintColor = UIColor.redColor;
    }
}

-(void)viewDidLoad {
    self.infiniteScrolling = YES; // Can be set to YES if you want continuous scrolling horizontally
                                    // Otherwise it is automatically NO
    [super viewDidLoad];
}

- (NSArray *)pageIdentifiers {
    return @[@"page1", @"page2", @"page3", @"page4"];
}

@end
