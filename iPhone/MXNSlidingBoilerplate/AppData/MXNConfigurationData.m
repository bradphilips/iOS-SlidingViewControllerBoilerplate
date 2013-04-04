//
//  MXNConfigurationData.m
//  MXNSlidingBoilerplate
//
//  Created by Brad Philips on 3/4/13.
//  Copyright (c) 2013 Mixin Mobile, LLC. All rights reserved.
//

#import "MXNConfigurationData.h"

#define kIsLoggedIn           @"IS_LOGGED_IN"

@interface MXNConfigurationData () {
  NSUserDefaults *defaults;
}

@end

@implementation MXNConfigurationData

+ (MXNConfigurationData *)sharedConfiguration {
  DEFINE_SHARED_INSTANCE_USING_BLOCK(^{
    return [[self alloc] init];
  });
}

- (id)init {
  self = [super init];
  if (self) {
    defaults = [NSUserDefaults standardUserDefaults];
  }
  
  return self;
}

- (BOOL) isLoggedIn {
  return [defaults boolForKey:kIsLoggedIn];
}

- (void)setIsLoggedIn:(BOOL)isLoggedIn {
  [defaults setBool:isLoggedIn forKey:kIsLoggedIn];
  [defaults synchronize];
}

@end
