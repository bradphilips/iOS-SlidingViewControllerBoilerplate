//
//  MXNKiwiRedefines.m
//  MXNSlidingBoilerplate
//
//  Created by Brad Philips on 4/9/13.
//  Copyright (c) 2013 Mixin Mobile. All rights reserved.
//

#import "MXNKiwiRedefines.h"

@implementation MXNKiwiRedefines

void when(NSString *aDescription, KWVoidBlock aBlock) {
  context(aDescription, aBlock);
}

@end
