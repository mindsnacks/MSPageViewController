//
//  MSPageViewController.m
//  MSPageViewController
//
//  Created by Nacho Soto on 2/16/14.
//  Copyright (c) 2014 MindSnacks. All rights reserved.
//

#import "MSPageViewController.h"
#import "MSPageViewController+Protected.h"

@implementation MSPageViewController {
    UIPageControl *_transparentPageControl;
}

- (id)initWithTransitionStyle:(UIPageViewControllerTransitionStyle)style
        navigationOrientation:(UIPageViewControllerNavigationOrientation)navigationOrientation
                      options:(NSDictionary *)options {
    if ((self = [super initWithTransitionStyle:style
                         navigationOrientation:navigationOrientation
                                       options:options])) {
        [self ms_setUp];
    }
    
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder {
    if ((self = [super initWithCoder:aDecoder])) {
        [self ms_setUp];
    }
    
    return self;
}

#pragma mark - Protected

- (void)ms_setUp {
    self.dataSource = self;
}

- (NSArray *)pageIdentifiers {
    //try to build from runtime attribute string
    if (self.ms_pages) {
        return [self.ms_pages componentsSeparatedByString:@","];
    }
    [self doesNotRecognizeSelector:_cmd];
    
    return nil;
}

- (NSInteger)pageCount {
    return (NSInteger)self.pageIdentifiers.count;
}

- (void)setUpViewController:(UIViewController<MSPageViewControllerChild> *)viewController
                    atIndex:(NSInteger)index {
    
}

#pragma mark - View lifecycle

- (void)viewDidLoad {
    [super viewDidLoad];
    self.delegate = self;
    NSInteger pageCount = self.pageCount;
    NSAssert(pageCount > 0, @"%@ has no pages", self);
    
    [self setViewControllers:@[[self viewControllerAtIndex:0]]
                   direction:UIPageViewControllerNavigationDirectionForward
                    animated:NO
                  completion:nil];
    
    if (pageCount == 1) {
        self.view.userInteractionEnabled = NO;
    }
    if (self.ms_transparentControl && pageCount > 1) {
        CGSize viewSize = self.view.frame.size;
        CGSize preferredSize = [[UIPageControl new] sizeForNumberOfPages:pageCount];
        // This should be 37.0f, but its best not to hard code it.
        CGFloat defaultHeight = preferredSize.height;
        CGFloat yPos = viewSize.height - defaultHeight ;
        _transparentPageControl = [[UIPageControl alloc]initWithFrame:CGRectMake(0.0f, yPos, preferredSize.width, defaultHeight)];
        _transparentPageControl.numberOfPages = pageCount;
        
        [_transparentPageControl addTarget:self action:@selector(pageChanged:) forControlEvents:UIControlEventValueChanged];

        [self.view addSubview:_transparentPageControl];
    }
}

#pragma mark - UIPageViewControllerDataSource

- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController
      viewControllerBeforeViewController:(UIViewController<MSPageViewControllerChild> *)viewController {
    const NSInteger index = viewController.pageIndex;
    
    return (index == NSNotFound) ? nil : [self viewControllerAtIndex:index - 1];
}

- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController
       viewControllerAfterViewController:(UIViewController<MSPageViewControllerChild> *)viewController {
    const NSInteger index = viewController.pageIndex;
    
    return (index == NSNotFound) ? nil : [self viewControllerAtIndex:index + 1];
}

- (UIViewController *)viewControllerAtIndex:(NSInteger)index {
    UIViewController<MSPageViewControllerChild> *result = nil;
    
    if (index >= 0 && index < self.pageCount) {
        NSAssert(self.storyboard,
                 @"This controller is only meant to be used inside of a UIStoryboard");
        
        result = [self.storyboard instantiateViewControllerWithIdentifier:self.pageIdentifiers[(NSUInteger)index]];
        
        NSParameterAssert(result);
        NSAssert([result conformsToProtocol:@protocol(MSPageViewControllerChild)],
                 @"Child view controller (%@) must conform to %@",
                 result,
                 NSStringFromProtocol(@protocol(MSPageViewControllerChild)));
        
        result.pageIndex = index;
        
        [self setUpViewController:result
                          atIndex:index];
    }
    
    return result;
}

- (NSInteger)presentationCountForPageViewController:(UIPageViewController *)pageViewController {
    NSInteger pageCount = self.pageCount;
    return !self.ms_transparentControl && pageCount > 1 ? pageCount : 0;
}

- (NSInteger)presentationIndexForPageViewController:(UIPageViewController *)pageViewController {
    return 0;
}

#pragma mark - UIPageViewControllerDelegate

- (void)pageViewController:(UIPageViewController *)pageViewController didFinishAnimating:(BOOL)finished previousViewControllers:(NSArray *)previousViewControllers transitionCompleted:(BOOL)completed {
    if (completed) {
        UIViewController <MSPageViewControllerChild> *currentVC = pageViewController.viewControllers[0];
        NSLog(@"Current: %@, index: %i", currentVC, currentVC.pageIndex);
        _transparentPageControl.currentPage = currentVC.pageIndex;
    }
}

#pragma mark - UIPageControl events

-(void)pageChanged:(UIPageControl*)pageControl {
    [self setViewControllers:@[[self viewControllerAtIndex:pageControl.currentPage]]
                   direction:UIPageViewControllerNavigationDirectionForward
                    animated:NO
                  completion:nil];
}

@end
