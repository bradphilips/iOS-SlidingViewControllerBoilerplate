//
//  MXNActionSheetCell.m
//  MXNSlidingBoilerplate
//
//  Created by Brad Philips on 2/27/13.
//
//  This software is provided 'as-is', without any express or implied
//  warranty. In no event will the authors be held liable for any damages
//  arising from the use of this software. Permission is granted to anyone to
//  use this software for any purpose, including commercial applications, and to
//  alter it and redistribute it freely, subject to the following restrictions:
//
//  1. The origin of this software must not be misrepresented; you must not
//     claim that you wrote the original software. If you use this software
//     in a product, an acknowledgment in the product documentation would be
//     appreciated but is not required.
//  2. Altered source versions must be plainly marked as such, and must not be
//     misrepresented as being the original software.
//  3. This notice may not be removed or altered from any source
//     distribution.
//

#import "MXNActionSheetCell.h"
#import "ActionSheetStringPicker.h"

@implementation MXNActionSheetCell
@synthesize items;
@synthesize title;
@synthesize selected;

- (void)finishConstruction {
  [super finishConstruction];
  self.selectionStyle = UITableViewCellSelectionStyleGray;
}

- (void)configureForData:(id)dataObject tableView:(UITableView *)aTableView indexPath:(NSIndexPath *)anIndexPath {
  [super configureForData:dataObject tableView:aTableView indexPath:anIndexPath];
  self.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
  
  self.title = [dataObject objectForKey:@"title"];
  
  NSObject *model = [dataObject objectForKey:@"model"];
  NSString *property = [dataObject objectForKey:@"property"];
  selector = NSSelectorFromString([dataObject objectForKey:@"selector"]);
  viewController = (PageViewController *)aTableView.delegate;
  [viewController dismissKeyboard:aTableView];
  
  self.selected = [model valueForKeyPath:property];
  self.items = [dataObject objectForKey:@"items"];
  self.textField.enabled = NO;
  
  self.textField.text = selected;
}

- (void)handleSelectionInTableView:(UITableView *)aTableView {
  int selectedIndex = self.selected == nil ? 0 : [self.items indexOfObject:self.selected];
  [ActionSheetStringPicker showPickerWithTitle:self.title
                                          rows:self.items
                              initialSelection:selectedIndex
                                     doneBlock:^(ActionSheetStringPicker *picker, NSInteger selectedIndex, id selectedValue) {
                                       [self selectItem:[NSNumber numberWithInteger:selectedIndex] sender:picker];
                                     } cancelBlock:nil
                                        origin:self];
}

- (void)selectItem:(NSNumber *)selectedIndex sender:(id)sender {
  NSString *selectedItem = [self.items objectAtIndex:[selectedIndex intValue]];
  if ([viewController respondsToSelector:selector]) {
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Warc-performSelector-leaks"
    [viewController performSelector:selector withObject:selectedItem];
#pragma clang diagnostic pop    
  }
}

@end
