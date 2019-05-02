//
//  UIColor+Utils.m
//  FSUtils
//
//  Created by Jan on 5/2/19.
//  Copyright © 2019 Fyrastudio. All rights reserved.
//

#import "UIColor+Utils.h"

@implementation UIColor (Utils)

+(UIColor*)colorWithR:(CGFloat)r G:(CGFloat)g B:(CGFloat)b{
    return [UIColor colorWithRed:r/255.0f green:g/255.0f blue:b/255.0f alpha:1];
}

@end
