//
//  YFUUIDManager.m
//
//  Created by YangFei on 2018/1/10.
//  Copyright © 2018年 JiuBianLi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YFUUIDManager.h"
#import "YFKeyChain.h"

@implementation YFUUIDManager

static NSString * const KEY_IN_KEYCHAIN = @"Project_JBL_Bundle ID";
static NSString * const KEY_UUID = @"Project_JBL_BundleID.uuid";

+ (void)saveUUID {
    
    /// 获得UUID存入keyChain中
    NSUUID *UUID = [UIDevice currentDevice].identifierForVendor;
    NSMutableDictionary *usernameUuidPairs = [NSMutableDictionary dictionary];
    [usernameUuidPairs setObject:UUID forKey:KEY_UUID];
    [YFKeyChain save:KEY_IN_KEYCHAIN data:usernameUuidPairs];
}

+ (id)readUUID {
    NSMutableDictionary *usernameUuidPairs = (NSMutableDictionary *)[YFKeyChain load:KEY_IN_KEYCHAIN];
    return [usernameUuidPairs objectForKey:KEY_UUID];
}

+ (void)deleteUUID {
    [YFKeyChain delete:KEY_IN_KEYCHAIN];
}

@end
