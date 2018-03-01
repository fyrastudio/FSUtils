//
//  FSUtils.h
//  FSUtils
//
//  Created by Jan on 9/8/16.
//  Copyright © 2016 Fyrastudio. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

//! Project version number for FSUtils.
FOUNDATION_EXPORT double FSUtilsVersionNumber;

//! Project version string for FSUtils.
FOUNDATION_EXPORT const unsigned char FSUtilsVersionString[];

// In this header, you should import all the public headers of your framework using statements like #import <FSUtils/PublicHeader.h>

@interface FSUtils : NSObject
NS_ASSUME_NONNULL_BEGIN
+(NSString*)formatAsPhoneNumber:(NSString*)text;
+(void)presentAlertWithTitle:(NSString *)title text:(NSString *)text actionText:(NSString * _Nullable)actionText cancelText:(NSString * _Nullable)cancelText onViewController:(UIViewController * _Nullable)vc actionMethod: (void (^ __nullable)(void))actionMethod cancelMethod: (void (^ __nullable)(void))cancelMethod;
+(NSURL *)getFacebookPictureURL:(NSString *)facebookID withSize:(int)size;
+(NSString*)getVersion;
+(NSString*)getBuild;
+(NSString*)getVersionAndBuild;
+(void)postLocalNotification:(NSString *)message withAction:(NSString *)action data:(NSDictionary *)data;
#pragma mark - Currency methods
+(NSString *)formattedNumberWithString:(NSString *)string andSymbol:(NSString *)symbol;
+(NSDecimalNumber *)decimalNumberWithString:(NSString *)string;
+(NSNumberFormatter*)formatterWithString:(NSString*)string;
NS_ASSUME_NONNULL_END
@end
