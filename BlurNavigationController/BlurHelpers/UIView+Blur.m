//
//  UIView+Blur.m
//  APL
//
//  Created by Sema Belokovsky on 05.09.15.
//  Copyright (c) 2015 App Plus. All rights reserved.
//

#import "UIView+Blur.h"

#import <QuartzCore/QuartzCore.h>

#import "UIImage+ImageEffects.h"

@implementation UIView (Blur)



- (UIImage *)blurredSnapshotWithRadius:(CGFloat)blurRadius
                             tintColor:(UIColor *)tintColor
                 saturationDeltaFactor:(CGFloat)saturationDeltaFactor
                             maskImage:(UIImage *)maskImage
{
    UIImage *snapshotImage = [self snapshotImage];
    UIImage *blurredSnapshotImage = [snapshotImage applyBlurWithRadius:blurRadius
                                                             tintColor:tintColor
                                                 saturationDeltaFactor:saturationDeltaFactor
                                                             maskImage:maskImage];
    
    return blurredSnapshotImage;

}

- (UIImage *)snapshotImage
{
    UIGraphicsBeginImageContextWithOptions(self.bounds.size, NO, self.window.screen.scale);
    
    if ([UIDevice currentDevice].systemVersion.floatValue < 7.0)
    {
        [self.layer renderInContext:UIGraphicsGetCurrentContext()];
    } else
    {
        [self drawViewHierarchyInRect:self.frame afterScreenUpdates:NO];
    }
    
    UIImage *snapshotImage = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    return snapshotImage;
}

- (UIImage *)snapshotBlurDarkStyle
{
    UIImage *snapshotImage = [self snapshotImage];
    UIImage *blurredSnapshotImage = [snapshotImage applyDarkEffect];
    return blurredSnapshotImage;
}

- (UIImage *)snapshotBlurLightStyle
{
    
    UIImage *snapshotImage = [self snapshotImage];
    UIImage *blurredSnapshotImage = [snapshotImage applyLightEffect];
    return blurredSnapshotImage;
}

- (UIImage *)snapshotBlurExtraLightStyle
{
    UIImage *snapshotImage = [self snapshotImage];
    UIImage *blurredSnapshotImage = [snapshotImage applyExtraLightEffect];
    return blurredSnapshotImage;
}

@end
