//
//  MXNBaseService.m
//  MXNSlidingBoilerplate
//
//  Created by Brad Philips on 3/19/13.
//  Copyright (c) 2013 Mixin Mobile, LLC. All rights reserved.
//

#import "MXNBaseService.h"

#import "JSONKit.h"
#import "AFJSONRequestOperation.h"

@implementation MXNBaseService

- (NSURLRequest *)createRequestForResource:(NSString *)resource
                                    method:(NSString *)method
                                parameters:(NSDictionary *)parameters
                                   payload:(MXNModel *)payload {
  NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[self posURLWithParameters:parameters forResource:resource]];
  request.HTTPMethod = method;
  [request addValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
  if (payload) {
    request.HTTPBody = [[payload serialize] JSONData];
  }
  return request;
}

- (NSURL *)posURLWithParameters:(NSDictionary *)parameters forResource:(NSString *)resource {
#if TARGET_IPHONE_SIMULATOR
  NSString *path = [NSString stringWithFormat:@"http://%@%@", @"localhost:3000", resource];
#else
  MXNConfigurationData *configuration = [MXNConfigurationData sharedConfiguration];
  NSString *path = [NSString stringWithFormat:@"http://%@%@", configuration.serverIP, resource];
#endif
  if ([parameters count] > 0) {
    NSMutableArray* parts = [NSMutableArray array];
    for (NSString *key in [parameters allKeys]) {
      NSString *param = [NSString stringWithFormat:@"%@=%@", key, [parameters objectForKey:key]];
      [parts addObject:param];
    }
    
    NSString *params = [parts componentsJoinedByString:@"&"];
    return [NSURL URLWithString:[NSString stringWithFormat:@"%@?%@", path, params]];
  }
  return [NSURL URLWithString:path];
}

- (void)makeJSONRequest:(NSURLRequest *)request callback:(servicecallback_t)callback {
  AFJSONRequestOperation *operation =
  [AFJSONRequestOperation JSONRequestOperationWithRequest:request
                                                  success:
   ^(NSURLRequest *request, NSHTTPURLResponse *response, id JSON) {
     callback(JSON, request, response, nil);
   } failure:
   ^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error, id JSON) {
     callback(JSON, request, response, error);
   }];
  [operation start];
}

@end
