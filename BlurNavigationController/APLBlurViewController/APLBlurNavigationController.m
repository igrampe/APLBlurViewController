//
//  APLBlurNavigationController.m
//  Blurtest
//
//  Created by Semyon Belokovsky on 04/09/15.
//  Copyright (c) 2015 App Plus. All rights reserved.
//

#import "APLBlurNavigationController.h"

#import "UIView+Blur.h"

typedef NS_ENUM(NSInteger, APLBlurNavigationControllerState) {
    APLBlurNavigationControllerStateNormal = 0,
    APLBlurNavigationControllerStatePushing = 1,
    APLBlurNavigationControllerStatePopping = 2
};

@implementation UIViewController (APLBlurNavigationController)

- (void)blur_presentViewController:(UIViewController *)viewControllerToPresent
                          animated:(BOOL)flag
                        completion:(void (^)(void))completion
{
    if ([viewControllerToPresent isKindOfClass:[APLBlurNavigationController class]])
    {
        APLBlurNavigationController *bnc = (APLBlurNavigationController *)viewControllerToPresent;
        
        bnc.blurView.image = [self.view blurredSnapshotWithRadius:bnc.blurRadius
                                                        tintColor:bnc.tintColor
                                            saturationDeltaFactor:bnc.saturationDeltaFactor
                                                        maskImage:nil];
        CGSize size = self.view.bounds.size;
        
        bnc.blurView.frame = CGRectMake(0, -size.height, size.width, size.height);
        
        [self presentViewController:viewControllerToPresent animated:flag completion:completion];
        
        [self.transitionCoordinator animateAlongsideTransition:^(id<UIViewControllerTransitionCoordinatorContext> context)
        {
            bnc.blurView.frame = CGRectMake(0, 0, size.width, size.height);
        }
                                                    completion:nil];
    } else
    {
        [self presentViewController:viewControllerToPresent animated:flag completion:completion];
    }
}

- (void)blur_dismissViewControllerAnimated:(BOOL)animated
                               completion:(void (^)(void))completion
{
    if ([self isKindOfClass:[APLBlurNavigationController class]])
    {
        APLBlurNavigationController *bnc = (APLBlurNavigationController *)self;
        
        [self dismissViewControllerAnimated:animated completion:completion];
        
        CGSize size = self.view.bounds.size;
        
        [self.transitionCoordinator animateAlongsideTransition:^(id<UIViewControllerTransitionCoordinatorContext> context)
        {
             bnc.blurView.frame = CGRectMake(0, -size.height, size.width, size.height);
        }
                                                    completion:nil];

    } else
    {
        [self dismissViewControllerAnimated:YES completion:nil];
    }
}

@end

@class APLBlurNavigationControllerManager;

@interface APLBlurNavigationController ()

@property APLBlurNavigationControllerState state;
@property UIColor *transitioningCtlColor;
@property APLBlurNavigationControllerManager *manager;

@end

@interface APLBlurNavigationControllerManager : NSObject <UINavigationControllerDelegate>

@end

@implementation APLBlurNavigationControllerManager

- (void)navigationController:(UINavigationController *)navigationController
      willShowViewController:(UIViewController *)viewController
                    animated:(BOOL)animated
{
    if ([navigationController isKindOfClass:[APLBlurNavigationController class]])
    {
        APLBlurNavigationController *bnc = (APLBlurNavigationController *)navigationController;
        if (animated)
        {
            if (bnc.state == APLBlurNavigationControllerStatePushing)
            {
                bnc.transitioningCtlColor = viewController.view.backgroundColor;
                viewController.view.backgroundColor = [UIColor whiteColor];
            }
        }
    }
}

- (void)navigationController:(UINavigationController *)navigationController
       didShowViewController:(UIViewController *)viewController
                    animated:(BOOL)animated
{
    if ([navigationController isKindOfClass:[APLBlurNavigationController class]])
    {
        APLBlurNavigationController *bnc = (APLBlurNavigationController *)navigationController;
        if (animated)
        {
            if (bnc.state == APLBlurNavigationControllerStatePushing)
            {
                [UIView animateWithDuration:0.3 animations:
                 ^{
                     viewController.view.backgroundColor = bnc.transitioningCtlColor;
                 } completion:
                 ^(BOOL finished) {
                     bnc.transitioningCtlColor = nil;
                 }];
            }
        }
        bnc.state = APLBlurNavigationControllerStateNormal;
    }
}

@end

@implementation APLBlurNavigationController

@synthesize blurView;

- (instancetype)initWithRootViewController:(UIViewController *)rootViewController
{
    self = [super initWithRootViewController:rootViewController];
    if (self)
    {
        [self commonInit];
    }
    return self;
}

- (instancetype)initWithNavigationBarClass:(Class)navigationBarClass toolbarClass:(Class)toolbarClass
{
    self = [super initWithNavigationBarClass:navigationBarClass toolbarClass:toolbarClass];
    if (self)
    {
        [self commonInit];
    }
    return self;
}

- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self)
    {
        [self commonInit];
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self)
    {
        [self commonInit];
    }
    return self;
}

- (void)commonInit
{
    self.manager = [APLBlurNavigationControllerManager new];
    self.delegate = self.manager;
    self.blurRadius = 30;
    self.tintColor = [UIColor colorWithWhite:1.0 alpha:0.3];
    self.saturationDeltaFactor = 1.8;
}

- (void)loadView
{
    [super loadView];
    self.view.layer.masksToBounds = YES;
    self.blurView = [UIImageView new];
    [self.view addSubview:self.blurView];
    [self.view sendSubviewToBack:self.blurView];
}

- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    self.state = APLBlurNavigationControllerStatePushing;
    [super pushViewController:viewController animated:animated];
}

- (UIViewController *)popViewControllerAnimated:(BOOL)animated
{
    self.topViewController.view.backgroundColor = [UIColor whiteColor];
    self.state = APLBlurNavigationControllerStatePopping;
    return [super popViewControllerAnimated:animated];
}

@end
