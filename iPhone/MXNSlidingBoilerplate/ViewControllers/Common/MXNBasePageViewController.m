//
//  MXNBasePageViewController.m
//  MXNSlidingBoilerplate
//
//  Created by Brad Philips on 3/6/13.
//  Copyright (c) 2013 Mixin Mobile, LLC. All rights reserved.
//

#import "MXNBasePageViewController.h"
#import "ECSlidingViewController.h"
#import "TextFieldCell.h"

@interface MXNBasePageViewController ()<UITextFieldDelegate> {
  UITextField *_currentResponder;
}

@end

@implementation MXNBasePageViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
  self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
  if (self) {
    _showMenu = YES;
  }
  return self;
}

- (void)viewDidLoad {
  [super viewDidLoad];
  
  if (_showMenu) {
    UIImageView *menuIcon = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"menu_icon"]];
    [menuIcon setFrame:CGRectMake(5, 0, 20, 14)];
    
    UIButton *imageButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 25, 14)];
    imageButton.contentMode = UIViewContentModeTopRight;
    [imageButton addTarget:self action:@selector(openMenu:) forControlEvents:UIControlEventTouchUpInside];
    [imageButton addSubview:menuIcon];
    
    UIBarButtonItem *leftMenuButton = [[UIBarButtonItem alloc] initWithCustomView:imageButton];
    self.navigationItem.leftBarButtonItem = leftMenuButton;
  }
  
  UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self
                                                                        action:@selector(dismissKeyboard:)];
  tap.cancelsTouchesInView = NO;
  [self.view addGestureRecognizer:tap];
}

- (void)didReceiveMemoryWarning {
  [super didReceiveMemoryWarning];
}

- (IBAction)openMenu:(id)sender {
  [self.slidingViewController anchorTopViewTo:ECRight];
}

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField {
  TextFieldCell *cell = (TextFieldCell *)[self getCellForTextView:textField];
  NSIndexPath *indexPath = [self.tableView indexPathForCell:cell];
  
  self.tableView.contentInset =  UIEdgeInsetsMake(0, 0, 120, 0);
  [self.tableView selectRowAtIndexPath:indexPath
                           animated:YES
                     scrollPosition:UITableViewScrollPositionTop];
  
  _currentResponder = textField;
  return YES;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
  TextFieldCell *cell = (TextFieldCell *)[self getCellForTextView:textField];
  
  if (cell != nil && [cell validateField]) {
    [self setTextField:cell];
    [self moveNextFromTextView:textField];
    return YES;
  }
  return NO;
}

- (void)textFieldDidEndEditing:(UITextField *)textField {
  TextFieldCell *cell = (TextFieldCell *)[self getCellForTextView:textField];
  
  if (cell != nil && [cell validateField]) {
    [self setTextField:cell];
  }
}

- (TextFieldCell *)getCellForTextView:(UITextField *)textView {
  for (UIView* next = [textView superview]; next; next = next.superview) {
    if ([next isKindOfClass:[TextFieldCell class]]) {
      return (TextFieldCell *)next;
    }
  }
  return nil;
}

- (void)moveNextFromTextView:(UITextField *)field {
  NSInteger nextTag = field.tag + 1;
  UIResponder* nextResponder = [self.tableView viewWithTag:nextTag];
  if (nextResponder) {
    [nextResponder becomeFirstResponder];
  } else {
    self.tableView.contentInset =  UIEdgeInsetsMake(0, 0, 0, 0);
    [field resignFirstResponder];
  }
}

- (IBAction)dismissKeyboard:(id)sender {
  [_currentResponder resignFirstResponder];
}

- (BOOL)validateModel {
  for (int s = 0; s < [tableSections count]; s++) {
    NSArray *tableRows = [tableSections objectAtIndex:s];
    for (int r = 0; r < [tableRows count]; r++) {
      NSIndexPath *indexPath = [NSIndexPath indexPathForRow:r inSection:s];
      PageCell *cell = (PageCell *)[self.tableView cellForRowAtIndexPath:indexPath];
      NSDictionary *data = [self dataForRow:r inSection:s];
      
      if ([self validateCell:cell withData:data] == NO) {
        return NO;
      }
    }
  }
  return YES;
}

- (BOOL)validateCell:(PageCell *)cell withData:(NSDictionary *)data {
  if ([cell isKindOfClass:[TextFieldCell class]]) {
    TextFieldCell *textField = (TextFieldCell *)cell;
    if ([textField validateField] == NO) {
      return NO;
    }
  }
  
  return YES;
}

- (void)setTextField:(TextFieldCell *)cell { /* Meant to be overriden to set model fields */ }

@end
