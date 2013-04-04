//
//  MXNLoginRequest.m
//  MXNSlidingBoilerplate
//
//  Created by Brad Philips on 3/5/13.
//  Copyright (c) 2013 Mixin Mobile, LLC. All rights reserved.
//

#import "MXNLoginRequest.h"

@implementation MXNLoginRequest
@synthesize username;
@synthesize password;

+ (DCParserConfiguration *)configuration {
  // This maps attributes of the model from config.  For example:
  // [config addObjectMapping:[DCObjectMapping mapKeyPath:@"user" toAttribute:@"userName" onClass:[MXNLoginRequest class]]];
  // See: https://github.com/dchohfi/KeyValueObjectMapping
  
  DCParserConfiguration *loginConfig = [DCParserConfiguration configuration];
  [loginConfig addObjectMapping:[DCObjectMapping mapKeyPath:@"username" toAttribute:@"username" onClass:[MXNLoginRequest class]]];
  [loginConfig addObjectMapping:[DCObjectMapping mapKeyPath:@"password" toAttribute:@"password" onClass:[MXNLoginRequest class]]];
  return loginConfig;
}

@end
