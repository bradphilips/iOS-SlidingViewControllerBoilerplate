//
//  MXNBaseSlideViewController.m
//  MXNSlidingBoilerplate
//
//  Created by Brad Philips on 2/28/13.
//  Copyright (c) 2013 Mixin Mobile, LLC. All rights reserved.
//

#import "MXNBaseSlideViewController.h"
#import "ECSlidingViewController.h"

@interface MXNBaseSlideViewController ()

@end

@implementation MXNBaseSlideViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
  self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
  if (self) {
  }
  return self;
}

- (void)viewDidLoad {
  [super viewDidLoad];
  
  UIImageView *menuIcon = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"menu_icon"]];
  [menuIcon setFrame:CGRectMake(5, 0, 20, 14)];
  
  UIButton *imageButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 25, 14)];
  imageButton.contentMode = UIViewContentModeTopRight;
  [imageButton addTarget:self action:@selector(openMenu:) forControlEvents:UIControlEventTouchUpInside];
  [imageButton addSubview:menuIcon];
  
  UIBarButtonItem *leftMenuButton = [[UIBarButtonItem alloc] initWithCustomView:imageButton];
  self.navigationItem.leftBarButtonItem = leftMenuButton;
}

- (void)didReceiveMemoryWarning {
  [super didReceiveMemoryWarning];
}

- (IBAction)openMenu:(id)sender {
  [self.slidingViewController anchorTopViewTo:ECRight];
}

@end
