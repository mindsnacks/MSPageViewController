//
//  UIViewController+MSPageViewController.m
//  MSPageViewController
//
//  Created by Christoph Keller on 04.12.14.
//

#import "UIViewController+MSPageViewController.h"
#import <objc/runtime.h>

static char kMSPageViewControllerPageIndexKey;

@implementation UIViewController (MSPageViewController)

- (NSInteger)pageIndex {
    NSNumber *number = (NSNumber *)objc_getAssociatedObject(self, &kMSPageViewControllerPageIndexKey);
    return [number integerValue];
}

- (void)setPageIndex:(NSInteger)pageIndex {
    objc_setAssociatedObject(self, &kMSPageViewControllerPageIndexKey, @(pageIndex), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

@end