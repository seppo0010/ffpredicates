//
//  NSObject+predicate.m
//  test
//
//  Created by seppo on 4/27/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "NSObject+predicate.h"
#import "Predicate.h"

@implementation NSObject (predicate)

- (BOOL) pushObject {
	[[Predicate currentPredicate] pushObject:self];
	return TRUE;
}

- (id) popObject {
	return [[Predicate currentPredicate] popObject];
}

- (id) callMethod {
	int q = [[[Predicate currentPredicate] popObject] intValue];
	NSArray* objects = [[Predicate currentPredicate] lastObjects:q+2];
	id object = [objects objectAtIndex:0];
	NSString* method = [objects objectAtIndex:1];
	if (![method isKindOfClass:[NSString class]]) return NULL;
	SEL selector = sel_getUid([method UTF8String]);
	if (![object respondsToSelector:selector]) return NULL;
	NSMethodSignature* signature = [object methodSignatureForSelector:selector];
	if ( !signature ) return NULL;
	NSInvocation* invocation = [NSInvocation invocationWithMethodSignature:signature];
	[invocation setTarget:object];
	[invocation setSelector:selector];
	for (int i = 0; i < q; i++) {
		id value = [objects objectAtIndex:2+i];
		if (strcmp([signature getArgumentTypeAtIndex:2+i],@encode(int)) == 0)
		{
			int str = 0;
			if ([value respondsToSelector:@selector(intValue)]) str = [value intValue];
			[invocation setArgument:&str atIndex:2+i];
		} else if (strcmp([signature getArgumentTypeAtIndex:2+i],@encode(double)) == 0) {
			double str = [value doubleValue];
			[invocation setArgument:&str atIndex:2+i];
		} else if (strcmp([signature getArgumentTypeAtIndex:2+i],@encode(float)) == 0) {
			float str = [value doubleValue];
			[invocation setArgument:&str atIndex:2+i];
		} else if (strcmp([signature getArgumentTypeAtIndex:2+i],@encode(unsigned long long)) == 0) {
			unsigned long long str = [value longLongValue];
			[invocation setArgument:&str atIndex:2+i];
		} else if (strcmp([signature getArgumentTypeAtIndex:2+i],@encode(long long)) == 0) {
			long long str = [value longLongValue];
			[invocation setArgument:&str atIndex:2+i];
		} else if (strcmp([signature getArgumentTypeAtIndex:2+i], @encode(BOOL)) == 0) {
			BOOL str = [value boolValue];
			[invocation setArgument:&str atIndex:2+i];
		} else {
			id str = value;
			[invocation setArgument:&str atIndex:2+i];
		}
	}

	[invocation invoke];
	
	id value = nil;
	if (strcmp([signature methodReturnType], @encode(double)) == 0)
	{
		double d;
		[invocation getReturnValue:&d];
		value = [NSNumber numberWithDouble:d];
	} else if (strcmp([signature methodReturnType], @encode(float)) == 0)
	{
		float f;
		[invocation getReturnValue:&f];
		value = [NSNumber numberWithFloat:f];
	} else if (strcmp([signature methodReturnType], @encode(int)) == 0)
	{
		int d;
		[invocation getReturnValue:&d];
		value = [NSNumber numberWithInt:d];
	} else if (strcmp([signature methodReturnType], @encode(unsigned int)) == 0)
	{
		unsigned int d;
		[invocation getReturnValue:&d];
		value = [NSNumber numberWithUnsignedInt:d];
	} else if (strcmp([signature methodReturnType], @encode(long long unsigned)) == 0)
	{
		long long unsigned d;
		[invocation getReturnValue:&d];
		value = [NSNumber numberWithLongLong:d];
	} else if (strcmp([signature methodReturnType], @encode(long long)) == 0)
	{
		long long d;
		[invocation getReturnValue:&d];
		value = [NSNumber numberWithLongLong:d];
	} else if (strcmp([signature methodReturnType], @encode(BOOL)) == 0)
	{
		BOOL d;
		[invocation getReturnValue:&d];
		value = [NSNumber numberWithBool:d];
	} else if (strcmp([signature methodReturnType], "@") == 0)
	{
		id d;
		[invocation getReturnValue:&d];
		value = d;
	} else 
	{
		NSLog(@"Unknown methodReturnType: '%s' for property '%@'", [signature methodReturnType], method);
	}
	return value;
}

@end
