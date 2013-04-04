//
//  MXNCheckedCell.m
//  MXNSlidingBoilerplate
//
//  Created by Brad Philips on 3/26/13.
//  Copyright (c) 2013 Mixin Mobile, LLC. All rights reserved.
//

#import "MXNCheckedCell.h"

@implementation MXNCheckedCell
@synthesize checked;

- (void)finishConstruction {
  [super finishConstruction];
  self.selectionStyle = UITableViewCellSelectionStyleGray;
  self.accessoryType = UITableViewCellAccessoryNone;
  self.textLabel.textAlignment = UITextAlignmentLeft;
  
  [self setSelected:NO];
}

- (void)configureForData:(id)dataObject tableView:(UITableView *)aTableView indexPath:(NSIndexPath *)anIndexPath {
  [super configureForData:dataObject tableView:aTableView indexPath:anIndexPath];
  selector = NSSelectorFromString([dataObject objectForKey:@"selector"]);
  viewController = (PageViewController *)aTableView.delegate;
}

- (void)handleSelectionInTableView:(UITableView *)aTableView {
  [super handleSelectionInTableView:aTableView];
  self.checked = !self.checked;
  if (self.checked) {
    self.accessoryType = UITableViewCellAccessoryCheckmark;
  } else {
    self.accessoryType = UITableViewCellAccessoryNone;
  }
  
  if ([viewController respondsToSelector:selector]) {
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Warc-performSelector-leaks"
    [viewController performSelector:selector withObject:self];
#pragma clang diagnostic pop
  }
}

@end
