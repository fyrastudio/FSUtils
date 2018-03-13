//
//  NSString+Currency.h
//  FSUtils
//
//  Created by Jan Lubeck on 01/03/2018.
//  Copyright © 2018 Fyrastudio. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (Currency)

-(NSUInteger)numberOfLeadingZeros;
-(NSString*)removeDuplicates:(NSString*)string;

@end
