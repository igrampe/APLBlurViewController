//
//  UIView+Blur.h
//  APL
//
//  Created by Sema Belokovsky on 05.09.15.
//  Copyright (c) 2015 App Plus. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (Blur)

- (UIImage *)snapshotBlurDarkStyle;
- (UIImage *)snapshotBlurLightStyle;
- (UIImage *)snapshotBlurExtraLightStyle;

- (UIImage *)blurredSnapshotWithRadius:(CGFloat)blurRadius
                             tintColor:(UIColor *)tintColor
                 saturationDeltaFactor:(CGFloat)saturationDeltaFactor
                             maskImage:(UIImage *)maskImage;

@end
