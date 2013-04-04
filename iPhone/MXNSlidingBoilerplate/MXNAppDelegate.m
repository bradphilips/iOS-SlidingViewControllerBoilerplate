//
//  MXNAppDelegate.m
//  MXNSlidingBoilerplate
//
//  Created by Brad Philips on 2/27/13.
//  Copyright (c) 2013 Mixin Mobile, LLC. All rights reserved.
//

#import "MXNAppDelegate.h"
#import "MXNConfigurationData.h"
#import "MXNLoginViewController.h"
#import "MXNMainViewController.h"
#import "MXNSlideNavigationController.h"

#import "MBProgressHUD.h"
#import "ECSlidingViewController.h"
#import "UINavigationBar+Background.h"

@interface MXNAppDelegate () {
  MBProgressHUD *_progressIndicator;
}

@end

@implementation MXNAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
  self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
  _progressIndicator = [[MBProgressHUD alloc] initWithWindow:self.window];
  _progressIndicator.xOffset = 0;
  _progressIndicator.yOffset = 0;
  [self.window addSubview:_progressIndicator];
  
  ECSlidingViewController *rootViewController = [[ECSlidingViewController alloc] init];
  UIViewController *mainViewController = nil;
  MXNConfigurationData *configData = [MXNConfigurationData sharedConfiguration];
  if (!configData.isLoggedIn) {
    mainViewController = [[MXNLoginViewController alloc] init];
  } else {
    mainViewController = [[MXNMainViewController alloc] init];
  }
  
  MXNSlideNavigationController *slideNavigationController = [[MXNSlideNavigationController alloc] initWithRootViewController:mainViewController];
  rootViewController.topViewController = slideNavigationController;
  [slideNavigationController.navigationBar setBackground];
  
  [self.window setRootViewController:rootViewController];
  
  self.window.backgroundColor = [UIColor whiteColor];
  [self.window makeKeyAndVisible];
  return YES;
}

#pragma mark - MBProgressHUD

+ (MXNAppDelegate *)appDelegate {
  return (MXNAppDelegate *)[[UIApplication sharedApplication] delegate];
}

- (MBProgressHUD *)progressIndicator {
  return _progressIndicator;
}

+ (void)showProgressIndicator {
  [self showProgressIndicator:nil];
}

+ (void)showProgressIndicator:(NSString *)labelText withCenter:(CGPoint)center {
  MXNAppDelegate *appDelegate = [MXNAppDelegate appDelegate];
  [appDelegate progressIndicator].center = center;
  [self showProgressIndicator:labelText];
}

+ (void)showProgressIndicator:(NSString *)labelText {
  MXNAppDelegate *appDelegate = [MXNAppDelegate appDelegate];
  [appDelegate progressIndicator].labelFont = [UIFont systemFontOfSize:14.0];
  
  if(labelText) {
    [appDelegate progressIndicator].labelText = labelText;
  }
  else {
    [appDelegate progressIndicator].labelText = @"Please wait...";
  }
  
  [[appDelegate progressIndicator] show:YES];
  [appDelegate.window bringSubviewToFront:[appDelegate progressIndicator]];
}

+ (void)hideProgressIndicator {
  MXNAppDelegate *appDelegate = [MXNAppDelegate appDelegate];
  [[appDelegate progressIndicator] hide:YES];
}

+ (void)hideProgressIndicatorAfterDelay:(NSTimeInterval)delay {
  MXNAppDelegate *appDelegate = [MXNAppDelegate appDelegate];
  [[appDelegate progressIndicator] hide:YES afterDelay:delay];
}


@end
