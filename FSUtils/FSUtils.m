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
            if(visibleVC) [visibleVC presentViewController:alert animated:YES completion:nil];
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

@end