//
//  UIAlertView+WTRequestCenter.m
//  WTRequestCenter
//
//  Created by SongWentong on 14-10-16.
//  Copyright (c) 2014年 song. All rights reserved.
//

#import "UIAlertView+WTRequestCenter.h"
#import "WTNetWorkManager.h"
#import "NSObject+Nice.h"
#if (defined(__IPHONE_OS_VERSION_MAX_ALLOWED) && __IPHONE_OS_VERSION_MAX_ALLOWED <= 80000)

@implementation UIAlertView (WTRequestCenter)
+(void)showAlertWithMessage:(NSString*)message
{
    [self showAlertWithTitle:nil message:message duration:1.0];
}

+(void)showAlertWithTitle:(NSString*)title message:(NSString*)message duration:(NSTimeInterval)time
{
    [self showAlertWithTitle:title message:message duration:time complectionHandler:nil];
}

+(void)showAlertWithTitle:(NSString*)title message:(NSString*)message duration:(NSTimeInterval)time complectionHandler:(dispatch_block_t)block
{
    if (title || message ) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:title message:message delegate:nil cancelButtonTitle:nil otherButtonTitles: nil];
        [alert show];
        
        dispatch_block_t temp = ^{
            [alert dismissWithClickedButtonIndex:0 animated:YES];
            if (block) {
                block();
            }
        };
        [WTNetWorkManager performBlock:temp afterDelay:time];
    }
}

@end
#endif