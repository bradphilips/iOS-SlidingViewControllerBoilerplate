//
//  MXNConfigurationDataTest.m
//  MXNSlidingBoilerplate
//
//  Created by Brad Philips on 4/9/13.
//  Copyright (c) 2013 Mixin Mobile. All rights reserved.
//

#import "MXNConfigurationData.h"

SPEC_BEGIN(MXNConfigurationDataSpec)

describe(@"MXNConfigurationData", ^{
  when(@"sharedConfiguration is called", ^{
    it(@"should not be nil and be of type MXNConfigurationData", ^{
      MXNConfigurationData *data = [MXNConfigurationData sharedConfiguration];
      [data shouldNotBeNil];
      [[data should] beKindOfClass:[MXNConfigurationData class]];
    });
    
    it(@"should be the exact same instance for every call", ^{
      MXNConfigurationData *firstInstance = [MXNConfigurationData sharedConfiguration];
      MXNConfigurationData *secondInstance = [MXNConfigurationData sharedConfiguration];
      
      [[firstInstance should] beIdenticalTo:secondInstance];
    });
  });
  
  when(@"isLoggedIn is set", ^{
    it(@"should store its value in user defaults with the key IS_LOGGED_IN", ^{
      MXNConfigurationData *data = [MXNConfigurationData sharedConfiguration];
      data.isLoggedIn = YES;
      
      NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
      [[theValue(data.isLoggedIn) should] equal:[defaults objectForKey:@"IS_LOGGED_IN"]];
    });
    
    it(@"should have the same value regardless of alloc'd instance vs sharedInstance", ^{
      MXNConfigurationData *sharedInstance = [MXNConfigurationData sharedConfiguration];
      sharedInstance.isLoggedIn = YES;
      
      MXNConfigurationData *allocInstance = [[MXNConfigurationData alloc] init];
      allocInstance.isLoggedIn = NO;
      
      [[theValue(allocInstance.isLoggedIn) should] equal:theValue(sharedInstance.isLoggedIn)];
    });
  });
  
  when(@"url is retrieved", ^{
    it(@"should return the default localhost url", ^{
      MXNConfigurationData *data = [MXNConfigurationData sharedConfiguration];
      [[data.url should] beIdenticalTo:@"http://localhost"];
    });
    
    it(@"should not respond to the setUrl", ^{
      MXNConfigurationData *data = [MXNConfigurationData sharedConfiguration];
      [[data shouldNot] respondToSelector:@selector(setUrl:)];
    });
  });
});

SPEC_END
