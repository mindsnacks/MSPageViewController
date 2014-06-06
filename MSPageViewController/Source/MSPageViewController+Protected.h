//
//  MSPageViewController+Protected.h
//  MSPageViewController
//
//  Created by Nacho Soto on 2/16/14.
//  Copyright (c) 2014 MindSnacks. All rights reserved.
//

#import "MSPageViewController.h"

/**
 * Subclassing notes:
 *  Child view controllers must conform to `MSPageViewControllerChild`.
 *
 * @see `MSPageViewControllerPage`.
 */
@interface MSPageViewController () <UIPageViewControllerDataSource>

/**
 * @note Must be overridden.
 * @discussion The pages for this page view controller
 * will be instantiated from `self.storyboard`.
 */
- (NSArray *)pageIdentifiers;

/**
 * Can be overriden to perform additional configuration on the controller.
 */
- (void)setUpViewController:(UIViewController<MSPageViewControllerChild> *)viewController
                    atIndex:(NSInteger)index __attribute((objc_requires_super));

/**
 * @discussion this method can be used to programatically navigate to a page.
 */
- (UIViewController *)viewControllerAtIndex:(NSInteger)index;

@end
