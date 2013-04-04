//
//  MXNAppDelegate.h
//  MXNSlidingBoilerplate
//
//  Created by Brad Philips on 2/27/13.
//  Copyright (c) 2013 Mixin Mobile, LLC. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MXNAppDelegate : UIResponder <UIApplicationDelegate>

@property (nonatomic, strong) UIWindow *window;

+ (MXNAppDelegate *)appDelegate;

+ (void)showProgressIndicator:(NSString *)labelText;
+ (void)showProgressIndicator:(NSString *)labelText withCenter:(CGPoint)center;
+ (void)showProgressIndicator;
+ (void)hideProgressIndicator;
+ (void)hideProgressIndicatorAfterDelay:(NSTimeInterval)delay;

@end
