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

+(void)presentAlertWithTitle:(NSString *)title text:(NSString *)text okText:(NSString *)okText cancelable:(BOOL)cancelable onViewController:(UIViewController *)vc completion: (void (^ __nullable)(void))completion{
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:title message:text preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction* ok = [UIAlertAction actionWithTitle:okText style:UIAlertActionStyleDefault
                                               handler:^(UIAlertAction * action){
                                                   if(completion){
                                                       completion();
                                                   }
                                               }];
    [alert addAction:ok];
    if(cancelable){
        UIAlertAction* cancel = [UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleCancel
                                                       handler:nil];
        [alert addAction:cancel];
    }
    [vc presentViewController:alert animated:YES completion:nil];
}

+(NSURL *)getFacebookPictureURL:(NSString *)facebookID withSize:(int)size{
    return [NSURL URLWithString:[NSString stringWithFormat:@"https://graph.facebook.com/%@/picture?type=square&return_ssl_resources=1&width=%d&height=%d", facebookID, size, size]];
}

@end