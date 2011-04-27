//
//  NSObject+predicate.h
//  test
//
//  Created by seppo on 4/27/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Predicate.h"

@interface NSObject (predicate)

- (BOOL) pushObject;
- (id) popObject;
- (id) callMethod;

@end
