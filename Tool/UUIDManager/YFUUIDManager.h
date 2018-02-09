//
//  YFUUIDManager.h
//
//  Created by YangFei on 2018/1/10.
//  Copyright © 2018年 JiuBianLi. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YFUUIDManager : NSObject

+ (void)saveUUID;

+ (id)readUUID;

+ (void)deleteUUID;

@end
