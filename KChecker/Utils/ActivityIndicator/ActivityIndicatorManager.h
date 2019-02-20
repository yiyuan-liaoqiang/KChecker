//
//  ActivityIndicatorManager.h
//  yiyuan_OA
//
//  Created by Liao Qiang on 2018/1/19.
//  Copyright © 2018 Liao Qiang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface ActivityIndicatorManager : NSObject

+ (void)showActivityIndicatorInView:(UIView *)view;

+ (void)hideActivityIndicatorInView:(UIView *)view;
//强制去掉菊花，不考虑计数
+ (void)forceHideActivityIndicatorInView:(UIView *)view;
@end
