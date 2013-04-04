//
//  MXNSecondViewController.m
//  MXNSlidingBoilerplate
//
//  Created by Brad Philips on 4/3/13.
//  Copyright (c) 2013 Mixin Mobile. All rights reserved.
//

#import "MXNSecondViewController.h"

@interface MXNSecondViewController ()

@end

@implementation MXNSecondViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
  self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
  if (self) {
    self.title = NSLocalizedString(@"Second", @"Second");
  }
  return self;
}

- (NSString *)nibName {
  return @"MXNSecondView";
}

- (void)viewDidLoad {
  [super viewDidLoad];
}

- (void)didReceiveMemoryWarning {
  [super didReceiveMemoryWarning];
}

@end
