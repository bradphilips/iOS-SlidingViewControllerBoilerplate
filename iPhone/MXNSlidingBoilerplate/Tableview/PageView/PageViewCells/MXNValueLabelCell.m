//
//  MXNValueLabelCell.m
//  Mixin Mobile, LLC.
//
//  Created by Brad Philips on 5/6/12.
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

#import "MXNValueLabelCell.h"

@implementation MXNValueLabelCell

+ (UITableViewCellStyle)style {
	return UITableViewCellStyleValue2;
}

- (void)finishConstruction {
  [super finishConstruction];
  self.selectionStyle = UITableViewCellSelectionStyleGray;
}

- (void)configureForData:(id)dataObject tableView:(UITableView *)aTableView indexPath:(NSIndexPath *)anIndexPath {
  [super configureForData:dataObject tableView:aTableView indexPath:anIndexPath];
  
  self.textLabel.textAlignment = UITextAlignmentLeft;
  self.textLabel.text = [dataObject objectForKey:@"text"];
  self.textLabel.font = [dataObject objectForKey:@"textFont"] == nil ? 
    [UIFont boldSystemFontOfSize:[UIFont systemFontSize]] :
    [dataObject objectForKey:@"textFont"];
  self.detailTextLabel.text = [dataObject objectForKey:@"detailText"];
  self.detailTextLabel.font = [dataObject objectForKey:@"detailFont"] == nil ? 
    [UIFont systemFontOfSize:[UIFont systemFontSize]] :
    [dataObject objectForKey:@"detailFont"];
  self.detailTextLabel.numberOfLines = [dataObject objectForKey:@"numberOfLines"] == nil ? 1 : 
          [[dataObject objectForKey:@"numberOfLines"] intValue];
  self.detailTextLabel.lineBreakMode = UILineBreakModeWordWrap;
}

@end
