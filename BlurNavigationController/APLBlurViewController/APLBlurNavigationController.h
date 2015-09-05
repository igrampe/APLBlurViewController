//
//  APLBlurNavigationController.h
//  Blurtest
//
//  Created by Semyon Belokovsky on 04/09/15.
//  Copyright (c) 2015 App Plus. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIViewController (APLBlurNavigationController)

- (void)blur_presentViewController:(UIViewController *)viewControllerToPresent
                          animated:(BOOL)flag
                        completion:(void (^)(void))completion;

- (void)blur_dismissViewControllerAnimated:(BOOL)animated
                                completion:(void (^)(void))completion;

@end

@interface APLBlurNavigationController : UINavigationController

@property UIImageView *blurView;
@property CGFloat blurRadius;
@property UIColor *tintColor;
@property CGFloat saturationDeltaFactor;

@end
