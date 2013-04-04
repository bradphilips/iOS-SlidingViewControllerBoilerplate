//
//  MXNBasePageViewController.h
//  MXNSlidingBoilerplate
//
//  Created by Brad Philips on 3/6/13.
//  Copyright (c) 2013 Mixin Mobile, LLC. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PageViewController.h"

@interface MXNBasePageViewController : PageViewController

@property (nonatomic, assign) BOOL showMenu;

- (BOOL)validateModel;

@end
