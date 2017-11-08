//
//  UIControl+YFAdd.m
//  IOSMall
//
//  Created by YangFei on 2017/1/23.
//  Copyright © 2017年 Social. All rights reserved.
//

#import "UIControl+YFAdd.h"

@interface UIControl ()
@property (nonatomic, assign) NSTimeInterval yf_acceptEventTime; // 接收事件的时间
@end



@implementation UIControl (YFAdd)

#pragma mark - /**************** 扩大view点击范围 ****************/

+ (void)load {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        ReplaceMethod([self class], @selector(pointInside:withEvent:), @selector(yf_pointInside:withEvent:));
        ReplaceMethod([self class], @selector(sendAction:to:forEvent:), @selector(yf_sendAction:to:forEvent:));
    });
}

- (BOOL)yf_pointInside:(CGPoint)point withEvent:(UIEvent *)event {
    if (UIEdgeInsetsEqualToEdgeInsets(self.yf_touchExtendInset, UIEdgeInsetsZero) || self.isHidden ||
        ([self isKindOfClass:UIControl.class] && !((UIControl *)self).isEnabled)) {
        return [self yf_pointInside:point withEvent:event];
    }
    CGRect hitFrame = UIEdgeInsetsInsetRect(self.bounds, self.yf_touchExtendInset);
    hitFrame.size.width = MAX(hitFrame.size.width, 0);
    hitFrame.size.height = MAX(hitFrame.size.height, 0);
    return CGRectContainsPoint(hitFrame, point);
}

static char * kAssociated_touchExtendInset = "kAssociatedObject_touchExtendInset";
- (void)setYf_touchExtendInset:(UIEdgeInsets)yf_touchExtendInset {
    objc_setAssociatedObject(self, &kAssociated_touchExtendInset, [NSValue valueWithUIEdgeInsets:yf_touchExtendInset],
                             OBJC_ASSOCIATION_COPY_NONATOMIC);
}

- (UIEdgeInsets)yf_touchExtendInset {
    return [objc_getAssociatedObject(self, &kAssociated_touchExtendInset) UIEdgeInsetsValue];
}



// 因category不能添加属性，只能通过关联对象的方式。
static const char * kAssociated_acceptEventInterval = "kAssociated_acceptEventInterval";

- (NSTimeInterval)yf_acceptEventInterval {
    return  [objc_getAssociatedObject(self, kAssociated_acceptEventInterval) doubleValue];
}

- (void)setYf_acceptEventInterval:(NSTimeInterval)yf_acceptEventInterval {
    objc_setAssociatedObject(self, kAssociated_acceptEventInterval, @(yf_acceptEventInterval), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}



static const char * kAssociated_acceptEventTime = "kAssociated_acceptEventTime";
- (NSTimeInterval)yf_acceptEventTime {
    return  [objc_getAssociatedObject(self, kAssociated_acceptEventTime) doubleValue];
}

- (void)setYf_acceptEventTime:(NSTimeInterval)yf_acceptEventTime {
    objc_setAssociatedObject(self, kAssociated_acceptEventTime, @(yf_acceptEventTime), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}


- (void)yf_sendAction:(SEL)action to:(id)target forEvent:(UIEvent *)event {
    
    NSTimeInterval nowTime = [NSDate date].timeIntervalSince1970;   
    NSTimeInterval acceptEventTime = self.yf_acceptEventTime;
    NSTimeInterval acceptEventInterval = self.yf_acceptEventInterval;
    
    
    if (nowTime - acceptEventTime < acceptEventInterval) return;
    
    if (self.yf_acceptEventInterval > 0) {
        self.yf_acceptEventTime = [NSDate date].timeIntervalSince1970;
    }
    
    [self yf_sendAction:action to:target forEvent:event];
}




@end
