//
//  YFConstant.h
//  MobileMall
//
//  Created by YangFei on 2016/11/1.
//  Copyright © 2016年 SoftBest1. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef  NSString*  YFNotificationName;

FOUNDATION_EXTERN YFNotificationName const  PushToPointRecordNotification;

FOUNDATION_EXTERN YFNotificationName const  MyPointViewControllerPopNotification;

FOUNDATION_EXTERN YFNotificationName const  PresentTimeSelectViewControllerNotification;

FOUNDATION_EXTERN YFNotificationName const  UserCenterAutoPushToHomePageNotification;

FOUNDATION_EXPORT YFNotificationName const  YFClubListRefreshListNotification;

FOUNDATION_EXPORT YFNotificationName const  HPJumpWithSectionItemNotification;


FOUNDATION_EXTERN NSString * const  IsPresentTimeSelectViewControllerKey;

FOUNDATION_EXTERN NSString * const  IsGoToHomePageKey;
FOUNDATION_EXPORT NSString * const  MobileMallDownloadUrlKey;

FOUNDATION_EXPORT NSString * const  JPushMessageKey;

////////////////////////   alertViewTool  /////////////////////

//FOUNDATION_EXTERN NSString * const UIAlertToolTitleCancel;

//FOUNDATION_EXTERN NSString * const UIAlertToolTitleConfirm;


//// 跳转相关
/// 1. 搜索
//FOUNDATION_EXTERN NSString * const HPProductSearchNavUrl;
///// 2. 分类页面   eg. jblmall://Category/白酒
//FOUNDATION_EXTERN NSString * const HPCategoryNavUrl;
///// 3.跳转内部界面
////  jblmall://Page/BrandClub      品牌俱乐部
////  jblmall://Page/UserCenter     个人中心
////  jblmall://Page/MyOrder        我的订单
////  jblmall://Page/ShoppingCart   购物车
////  jblmall://Page/CustomerPoint  积分兑换
////  jblmall://Page/Coupon         我的优惠券
////  jblmall://Page/Login          登录界面
//
//FOUNDATION_EXTERN NSString * const HPPageNavUrl;
///// 4. 商品详情   jblmall://ProductDetail/商品ID/促销ID/是否跳转,1跳,0不跳
//FOUNDATION_EXTERN NSString * const HPProductDetailNavUrl;
//
//FOUNDATION_EXTERN NSString * const HPProductSearchNavUrl;

