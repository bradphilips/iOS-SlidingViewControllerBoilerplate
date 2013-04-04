//
//  MXNMainViewController.m
//  MXNSlidingBoilerplate
//
//  Created by Brad Philips on 4/3/13.
//  Copyright (c) 2013 Mixin Mobile, LLC. All rights reserved.
//

#import "MXNMainViewController.h"

@interface MXNMainViewController ()

@end

@implementation MXNMainViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
  self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
  if (self) {
    self.title = NSLocalizedString(@"Main", @"Main");
  }
  return self;
}

- (NSString *)nibName {
  return @"MXNMainView";
}

- (void)viewDidLoad {
  [super viewDidLoad];
}

- (void)didReceiveMemoryWarning {
  [super didReceiveMemoryWarning];
}

@end
