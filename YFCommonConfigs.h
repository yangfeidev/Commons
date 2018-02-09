//
//  YFCommonConfigs.h
//
//  Created by YangFei on 2017/1/20.
//  Copyright © 2017年 Social. All rights reserved.
//

#ifndef YFCommonConfigs_h
#define YFCommonConfigs_h

#import <sys/time.h>
#import <pthread.h>
#import <objc/runtime.h>


/// Category
#import "UIControl+YFAdd.h"
#import "NSString+YFAdd.h"
#import "UIView+YFAdd.h"
#import "NSDate+YFAdd.h"
#import "UIImage+YFAdd.h"
#import "UILabel+YFAdd.h"
#import "UIGestureRecognizer+YFAdd.h"
#import "UINavigationController+YFAdd.h"
#import "NSDictionary+YFAdd.h"
#import "UITabBar+YFAdd.h"




/// Tools
#import "YFAlertTool.h"
#import "YFHelper.h"

/// NotificationName Const
#import "YFConstant.h"

#pragma mark - /**************** UI ****************/

/** 字体*/
#define YFFontMake(size) [UIFont systemFontOfSize:size]
#define YFBoldFontMake(size) [UIFont boldSystemFontOfSize:size]

/** 颜色*/
#define YFColorMake(r,g,b)          [UIColor colorWithRed:(r)/255.0f green:(g)/255.0f blue:(b)/255.0f alpha:1]
#define YFRGBAColorMake(r,g,b,a)    [UIColor colorWithRed:(r)/255.0f green:(g)/255.0f blue:(b)/255.0f alpha:(a)]

#define YFRGB16ColorMake(rgbValue)  [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0    \
                                                    green:((float)((rgbValue & 0xFF00) >> 8))/255.0       \
                                                     blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]

#define UIColorClear                [UIColor clearColor]
#define UIColorWhite                [UIColor whiteColor]
#define UIColorBlack                [UIColor blackColor]
#define UIColorGray                 [UIColor grayColor]
#define UIColorRed                  [UIColor redColor]
#define UIColorGreen                [UIColor greenColor]
#define UIColorBlue                 [UIColor blueColor]
#define UIColorYellow               [UIColor yellowColor]
#define UIColorOrange               [UIColor orangeColor]
#define UIColorCyan                 [UIColor cyanColor]
#define UIColorLightGray            [UIColor lightGrayColor]
#define UIColorDarkGray             [UIColor darkGrayColor]

#pragma mark - /**************** 适配 ****************/

/** 获取硬件信息*/
//#define YFScreen_W   ([UIScreen mainScreen].bounds.size.width)
//#define YFScreen_H   ([UIScreen mainScreen].bounds.size.height)
//#define YFCurrentLanguage ([[NSLocale preferredLanguages] objectAtIndex:0])

/** 适配*/
#ifndef YFSystemVersion
#define YFSystemVersion  ([UIDevice currentDevice].systemVersion.doubleValue)
#endif


/** 设备屏幕尺寸*/
#define IS_58INCH_SCREEN    [YFHelper is58InchScreen]
#define IS_55INCH_SCREEN    [YFHelper is55InchScreen]
#define IS_47INCH_SCREEN    [YFHelper is47InchScreen]
#define IS_40INCH_SCREEN    [YFHelper is40InchScreen]
#define IS_35INCH_SCREEN    [YFHelper is35InchScreen]

/// 控件高度
#define YFNavigationBarHeight  (44)
#define YFTabBarHeight         ([YFHelper is58InchScreen] ? 83:49)
#define YFStatusBarHeight      (20)

#define ScreenScale ([[UIScreen mainScreen] scale])


/** YF */
#define YFiPhone4_OR_4s           (SCREEN_HEIGHT == 480)
#define YFiPhone5_OR_5c_OR_5s     (SCREEN_HEIGHT == 568)
#define YFiPhone6_OR_6s           (SCREEN_HEIGHT == 667)
#define YFiPhone6Plus_OR_6sPlus   (SCREEN_HEIGHT == 736)
#define YFiPhoneX                 (SCREEN_HEIGHT == 812)
#define YFiPad                    (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)

#pragma mark - /**************** 常用代码 ****************/
/** 加载本地文件*/
#define YFLoadImage(file,type) [UIImage imageWithContentsOfFile:[[NSBundle mainBundle]pathForResource:file ofType:type]]
#define YFLoadArray(file,type) [UIImage arrayWithContentsOfFile:[[NSBundle mainBundle]pathForResource:file ofType:type]]
#define YFLoadDict(file,type)  [UIImage dictionaryWithContentsOfFile:[[NSBundle mainBundle]pathForResource:file ofType:type]]


/** 数据存储*/
#define YFUserDefaults         [NSUserDefaults standardUserDefaults]
#define YFCacheDir             [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject]
#define YFDocumentDir          [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject]
#define YFTempDir              NSTemporaryDirectory()

#pragma mark - /**************** 单例 ****************/

#define   YFUserDefaults            [NSUserDefaults standardUserDefaults]
#define   YFNotificationDefault     [NSNotificationCenter defaultCenter]
/** 提示消息 */
#define   YFAlertMessage(msg)       [YFAlertTool alertMessage:msg];

/// 默认图
#define MallDefaultPic  [UIImage imageNamed:@"DefaultPic"]


#pragma mark - /**************** Clang ****************/
#define ArgumentToString(macro) #macro
#define ClangWarningConcat(warning_name) ArgumentToString(clang diagnostic ignored warning_name)

// 参数可直接传入 clang 的 warning 名，warning 列表参考：http://fuckingclangwarnings.com/
#define BeginIgnoreClangWarning(warningName) _Pragma("clang diagnostic push") _Pragma(ClangWarningConcat(#warningName))
#define EndIgnoreClangWarning _Pragma("clang diagnostic pop")

#define BeginIgnorePerformSelectorLeaksWarning BeginIgnoreClangWarning(-Warc-performSelector-leaks)
#define EndIgnorePerformSelectorLeaksWarning EndIgnoreClangWarning

#define BeginIgnoreAvailabilityWarning BeginIgnoreClangWarning(-Wpartial-availability)
#define EndIgnoreAvailabilityWarning EndIgnoreClangWarning

#define BeginIgnoreDeprecatedWarning BeginIgnoreClangWarning(-Wdeprecated-declarations)
#define EndIgnoreDeprecatedWarning EndIgnoreClangWarning


#pragma mark - /**************** 函数 ****************/
/** 主线程执行方法 */
CG_INLINE void
dispatch_async_on_main_queue(void (^block)()) {
    if (pthread_main_np()) {
        block();
    } else {
        dispatch_async(dispatch_get_main_queue(), block);
    }
}

/** 延迟执行方法 */
CG_INLINE void
dispatch_after_time_on_main_queue(NSInteger second, void (^block)()) {
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(second * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        block();
    });
}   

/** 交换方法 */
CG_INLINE void
ReplaceMethod(Class _class, SEL _originSelector, SEL _newSelector) {
    Method oriMethod = class_getInstanceMethod(_class, _originSelector);
    Method newMethod = class_getInstanceMethod(_class, _newSelector);
    BOOL isAddedMethod = class_addMethod(_class, _originSelector, method_getImplementation(newMethod), method_getTypeEncoding(newMethod));
    if (isAddedMethod) {
        class_replaceMethod(_class, _newSelector, method_getImplementation(oriMethod), method_getTypeEncoding(oriMethod));
    } else {
        method_exchangeImplementations(oriMethod, newMethod);
    }
}
/* 传入size，返回一个 (x,y) 为 (0,0) 的 CGRect */
CG_INLINE CGRect
CGRectMakeWithSize(CGSize size) {
    return CGRectMake(0, 0, size.width, size.height);
}


/// 获取UIEdgeInsets在水平方向上的值
CG_INLINE CGFloat
UIEdgeInsetsGetHorizontalValue(UIEdgeInsets insets) {
    return insets.left + insets.right;
}

/// 获取UIEdgeInsets在垂直方向上的值
CG_INLINE CGFloat
UIEdgeInsetsGetVerticalValue(UIEdgeInsets insets) {
    return insets.top + insets.bottom;
}



#pragma mark - CGFloat

/**
 *  某些地方可能会将 CGFLOAT_MIN 作为一个数值参与计算（但其实 CGFLOAT_MIN 更应该被视为一个标志位而不是数值），可能导致一些精度问题，所以提供这个方法快速将 CGFLOAT_MIN 转换为 0
 *  issue: https://github.com/QMUI/QMUI_iOS/issues/203
 */
CG_INLINE CGFloat
removeFloatMin(CGFloat floatValue) {
    return floatValue == CGFLOAT_MIN ? 0 : floatValue;
}
/**
 *  基于指定的倍数，对传进来的 floatValue 进行像素取整。若指定倍数为0，则表示以当前设备的屏幕倍数为准。
 *
 *  例如传进来 “2.1”，在 2x 倍数下会返回 2.5（0.5pt 对应 1px），在 3x 倍数下会返回 2.333（0.333pt 对应 1px）。
 */
CG_INLINE CGFloat
flatSpecificScale(CGFloat floatValue, CGFloat scale) {
    floatValue = removeFloatMin(floatValue);
    scale = scale == 0 ? ScreenScale : scale;
    CGFloat flattedValue = ceil(floatValue * scale) / scale;
    return flattedValue;
}
/**
 *  基于当前设备的屏幕倍数，对传进来的 floatValue 进行像素取整。
 *
 *  注意如果在 Core Graphic 绘图里使用时，要注意当前画布的倍数是否和设备屏幕倍数一致，若不一致，不可使用 flat() 函数，而应该用 flatSpecificScale
 */
CG_INLINE CGFloat
flat(CGFloat floatValue) {
    return flatSpecificScale(floatValue, 0);
}
/// 对CGRect的x/y、width/height都调用一次flat，以保证像素对齐
CG_INLINE CGRect
CGRectFlatted(CGRect rect) {
    return CGRectMake(flat(rect.origin.x), flat(rect.origin.y), flat(rect.size.width), flat(rect.size.height));
}
/// 为一个CGRect叠加scale计算
CG_INLINE CGRect
CGRectApplyScale(CGRect rect, CGFloat scale) {
    return CGRectFlatted(CGRectMake(CGRectGetMinX(rect) * scale, CGRectGetMinY(rect) * scale, CGRectGetWidth(rect) * scale, CGRectGetHeight(rect) * scale));
}



/// JBL
#define MallMainStroyboard                           [UIStoryboard storyboardWithName:@"Main_iPhone" bundle:nil]

#define MallInstantiateViewControllerWithIdentifier(identifier)  \
[MallMainStroyboard instantiateViewControllerWithIdentifier:identifier]

#define MallNavigationController                     (UINavigationController *)[UIApplication sharedApplication].keyWindow.rootViewController
#define YFPushViewControllerWithAnimation(__vc__)    [self.navigationController pushViewController:__vc__ animated:YES]


#define YFStringIsEquals(string, anotherString)       [string isEqualToString:anotherString]



#endif /* YFCommonConfigs_h */












