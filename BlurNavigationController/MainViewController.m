//
//  ViewController.m
//  BlurNavigationController
//
//  Created by Semyon Belokovsky on 06/09/15.
//  Copyright (c) 2015 App Plus. All rights reserved.
//

#import "MainViewController.h"
#import "SecondViewController.h"

#import "APLBlurNavigationController.h"

@implementation MainViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
}

- (IBAction)tap:(id)sender
{
    SecondViewController *ctl = (SecondViewController *)[self.storyboard instantiateViewControllerWithIdentifier:@"SecondViewController"];
    APLBlurNavigationController *navCtl = [[APLBlurNavigationController alloc] initWithRootViewController:ctl];
    navCtl.modalPresentationStyle = UIModalPresentationOverCurrentContext;
    [self blur_presentViewController:navCtl animated:YES completion:nil];
}

@end
