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
        UIPageControl *pageControl = UIPageControl.appearance;
        pageControl.pageIndicatorTintColor = UIColor.blackColor;
        pageControl.currentPageIndicatorTintColor = UIColor.redColor;
    }
}

// If not supplied in the subclass, the pages can be supplied with a runtime string attribute "pages" in the Storyboard, i.e. "page1,page2,page3,page4"
- (NSArray *)pageIdentifiers {
    return @[@"page1", @"page2", @"page3", @"page4"];
}

@end
