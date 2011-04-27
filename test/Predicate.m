//
//  Predicate.m
//  test
//
//  Created by seppo on 4/27/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "Predicate.h"


@implementation Predicate

static NSMutableArray* predicates = nil;

+ (Predicate*) currentPredicate {
	return [predicates lastObject];
}

+ (Predicate*)predicateWithFormat:(NSString *)predicateFormat, ... {
	Predicate* ret = [[[self alloc] init] autorelease];
	[ret setFormat:predicateFormat];
	return ret;
}

- (void) setFormat:(NSString*)format {
	[predicate release];
	predicate = [[NSPredicate predicateWithFormat:format] retain];
}

- (BOOL) evaluateWithObject:(id)object {
	if (predicates == nil) {
		predicates = [[NSMutableArray arrayWithCapacity:1] retain];
	}
	objects = [[NSMutableArray alloc] initWithCapacity:1];
	[predicates addObject:self];
	BOOL ret = [predicate evaluateWithObject:object];
	[predicates removeObject:self];
	[objects release];
	objects = nil;
	return ret;
}

- (void) pushObject:(id)obj {
	[objects addObject:obj];
}

- (id) popObject {
	id obj = [[[objects lastObject] retain] autorelease];
	[objects removeLastObject];
	return obj;
}

- (NSArray*) lastObjects:(int)q {
	if ([objects count] < q) return NULL;
	NSMutableArray* arr = [NSMutableArray arrayWithCapacity:q];
	for (int i = 0; i<q; i++) {
		[arr addObject:[objects objectAtIndex:[objects count]-q+i]];
	}
	return [[arr copy] autorelease];
}

@end
