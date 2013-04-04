//
//  MXNSlideViewController.m
//  MXNSlidingBoilerplate
//
//  Created by Brad Philips on 2/28/13.
//  Copyright (c) 2013 Mixin Mobile, LLC. All rights reserved.
//

#import "MXNSlideNavigationController.h"
#import "ECSlidingViewController.h"
#import "MXNMenuViewController.h"

@interface MXNSlideNavigationController ()

@end

@implementation MXNSlideNavigationController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
  self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
  if (self) {
  }
  return self;
}

#pragma mark - View Lifecycle

- (void)viewDidLoad {
  [super viewDidLoad];
}

- (void)viewWillAppear:(BOOL)animated {
  [super viewWillAppear:animated];
  if (![self.slidingViewController.underLeftViewController isKindOfClass:[MXNMenuViewController class]]) {
    self.slidingViewController.underLeftViewController  = [[MXNMenuViewController alloc] init];
  }
  
  [self.view addGestureRecognizer:self.slidingViewController.panGesture];
  [self.slidingViewController setAnchorRightRevealAmount:280.0f];
}

- (void)didReceiveMemoryWarning {
  [super didReceiveMemoryWarning];
}

@end
