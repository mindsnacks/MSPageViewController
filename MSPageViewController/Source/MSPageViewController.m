//
//  MSPageViewController.m
//  MSPageViewController
//
//  Created by Nacho Soto on 2/16/14.
//  Copyright (c) 2014 MindSnacks. All rights reserved.
//

#import "MSPageViewController.h"
#import "MSPageViewController+Protected.h"

@implementation MSPageViewController

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

#pragma mark - Public

- (NSInteger)pageCount {
    return (NSInteger)self.pageIdentifiers.count;
}

- (NSInteger)currentPageIndex {
    return [self.viewControllers.lastObject pageIndex];
}

- (BOOL)moveToPageAtIndex:(NSInteger)index animated:(BOOL)animated completion:(void (^)(BOOL))completion {
    UIViewController *viewController = [self viewControllerAtIndex:index];
    
    if (viewController != nil && index != self.currentPageIndex) {
        if (index < self.currentPageIndex) {
            [self setViewControllers:@[viewController]
                           direction:UIPageViewControllerNavigationDirectionReverse
                            animated:animated
                          completion:completion];
        } else {
            [self setViewControllers:@[viewController]
                           direction:UIPageViewControllerNavigationDirectionForward
                            animated:animated
                          completion:completion];
        }
        return true;
    }
    return false;
}

#pragma mark - Protected

- (void)ms_setUp {
    self.dataSource = self;
}

- (NSArray *)pageIdentifiers {
    [self doesNotRecognizeSelector:_cmd];
    
    return nil;
}

- (void)setUpViewController:(UIViewController<MSPageViewControllerChild> *)viewController
                    atIndex:(NSInteger)index {
    
}

- (UIStoryboard *)storyboardWithName:(NSString *)name index:(NSInteger) storyboardIndex {
    return [UIStoryboard storyboardWithName: name bundle: nil];
}

- (UIViewController *)instantiateViewControllerWithIdentifier:(NSString*)identifier storyboard:(UIStoryboard*) fromStoryboard {
    return [fromStoryboard instantiateViewControllerWithIdentifier:identifier];
}

#pragma mark -

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSAssert(self.pageCount > 0, @"%@ has no pages", self);
    
    [self setViewControllers:@[[self viewControllerAtIndex:0]]
                   direction:UIPageViewControllerNavigationDirectionForward
                    animated:NO
                  completion:nil];
    
    if (self.pageCount == 1) {
        self.view.userInteractionEnabled = NO;
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
        
        result = [self instantiateViewController: self.pageIdentifiers[(NSUInteger)index] withIndex:index];
        
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

- (NSInteger)presentationCountForPageViewController:(MSPageViewController *)pageViewController {
    const BOOL shouldShowPageControl = (pageViewController.pageCount > 1);
    
    return (shouldShowPageControl) ? pageViewController.pageCount : 0;
}

- (NSInteger)presentationIndexForPageViewController:(UIPageViewController *)pageViewController {
    return [pageViewController.viewControllers.lastObject pageIndex];
}

#pragma mark ViewController instantiation
-(UIViewController<MSPageViewControllerChild> *)instantiateViewController:(NSString*)identifier withIndex: (NSInteger) index {
    UIViewController<MSPageViewControllerChild> *result = nil;
    
    UIStoryboard* storyboard = self.storyboard;
    
    NSArray* storyboardAndIdentifier = [identifier componentsSeparatedByString: @":"];
    
    if (storyboardAndIdentifier.count == 2) {
        storyboard = [self storyboardWithName: storyboardAndIdentifier[0] index: index];
        identifier = storyboardAndIdentifier[1];
        NSAssert(storyboard, @"Unable to find specified Storyboard by name");
        NSAssert([identifier length] > 0, @"Specified identified should not be empty");
    }
    result = (UIViewController<MSPageViewControllerChild>*)[self instantiateViewControllerWithIdentifier:identifier storyboard: storyboard];
    
    NSParameterAssert(result);
    return result;
}


@end
