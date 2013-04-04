//
//  TextFieldCell.m
//  TableDesignRevisited
//
//  Created by Matt Gallagher on 2010/01/23.
//  Copyright 2010 Matt Gallagher. All rights reserved.
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

#import "TextFieldCell.h"
#import "PageViewController.h"

@interface TextFieldCell (Private)
- (BOOL)validateField;
@end

@implementation TextFieldCell
@synthesize validation;
@synthesize textField;
@synthesize isRequired;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
  self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
  if (self) {
    self.selectedBackgroundView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 124)];
    self.isRequired = NO;
  }
  return self;
}

- (void)dealloc {
  textField = nil;
  validation = nil;
}

- (NSString *)accessibilityLabel {
	return [NSString stringWithFormat:@"%@", textField.text];
}

- (void)finishConstruction {
	[super finishConstruction];
	
	CGFloat height = self.contentView.bounds.size.height;
	CGFloat width = self.contentView.bounds.size.width;
	CGFloat fontSize = [UIFont labelFontSize] - 2;
	CGFloat margin = 4;
  
	self.selectionStyle = UITableViewCellSelectionStyleNone;
  
  textField =
  [[UITextField alloc]
   initWithFrame:
   CGRectMake(
              2 * margin,
              0, 
              width - 2.0 * margin,
              height - 1)];
	textField.font = [UIFont systemFontOfSize:fontSize];
	textField.textAlignment = UITextAlignmentLeft;
	textField.autocapitalizationType = UITextAutocapitalizationTypeNone;
	textField.autocorrectionType = UITextAutocorrectionTypeNo;
	textField.backgroundColor = [UIColor clearColor];
	textField.clearButtonMode = UITextFieldViewModeWhileEditing;
	textField.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
	textField.autoresizingMask = UIViewAutoresizingFlexibleWidth;
	[self.contentView addSubview:textField];
}

- (void)configureForData:(id)dataObject
	tableView:(UITableView *)aTableView
	indexPath:(NSIndexPath *)anIndexPath
{
	[super configureForData:dataObject tableView:aTableView indexPath:anIndexPath];
  self.accessoryType = UITableViewCellAccessoryNone;
	NSDictionary *data = (NSDictionary *)dataObject;
  NSString *keypath = [data objectForKey:@"property"];
  NSObject *modelValue = [[data objectForKey:@"model"] valueForKey:keypath];
  if (modelValue) {
    textField.text = [NSString stringWithFormat:@"%@", modelValue];
  } else {
    textField.text = nil;
  }

	textField.placeholder = [data objectForKey:@"placeholder"];
  self.validation = [data objectForKey:@"validation"];
  self.isRequired = [[data objectForKey:@"isRequired"] boolValue];
  if ([data objectForKey:@"keyboard"]) {
    textField.keyboardType = [[data objectForKey:@"keyboard"] intValue];
  } else {
    textField.keyboardType = UIKeyboardTypeDefault;
  }
  
  [textField setSecureTextEntry:[[data objectForKey:@"secure"] boolValue]];
	textField.delegate = (PageViewController *)aTableView.delegate;
  textField.tag = [[dataObject objectForKey:@"tag"] intValue];
  textField.returnKeyType = UIReturnKeyNext;
}

- (BOOL)validateField {
  if (textField.text == nil || [textField.text isEqualToString:@""]) {
    if (isRequired) {
      UIAlertView *alert = [[UIAlertView alloc] initWithTitle:[NSString stringWithFormat:@"%@ Required", textField.placeholder]
                                                      message:[NSString stringWithFormat:@"%@ is a required field", textField.placeholder]
                                                     delegate:nil
                                            cancelButtonTitle:@"OK"
                                            otherButtonTitles:nil];
      [alert show];
      return NO;
    }
    
    return YES;
  }
  
  for (NSString *validationPattern in [self.validation allKeys]) {
    NSError *error;
    NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:validationPattern
                                                                           options:NSRegularExpressionCaseInsensitive 
                                                                             error:&error];
    
    NSRange rangeOfFirstMatch = [regex rangeOfFirstMatchInString:textField.text
                                                         options:0 
                                                           range:NSMakeRange(0, [textField.text length])];
    if (NSEqualRanges(rangeOfFirstMatch, NSMakeRange(NSNotFound, 0))) {
      NSDictionary *errorDescription = [self.validation objectForKey:validationPattern];
      UIAlertView *alert = [[UIAlertView alloc] initWithTitle:[errorDescription objectForKey:NSLocalizedFailureReasonErrorKey]
                                                      message:[errorDescription objectForKey:NSLocalizedDescriptionKey]
                                                     delegate:nil
                                            cancelButtonTitle:@"OK"
                                            otherButtonTitles:nil];
      [alert show];
      return NO;
    }
  }
  
  return YES;
}

@end
