//
//  MXNLoginService.h
//  MXNSlidingBoilerplate
//
//  Created by Brad Philips on 3/6/13.
//  Copyright (c) 2013 Mixin Mobile, LLC. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "MXNUser.h"
#import "MXNLoginRequest.h"
#import "MXNBaseService.h"

typedef void(^usercallback_t)(MXNUser *user, NSError *error);

@interface MXNLoginService : MXNBaseService

- (void)logout:(messagecallback_t)callback;
- (void)login:(MXNLoginRequest *)request callback:(usercallback_t)callback;

@end
