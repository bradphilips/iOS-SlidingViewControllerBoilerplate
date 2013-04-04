//
//  MXNCheckedCell.h
//  MXNSlidingBoilerplate
//
//  Created by Brad Philips on 3/26/13.
//  Copyright (c) 2013 Mixin Mobile, LLC. All rights reserved.
//

#import "LabelCell.h"
#import "PageViewController.h"

@interface MXNCheckedCell : LabelCell {
  BOOL checked;
  SEL selector;
  PageViewController *viewController;
}

@property (nonatomic, assign) BOOL checked;

@end
