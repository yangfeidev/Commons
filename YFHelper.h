//
//  YFHelper.h
//  YFZhiHuLoading
//
//  Created by YangFei on 2017/3/8.
//  Copyright © 2017年 JiuBianLi. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface YFHelper : NSObject

+ (instancetype _Nonnull)sharedInstance;

@end


@interface YFHelper (Device)

+ (BOOL)isIPad;
+ (BOOL)isIPadPro;
+ (BOOL)isIPod;
+ (BOOL)isIPhone;
+ (BOOL)isSimulator;

+ (BOOL)is55InchScreen;
+ (BOOL)is47InchScreen;
+ (BOOL)is40InchScreen;
+ (BOOL)is35InchScreen;

+ (CGSize)screenSizeFor55Inch;
+ (CGSize)screenSizeFor47Inch;
+ (CGSize)screenSizeFor40Inch;
+ (CGSize)screenSizeFor35Inch;

@end


@interface YFHelper (Tool)

/**
 拨打电话
 
 @param phoneNumber 要拨打的号码
 */
+ (void)callWithNumber:(NSString * _Nonnull)phoneNumber;

@end


