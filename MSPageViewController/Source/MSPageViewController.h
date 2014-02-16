//
//  MSPageViewController.h
//  MSPageViewController
//
//  Created by Nacho Soto on 2/16/14.
//  Copyright (c) 2014 MindSnacks. All rights reserved.
//

#import <UIKit/UIKit.h>

/**
 * This controller is only meant to be used inside of a storyboard.
 * @see `MSPageViewController+Protected.h` for subclassing notes.
 */
@interface MSPageViewController : UIPageViewController

@end

@protocol MSPageViewControllerChild <NSObject>

@property (nonatomic) NSInteger pageIndex;

@end