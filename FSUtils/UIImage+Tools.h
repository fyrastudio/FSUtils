//
//  UIImage+Tools.h
//  FSUtils
//
//  Created by Jan Lubeck on 13/03/2018.
//  Copyright © 2018 Fyrastudio. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (Tools)
-(UIImage*)resize;
-(NSString*)toBase64;
-(UIImage*)scaleDownWithSize:(CGSize)newSize;
@end
