//
//  UITabBar+YFAdd.m
//  MobileMall
//
//  Created by YangFei on 2017/8/14.
//  Copyright © 2017年 SoftBest1. All rights reserved.
//

#import "UITabBar+YFAdd.h"
#define TabbarItemNums   5.0        //tabbar的数量 如果是5个设置为5.0

@implementation UITabBar (YFAdd)



- (void)yf_showNum:(NSInteger)num onItemIndex:(NSInteger)index {
    
    if (num <= 0) {
        [self yf_removeBadgeOnItemIndex:index];
        return;
    }
    
    /// 移除之前数字
    [self yf_removeBadgeOnItemIndex:index];
    ///新建显示数字
    UILabel *labelView = [[UILabel alloc] init];
    labelView.tag = 888 + index;
    labelView.layer.cornerRadius = 9;//圆形
    labelView.layer.masksToBounds = YES;
    labelView.backgroundColor = UIColorFromRGB(0xf80200);//颜色：红色
    labelView.text = [NSString stringWithFormat:@"%ld",(long)num];
    labelView.textColor  = UIColorWhite;
    labelView.font = YFBoldFontMake(11);
    labelView.textAlignment = NSTextAlignmentCenter;
    [labelView sizeToFit];
    CGRect tabFrame = self.frame;
    
    ///确定数字
    float percentX = (index +0.6) / TabbarItemNums;
    CGFloat x = ceilf(percentX * tabFrame.size.width);
    CGFloat y = ceilf(0.1 * tabFrame.size.height);
    labelView.frame = CGRectMake(x, y, 18, 18);//圆形大小为10
    [self addSubview:labelView];
}


- (void)yf_hideNumOnItemIndex:(NSInteger)index {
    [self yf_removeBadgeOnItemIndex:index];
}

- (void)yf_removeBadgeOnItemIndex:(NSInteger)index {
    /// 按照tag值进行移除
    for (UIView *subView in self.subviews) {
        if (subView.tag == 888+index) {
            [subView removeFromSuperview];
        }
    }
}


- (void)yf_showShoppingCartNum {
    [self yf_showNum:[CacheHelper shoppingCartCount] onItemIndex:3];
}

- (void)yf_hideShoppingCartNum {
    [self yf_showNum:0 onItemIndex:3];
}

- (void)yf_showShoppingCartNum:(NSInteger)num {
    [self yf_showNum:num onItemIndex:3];
}
@end
