//
//  YFAlertMessageTool.m
//
//
//  Created by YangFei on 2016/12/13.
//  Copyright © 2016年 JiuBianLi. All rights reserved.
//

#import "YFAlertTool.h"

static NSString * const mainTitle = @"提示";

static NSString * const doneTitle = @"确定";



@interface YFAlertTool () 

@end

@implementation YFAlertTool

+ (void)alertWithTitle:(NSString *)title
               message:(NSString *)message
      messageAlignment:(NSTextAlignment)alignment
       leftActionTitle:(NSString *)leftTitle
               handler:(void (^)(void))leftAction
      rightActionTitle:(NSString *)rightTitle
               handler:(void (^)(void))rightAction {
    
    NSAssert(title, @"YFAlertTool title can not be nil");
    NSAssert(message, @"YFAlertTool message can not be nil");
    
    if (YFiOS_8_OR_LATER) {
        
        UIAlertController *yf_alertVC = [UIAlertController alertControllerWithTitle:title
                                                                            message:message
                                                                     preferredStyle:UIAlertControllerStyleAlert];
        yf_alertVC.yf_messageLabel.textAlignment = alignment;
        
        UIAlertAction *yf_action1 = [UIAlertAction actionWithTitle:leftTitle
                                                             style:UIAlertActionStyleCancel
                                                           handler:^(UIAlertAction * _Nonnull action) {
                                                               if (leftAction) {
                                                                   leftAction();
                                                               }
                                                           }];
        [yf_alertVC addAction:yf_action1];
        
        // ------ 如果存在第二个按钮
        if (rightTitle.length) {
            UIAlertAction *yf_action2 = [UIAlertAction actionWithTitle:rightTitle
                                                                 style:UIAlertActionStyleDefault
                                                               handler:^(UIAlertAction * _Nonnull action) {
                                                                   if (rightAction) {
                                                                       rightAction();
                                                                   }
                                                               }];
            
            [yf_alertVC addAction:yf_action2];
        }
        
//        UIViewController *myVc = [UIApplication sharedApplication].keyWindow.rootViewController;
        
        
        UIViewController *myVc = [self currentViewController];
        dispatch_async_on_main_queue(^{
            [myVc presentViewController:yf_alertVC animated:YES completion:nil];
        });
        
    }
}

+ (UIViewController *)currentViewController {
    UIViewController *result = nil;
    UIWindow *window = [[UIApplication sharedApplication] keyWindow];
    /// app默认windowLevel是UIWindowLevelNormal，如果不是，找到UIWindowLevelNormal的
    if (window.windowLevel != UIWindowLevelNormal) {
        NSArray *windows = [[UIApplication sharedApplication] windows];
        for(UIWindow *tmpWin in windows) {
            if (tmpWin.windowLevel == UIWindowLevelNormal) {
                window = tmpWin;
                break;
            }
        }
    }
    
    id  nextResponder = nil;
    UIViewController *appRootVC=window.rootViewController;
    if (appRootVC.presentedViewController) {
        nextResponder = appRootVC.presentedViewController;
    } else {
        UIView *frontView = [[window subviews] objectAtIndex:0];
        nextResponder = [frontView nextResponder];
    }
    
    if ([nextResponder isKindOfClass:[UITabBarController class]]){
        UITabBarController *tabbar = (UITabBarController *)nextResponder;
        UINavigationController *nav = (UINavigationController *)tabbar.viewControllers[tabbar.selectedIndex];
        result = nav.childViewControllers.lastObject;
        
    } else if ([nextResponder isKindOfClass:[UINavigationController class]]){
        UIViewController *nav = (UIViewController *)nextResponder;
        result = nav.childViewControllers.lastObject;
    } else {
        result = nextResponder;
    }
    return result;
}

+ (void)alertMessage:(NSString *)message {
    [self alertWithTitle:mainTitle
                     message:message
            messageAlignment:NSTextAlignmentCenter
             leftActionTitle:doneTitle
                     handler:nil
            rightActionTitle:nil
                     handler:nil];
}

+ (void)alertMessage:(NSString *)message handler:(void (^)(void))leftAction {
    [self alertWithTitle:mainTitle
                     message:message
            messageAlignment:NSTextAlignmentCenter
             leftActionTitle:doneTitle
                     handler:leftAction
            rightActionTitle:nil
                     handler:nil];
}


@end
