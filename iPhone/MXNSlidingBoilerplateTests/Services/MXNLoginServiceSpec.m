//
//  MXNLoginServiceSpec.m
//  MXNSlidingBoilerplate
//
//  Created by Brad Philips on 4/11/13.
//  Copyright (c) 2013 Mixin Mobile. All rights reserved.
//

#import "MXNLoginService.h"

SPEC_BEGIN(MXNLoginServiceSpec)

/**
 * NOTE: Server must be running when executing these tests.
 */

describe(@"Login Feature", ^{
  when(@"a valid user is presented", ^{
    it(@"should login successfully within 2 seconds and retrieve correct user.", ^{
      __block MXNUser *createdUser;
      __block NSError *createdError;
      MXNLoginRequest *request = [[MXNLoginRequest alloc] init];
      request.username = @"brad";
      request.password = @"secure";
      
      MXNLoginService *service = [[MXNLoginService alloc] init];
      [service login:request callback:^(MXNUser *user, NSError *error) {
        NSLog(@"Retrieved user %@", user.email);
        createdUser = user;
        createdError = error;
      }];
      
      [[expectFutureValue(createdUser) shouldEventuallyBeforeTimingOutAfter(2.0)] beNonNil];
      [[expectFutureValue(createdUser.email) shouldEventuallyBeforeTimingOutAfter(2.0)] equal:@"brad.t.philips@gmail.com"];
      [[expectFutureValue(createdError) shouldEventuallyBeforeTimingOutAfter(2.0)] beNil];
    });
  });
  
  when(@"an invalid user is presented", ^{
    it(@"should return an error with a 401 unauthorized and present 'Invalid credentials.'", ^{
      __block MXNUser *createdUser;
      __block NSError *createdError;
      MXNLoginRequest *request = [[MXNLoginRequest alloc] init];
      request.username = @"brad";
      request.password = @"badpassword";
      
      MXNLoginService *service = [[MXNLoginService alloc] init];
      [service login:request callback:^(MXNUser *user, NSError *error) {
        createdUser = user;
        createdError = error;
      }];
      
      [[expectFutureValue(createdUser) shouldEventuallyBeforeTimingOutAfter(2.0)] beNil];
      [[expectFutureValue(theValue(createdError.code)) shouldEventuallyBeforeTimingOutAfter(2.0)] equal:theValue(401)];
      [[expectFutureValue(createdError.localizedDescription) shouldEventuallyBeforeTimingOutAfter(2.0)] equal:@"Invalid credentials."];
    });
  });
});

SPEC_END
