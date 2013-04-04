//
//  MXNButtonCell.m
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

#import "MXNButtonCell.h"

@implementation MXNButtonCell

- (void)finishConstruction {
	[super finishConstruction];
  self.textLabel.textAlignment = UITextAlignmentCenter;
  self.backgroundColor = [UIColor clearColor];
  self.backgroundView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"button_bg"]];
}

- (void)configureForData:(id)dataObject tableView:(UITableView *)aTableView indexPath:(NSIndexPath *)anIndexPath {
  [super configureForData:dataObject tableView:aTableView indexPath:anIndexPath];
  self.textLabel.font = [dataObject objectForKey:@"textFont"] == nil ?
  [UIFont boldSystemFontOfSize:[UIFont systemFontSize]] :
  [dataObject objectForKey:@"textFont"];
  self.textLabel.textColor = [UIColor whiteColor];
  
  viewController = (PageViewController *)aTableView.delegate;
  selector = NSSelectorFromString([dataObject objectForKey:@"selector"]);
}

- (void)handleSelectionInTableView:(UITableView *)aTableView {
  if ([viewController respondsToSelector:selector]) {
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Warc-performSelector-leaks"
    [viewController performSelector:selector withObject:aTableView];
#pragma clang diagnostic pop
  }
}

@end
