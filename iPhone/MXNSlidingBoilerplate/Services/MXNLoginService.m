//
//  MXNLoginService.m
//  MXNSlidingBoilerplate
//
//  Created by Brad Philips on 3/6/13.
//  Copyright (c) 2013 Mixin Mobile, LLC. All rights reserved.
//

#import "MXNLoginService.h"

@implementation MXNLoginService

- (void)login:(MXNLoginRequest *)loginRequest callback:(usercallback_t)callback {
  NSURLRequest *request = [self createRequestForResource:@"/session"
                                                  method:@"POST"
                                              parameters:nil
                                                 payload:loginRequest];
  [self makeJSONRequest:request callback:^(id JSON, NSURLRequest *request, NSHTTPURLResponse *response, NSError *error) {
    if (error) {
      NSError *visibleError = error;
      if (response.statusCode == 401) {
        visibleError = [NSError errorWithDomain:@"MXNServiceDomain"
                                          code:response.statusCode
                                      userInfo:@{NSLocalizedDescriptionKey: @"Invalid credentials." }];
      }
      
      callback(nil, visibleError);
      return;
    }
    
    MXNUser *user = [MXNUser deserialize:[JSON objectForKey:@"user"]];
    callback(user, nil);
  }];
}

- (void)logout:(messagecallback_t)callback {
  NSURLRequest *request = [self createRequestForResource:@"/session"
                                                  method:@"DELETE"
                                              parameters:nil
                                                 payload:nil];
  [self makeJSONRequest:request callback:^(id JSON, NSURLRequest *request, NSHTTPURLResponse *response, NSError *error) {
    if (error) {
      callback(nil, error);
      return;
    }
    
    NSString *message = [JSON objectForKey:@"message"];
    callback(message, nil);
  }];
}

@end
