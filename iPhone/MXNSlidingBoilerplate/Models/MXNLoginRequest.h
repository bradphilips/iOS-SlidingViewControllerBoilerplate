//
//  MXNLoginRequest.h
//  MXNSlidingBoilerplate
//
//  Created by Brad Philips on 3/5/13.
//  Copyright (c) 2013 Mixin Mobile, LLC. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "MXNModel.h"

@interface MXNLoginRequest : MXNModel

@property (nonatomic, strong) NSString *username;
@property (nonatomic, strong) NSString *password;

@end
