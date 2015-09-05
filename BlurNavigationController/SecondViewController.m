//
//  SecondViewController.m
//  BlurNavigationController
//
//  Created by Semyon Belokovsky on 06/09/15.
//  Copyright (c) 2015 App Plus. All rights reserved.
//

#import "SecondViewController.h"
#import "APLBlurNavigationController.h"

@interface SecondViewController ()

@end

@implementation SecondViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor clearColor];
}

- (IBAction)tap:(id)sender
{
    [self.navigationController blur_dismissViewControllerAnimated:self completion:nil];
}

@end
