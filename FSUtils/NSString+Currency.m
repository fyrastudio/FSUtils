//
//  NSString+Currency.m
//  FSUtils
//
//  Created by Jan Lubeck on 01/03/2018.
//  Copyright © 2018 Fyrastudio. All rights reserved.
//

#import "NSString+Currency.h"

@implementation NSString (Currency)

-(NSUInteger)numberOfLeadingZeros{
	NSUInteger length = [self length];
	for (NSUInteger i = 0; i < length; i++)
	{
		if ([self characterAtIndex:i] != '0')
		{
			return i;
		}
	}
	return 0;
}

-(NSString*)removeDuplicates:(NSString*)string{
	NSString *value = self;
	NSError *error = nil;
	
	NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:[NSString stringWithFormat:@"%@+",string] options:NSRegularExpressionCaseInsensitive error:&error];
	
	value = [regex stringByReplacingMatchesInString:value options:0 range:NSMakeRange(0, [value length]) withTemplate:string];
	
	NSArray *arr = [value componentsSeparatedByString:string];
	
	if(arr.count > 2){
		NSRange range = [value rangeOfString:string];
		if(range.location != NSNotFound){
			NSMutableString *newValue = [arr componentsJoinedByString:@""].mutableCopy;
			[newValue insertString:string atIndex:range.location];
			value = newValue;
		}
	}
	return value;
}

@end
