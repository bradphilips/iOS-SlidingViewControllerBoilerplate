//
//  MXNConfigurationData.h
//  MXNSlidingBoilerplate
//
//  Created by Brad Philips on 3/4/13.
//  Copyright (c) 2013 Mixin Mobile, LLC. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MXNConfigurationData : NSObject

+ (MXNConfigurationData *)sharedConfiguration;

@property (nonatomic, assign) BOOL isLoggedIn;

@end
