//
//  NSDate+YFAdd.m
//  IOSMall
//
//  Created by YangFei on 2016/12/30.
//  Copyright © 2016年 Social. All rights reserved.
//

#import "NSDate+YFAdd.h"

@implementation NSDate (YFAdd)


+ (NSString *)yf_dateWithMilliSecond:(int64_t)milliSecond {
    
    long long second = milliSecond/1000.0f;
    NSDate *dateTime = [NSDate dateWithTimeIntervalSince1970:second];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    dateFormatter.dateFormat = @"yyyy-MM-dd HH:mm:ss";
    NSString *dateString = [dateFormatter stringFromDate:dateTime];
    
    return dateString;
}

+ (BOOL)yf_date:(NSDate*)date isBetweenDate:(NSDate*)beginDate andDate:(NSDate*)endDate {
    if ([date compare:beginDate] == NSOrderedAscending)  return NO;
    if ([date compare:endDate] == NSOrderedDescending)  return NO;
    return YES;
}

@end
