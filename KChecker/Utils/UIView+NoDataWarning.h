//
//  UIView+NoDataWarning.h
//  yiyuan-OA
//
//  Created by LiaoQiang on 2018/10/12.
//  Copyright © 2018年 Yiyuan Networks 上海义援网络科技有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIView (NoDataWarning)
//如果使用titleLabel，在swift里面调用的时候，会出问题
@property (nonatomic, strong)UILabel *warningTitleLabel;
@property (nonatomic, strong)UIImageView *iconIv;

/*
 显示页面提醒，比如无搜索结果，无数据等的提示
 */
- (void)showWarningWithIcon:(nullable NSString *)icon andTitle:(nullable NSString *)title;

- (void)showWarningWithIcon:(nullable NSString *)icon andTitle:(nullable NSString *)title andTopSpace:(CGFloat)top;

- (void)hideWarning;

@end

NS_ASSUME_NONNULL_END
