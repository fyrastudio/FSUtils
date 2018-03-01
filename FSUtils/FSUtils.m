//
//  Uitls.m
//  Mob
//
//  Created by Jan Lubeck on 12/5/15.
//  Copyright © 2015 Mob. All rights reserved.
//

#import "FSUtils.h"

@implementation FSUtils

+ (NSString*)formatAsPhoneNumber:(NSString*)text {
    static NSCharacterSet* set = nil;
    if (set == nil){
        set = [[NSCharacterSet decimalDigitCharacterSet] invertedSet];
    }
    NSString* phoneString = [[text componentsSeparatedByCharactersInSet:set] componentsJoinedByString:@""];
    switch (phoneString.length) {
        case 7: return [NSString stringWithFormat:@"%@-%@", [phoneString substringToIndex:3], [phoneString substringFromIndex:3]];
        case 10: return [NSString stringWithFormat:@"(%@) %@-%@", [phoneString substringToIndex:3], [phoneString substringWithRange:NSMakeRange(3, 3)],[phoneString substringFromIndex:6]];
        case 11: return [NSString stringWithFormat:@"%@ (%@) %@-%@", [phoneString substringToIndex:1], [phoneString substringWithRange:NSMakeRange(1, 3)], [phoneString substringWithRange:NSMakeRange(4, 3)], [phoneString substringFromIndex:7]];
        case 12: return [NSString stringWithFormat:@"+%@ (%@) %@-%@", [phoneString substringToIndex:2], [phoneString substringWithRange:NSMakeRange(2, 3)], [phoneString substringWithRange:NSMakeRange(5, 3)], [phoneString substringFromIndex:8]];
        default: return nil;
    }
}

+(void)presentAlertWithTitle:(NSString *)title text:(NSString *)text actionText:(NSString * _Nullable)actionText cancelText:(NSString * _Nullable)cancelText onViewController:(UIViewController * _Nullable)vc actionMethod: (void (^ __nullable)(void))actionMethod cancelMethod: (void (^ __nullable)(void))cancelMethod{
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:title message:text preferredStyle:UIAlertControllerStyleAlert];
    if(actionText){
        UIAlertAction* ok = [UIAlertAction actionWithTitle:actionText style:UIAlertActionStyleDefault
                                                   handler:^(UIAlertAction * action){
                                                       if(actionMethod){
                                                           actionMethod();
                                                       }
                                                   }];
        [alert addAction:ok];
    }
    if(cancelText){
        UIAlertAction* cancel = [UIAlertAction actionWithTitle:cancelText style:UIAlertActionStyleCancel
                                                       handler:^(UIAlertAction * action){
                                                           if(cancelMethod){
                                                               cancelMethod();
                                                           }
                                                       }];
        [alert addAction:cancel];
    }
    if(vc){
        [vc presentViewController:alert animated:YES completion:nil];
    }else{
        UIViewController *rootVC = [[UIApplication sharedApplication].keyWindow rootViewController];
        if([rootVC isKindOfClass: [UINavigationController class]]){
            UIViewController *visibleVC = ((UINavigationController *)rootVC).visibleViewController;
            if(visibleVC) {
				if(visibleVC.presentedViewController){
					[visibleVC.presentedViewController presentViewController:alert animated:YES completion:nil];
				}else{
					[visibleVC presentViewController:alert animated:YES completion:nil];
				}
			}
        }else{
            if([rootVC isKindOfClass: [UITabBarController class]]){
                UIViewController *selectedVC = ((UITabBarController *)rootVC).selectedViewController;
                if(selectedVC) [selectedVC presentViewController:alert animated:YES completion:nil];
            }else{
                if(rootVC.presentedViewController){
                    [rootVC.presentedViewController presentViewController:alert animated:YES completion:nil];
                }else{
                    [rootVC presentViewController:alert animated:YES completion:nil];
                }
            }
        }
    }
}

+(NSURL *)getFacebookPictureURL:(NSString *)facebookID withSize:(int)size{
    return [NSURL URLWithString:[NSString stringWithFormat:@"https://graph.facebook.com/%@/picture?type=square&return_ssl_resources=1&width=%d&height=%d", facebookID, size, size]];
}

+(NSString*)getVersion{
	NSString *version = [[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleShortVersionString"];
	return version;
}

+(NSString*)getBuild{
	NSString *build = [[[NSBundle mainBundle] infoDictionary] objectForKey:(NSString *)kCFBundleVersionKey];
	return build;
}

+(NSString*)getVersionAndBuild{
	return [NSString stringWithFormat:@"%@ (%@)", [FSUtils getVersion], [FSUtils getBuild]];
}

+(void)postLocalNotification:(NSString *)message withAction:(NSString *)action data:(NSDictionary *)data{
    dispatch_async(dispatch_get_main_queue(), ^{
        UILocalNotification *note =  [UILocalNotification new];
        note.alertBody = message;
        note.soundName = UILocalNotificationDefaultSoundName;
        NSMutableDictionary *userInfo = [NSMutableDictionary new];
        if(action){
            userInfo[@"Action"] = action;
        }
        if(data){
            userInfo[@"Data"] = data;
        }
        note.userInfo = userInfo;
        [[UIApplication sharedApplication] scheduleLocalNotification:note];
    });
}

#pragma mark - Currency methods

+(NSString *)formattedNumberWithString:(NSString *)string andSymbol:(NSString *)symbol{
	NSDecimalNumber *number = [[self class] decimalNumberWithString:string];
	
	if(number){
		return [symbol stringByAppendingString:[[[self class] formatterWithString:string] stringFromNumber:number]];
	}else{
		return [symbol stringByAppendingString:@"0"];
	}
}

+(NSDecimalNumber *)decimalNumberWithString:(NSString *)string{
	return [NSDecimalNumber decimalNumberWithString:string locale:[NSLocale localeWithLocaleIdentifier:@"en-US"]];
}

+(NSNumberFormatter*)formatterWithString:(NSString*)string{
	NSNumberFormatter *formatter = [NSNumberFormatter new];
	formatter.numberStyle = NSNumberFormatterCurrencyStyle;
	formatter.currencySymbol = @"";
	formatter.negativePrefix = @"";
	formatter.negativeSuffix = @"";
	formatter.minimumFractionDigits = 2;
	formatter.maximumFractionDigits = 2;
	
	NSRange range = [string rangeOfString:@"."];
	
	if(range.location != NSNotFound){
		if(range.location > 4){
			formatter.minimumFractionDigits = 0;
			formatter.maximumFractionDigits = 0;
		}else{
			NSArray *array = [string componentsSeparatedByString:@"."];
			NSString *decimals = array[1];
			if(decimals.length > 2){
				NSUInteger zeros = [decimals numberOfLeadingZeros];
				if(zeros > 1){
					formatter.minimumFractionDigits = zeros + 1;
					formatter.maximumFractionDigits = zeros + 1;
				}
			}
		}
	}else{
		//No decimal found. Round number
		if(string.length > 4){
			formatter.minimumFractionDigits = 0;
			formatter.maximumFractionDigits = 0;
		}
	}
	
	return formatter;
}

@end
