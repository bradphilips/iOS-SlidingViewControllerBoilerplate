//
//  MXNLoginViewController.m
//  MXNSlidingBoilerplate
//
//  Created by Brad Philips on 3/4/13.
//  Copyright (c) 2013 Mixin Mobile, LLC. All rights reserved.
//

#import "MXNLoginViewController.h"

#import "MXNAppDelegate.h"
#import "MXNConfigurationData.h"
#import "MXNMainViewController.h"
#import "MXNSlideNavigationController.h"
#import "MXNLoginService.h"

#import "ECSlidingViewController.h"
#import "UINavigationBar+Background.h"

#import "TextFieldCell.h"
#import "MXNButtonCell.h"

#define TEXT_FIELD            1000
#define USERNAME_TEXT_FIELD   TEXT_FIELD + 1
#define PASSWORD_TEXT_FIELD   TEXT_FIELD + 2

@interface MXNLoginViewController ()<UITableViewDataSource, UITableViewDelegate> {
  __unsafe_unretained IBOutlet UITableView *_loginTable;
  
  MXNLoginRequest *_loginRequest;
  MXNLoginService *_loginService;
  UITextField *_currentResponder;
}

@end

@implementation MXNLoginViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
  self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
  if (self) {
    self.title = NSLocalizedString(@"Login", @"Login");
    _loginRequest = [[MXNLoginRequest alloc] init];
    _loginService = [[MXNLoginService alloc] init];
  }
  return self;
}

- (NSString *)nibName {
  return @"MXNLoginView";
}

#pragma mark - View Lifecycle

- (void)viewDidLoad {
  [super viewDidLoad];
  self.navigationController.navigationBarHidden = YES;
  [self setTableView:_loginTable];
}

- (void)viewWillAppear:(BOOL)animated {
  [super viewWillAppear:animated];
  
  self.useCustomHeaders = YES;
}

- (void)viewDidAppear:(BOOL)animated {
  [super viewDidAppear:animated];
  [self setupTable];
}

- (void)didReceiveMemoryWarning {
  [super didReceiveMemoryWarning];
}

- (void)viewDidUnload {
  [self setTableView:nil];
  [super viewDidUnload];
}

#pragma mark - UITableView

- (void)setupTable {
  [self addSectionAtIndex:0 withAnimation:UITableViewRowAnimationLeft];
  [self appendRowToSection:0
                 cellClass:[TextFieldCell class]
                  cellData:
   @{ @"model":       _loginRequest,
      @"property":    @"username",
      @"placeholder": @"Username",
      @"isRequired":  @(YES),
      @"tag":         @(USERNAME_TEXT_FIELD),
   } withAnimation:UITableViewRowAnimationLeft];
  
  [self appendRowToSection:0
                 cellClass:[TextFieldCell class]
                  cellData:
   @{ @"model":       _loginRequest,
      @"property":    @"password",
      @"placeholder": @"Password",
      @"isRequired":  @(YES),
      @"secure":      @(YES),
      @"tag":         @(PASSWORD_TEXT_FIELD),
   } withAnimation:UITableViewRowAnimationLeft];
  
  [self addSectionAtIndex:1 withAnimation:UITableViewRowAnimationLeft];
  [self appendRowToSection:1
                 cellClass:[MXNButtonCell class]
                  cellData:
   @{ @"text":      @"Login",
      @"selector":  @"loginClicked:"
   } withAnimation:UITableViewRowAnimationLeft];
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
  if (section == 0) {
    return 140;
  }
  return 10;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
  if (section == 0) {
    UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"logo"]];
    imageView.autoresizingMask = (UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin |
                                  UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleBottomMargin);
    imageView.contentMode = UIViewContentModeCenter;
    
    return imageView;
  }
  return nil;
}

#pragma mark - Actions

- (IBAction)loginClicked:(id)sender {
  if (![self validateModel]) {
    return;
  }
  
  [MXNAppDelegate showProgressIndicator];
  [_loginService login:_loginRequest callback:^(MXNUser *user, NSError *error) {
    [MXNAppDelegate hideProgressIndicator];
    if(error) {
      UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error"
                                                      message:error.localizedDescription
                                                     delegate:nil
                                            cancelButtonTitle:@"OK"
                                            otherButtonTitles:nil];
      [alert show];
      return;
    }

    [self loggedIn:nil];
  }];
}

- (IBAction)loggedIn:(id)sender {
  [MXNAppDelegate hideProgressIndicator];
  MXNMainViewController *mainViewController = [[MXNMainViewController alloc] init];
  MXNSlideNavigationController *newTopNavController = [[MXNSlideNavigationController alloc] initWithRootViewController:mainViewController];
  [newTopNavController.navigationBar setBackground];

  self.slidingViewController.topViewController = newTopNavController;
  [self.slidingViewController resetTopView];
}

#pragma mark - Model Implementation

- (void)setTextField:(TextFieldCell *)cell {
  if (cell.textField.tag == USERNAME_TEXT_FIELD) {
    _loginRequest.username = cell.textField.text;
  }
  if (cell.textField.tag == PASSWORD_TEXT_FIELD) {
    _loginRequest.password = cell.textField.text;
  }
}

@end
