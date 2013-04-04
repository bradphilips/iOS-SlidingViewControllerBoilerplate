//
//  UINavigationBar+SocialBackground.h
//  SocialExample
//
//  Created by Brad Philips on 10/15/12.
//  Copyright (c) 2012 Brad Philips. All rights reserved.
//

#import "UINavigationBar+Background.h"

@implementation UINavigationBar (MXNareBackground)
- (void)drawRect:(CGRect)rect {
  UIImage *backgroundImage = [UIImage imageNamed:@"grid_tb"];

  [backgroundImage drawInRect:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
  self.tintColor = [UIColor blackColor];
}

- (void)setBackground {
  if ([self respondsToSelector:@selector(setBackgroundImage:forBarMetrics:)]) {
    [self setBackgroundImage:[UIImage imageNamed:@"grid_tb"] forBarMetrics:UIBarMetricsDefault];
  }
  self.tintColor = [UIColor blackColor];
}

@end
