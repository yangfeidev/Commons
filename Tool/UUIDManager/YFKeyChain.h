//
//  YFKeyChain.h
//
//
//  Created by YangFei on 2018/1/10.
//  Copyright © 2018年 JiuBianLi. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YFKeyChain : NSObject

+ (NSMutableDictionary *)getKeychainQuery:(NSString *)service ;

+ (void)save:(NSString *)service data:(id)data;

+ (id)load:(NSString *)service;

+ (void)delete:(NSString *)service; 
@end
