//
//  MXNMenuViewController.m
//  MXNSlidingBoilerplate
//
//  Created by Brad Philips on 2/28/13.
//  Copyright (c) 2013 Mixin Mobile, LLC. All rights reserved.
//

#import "ECSlidingViewController.h"
#import "MXNMenuViewController.h"
#import "MXNSlideNavigationController.h"
#import "UINavigationBar+Background.h"

@interface MXNMenuViewController () <UITableViewDataSource, UITableViewDelegate> {
  NSArray *_menuItems;
  NSArray *_menuControllers;
  
  __unsafe_unretained IBOutlet UITableView *_menuTable;
}

@end

@implementation MXNMenuViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
      _menuItems = @[ @"Main", @"Second" ];
      _menuControllers = @[ @"MXNMainViewController", @"MXNSecondViewController" ];
    }
    return self;
}

#pragma mark - View Lifecycle

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark - UITableView Delegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
  return _menuItems.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
  static NSString *cellIdentifier = @"MXNMenuItemCell";
  UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
  if (cell == nil) {
    cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellIdentifier];
  }
  
  cell.textLabel.text = [_menuItems objectAtIndex:indexPath.row];
  return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
  [tableView deselectRowAtIndexPath:indexPath animated:YES];
  
  Class newTopViewControllerClass = NSClassFromString([_menuControllers objectAtIndex:indexPath.row]);
  UIViewController *newTopViewController =  [[newTopViewControllerClass alloc] init];
  
  MXNSlideNavigationController *newTopNavController = [[MXNSlideNavigationController alloc] initWithRootViewController:newTopViewController];
  [newTopNavController.navigationBar setBackground];
  
  [self.slidingViewController anchorTopViewOffScreenTo:ECRight animations:nil onComplete:^{
    CGRect frame = self.slidingViewController.topViewController.view.frame;
    self.slidingViewController.topViewController = newTopNavController;
    self.slidingViewController.topViewController.view.frame = frame;
    [self.slidingViewController resetTopView];
  }];
}

@end
