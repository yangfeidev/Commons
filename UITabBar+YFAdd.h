//
//  UITabBar+YFAdd.h
//  MobileMall
//
//  Created by YangFei on 2017/8/14.
//  Copyright © 2017年 SoftBest1. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UITabBar (YFAdd)

- (void)yf_showNum:(NSInteger)num onItemIndex:(NSInteger)index;   //显示数字

- (void)yf_hideNumOnItemIndex:(NSInteger)index; //隐藏数字

- (void)yf_showShoppingCartNum;
- (void)yf_hideShoppingCartNum;
- (void)yf_showShoppingCartNum:(NSInteger)num;

@end
