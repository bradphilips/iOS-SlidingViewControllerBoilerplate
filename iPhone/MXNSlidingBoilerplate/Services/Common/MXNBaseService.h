//
//  MXNBaseService.h
//  MXNSlidingBoilerplate
//
//  Created by Brad Philips on 3/19/13.
//  Copyright (c) 2013 Mixin Mobile, LLC. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "MXNModel.h"

typedef void(^messagecallback_t)(NSString *message, NSError *error);
typedef void(^servicecallback_t)(id JSON, NSURLRequest *request, NSHTTPURLResponse *response, NSError *error);

@interface MXNBaseService : NSObject

- (NSURLRequest *)createRequestForResource:(NSString *)resource
                                    method:(NSString *)method
                                parameters:(NSDictionary *)parameters
                                   payload:(MXNModel *)payload;

- (void)makeJSONRequest:(NSURLRequest *)request callback:(servicecallback_t)callback;

@end
