//
//  NSDate+YFAdd.h
//  IOSMall
//
//  Created by YangFei on 2016/12/30.
//  Copyright © 2016年 Social. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDate (YFAdd)


/**
 通过服务器返回的毫秒数, 计算当前时间

 @param milliSecond 毫秒数值
 @return 当前时间字符串
 */
+ (NSString *)yf_dateWithMilliSecond:(int64_t)milliSecond;


/**
 判断一个date是否在一个时间段内

 @param date 要判断的时间
 @param beginDate 开始时间
 @param endDate 结束时间
 @return 是否在这个时间内 bool值
 */
+ (BOOL)yf_date:(NSDate*)date isBetweenDate:(NSDate *)beginDate andDate:(NSDate *)endDate;

@end
