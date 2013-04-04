//
//  MXNModel.h
//  MXNSlidingBoilerplate
//
//  Created by Brad Philips on 3/20/13.
//  Copyright (c) 2013 Mixin Mobile, LLC. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DCParserConfiguration.h"

@interface MXNModel : NSObject

- (NSDictionary *)serialize;
+ (id)deserialize:(NSDictionary *)jsonData;

+ (DCParserConfiguration *)configuration;

@end
