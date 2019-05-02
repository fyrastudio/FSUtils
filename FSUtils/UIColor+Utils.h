//
//  UIColor+Utils.h
//  FSUtils
//
//  Created by Jan on 5/2/19.
//  Copyright © 2019 Fyrastudio. All rights reserved.
//

#import <UIKit/UIKit.h>

#define UIColorFromHex(hex) [UIColor colorWithRed:((float)((hex & 0xFF0000) >> 16))/255.0 green:((float)((hex & 0xFF00) >> 8))/255.0 blue:((float)(hex & 0xFF))/255.0 alpha:1.0]

@interface UIColor (Utils)

+(UIColor*)colorWithR:(CGFloat)r G:(CGFloat)g B:(CGFloat)b;

@end
