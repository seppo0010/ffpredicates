//
//  Predicate.h
//  test
//
//  Created by seppo on 4/27/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface Predicate : NSObject {
	NSPredicate* predicate;
    NSMutableArray* objects;
}

+ (Predicate*) currentPredicate;
- (void) pushObject:(id)obj;
- (void) setFormat:(NSString*)format;
- (NSArray*) lastObjects:(int)q;
+ (Predicate*)predicateWithFormat:(NSString *)predicateFormat, ...;
- (BOOL) evaluateWithObject:(id)object;

@end
