//
//  MXNModel.m
//  MXNSlidingBoilerplate
//
//  Created by Brad Philips on 3/20/13.
//  Copyright (c) 2013 Mixin Mobile, LLC. All rights reserved.
//

#import "MXNModel.h"

#import "DCKeyValueObjectMapping.h"

@implementation MXNModel

- (NSDictionary *)serialize {
  DCKeyValueObjectMapping *parser = [DCKeyValueObjectMapping mapperForClass:[self class]
                                                           andConfiguration:[[self class] configuration]];
  return [parser serializeObject:self];
}

+ (id)deserialize:(NSDictionary *)jsonData {
  DCKeyValueObjectMapping *parser = [DCKeyValueObjectMapping mapperForClass:[self class]
                                                           andConfiguration:[self configuration]];
  return [parser parseDictionary:jsonData];
}

+ (DCParserConfiguration *)configuration {
  /* Meant to be overriden in the model to provide the mapping configuration */
  return nil;
}

@end
