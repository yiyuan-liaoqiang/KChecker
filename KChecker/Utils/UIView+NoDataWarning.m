//
//  UIView+NoDataWarning.m
//  yiyuan-OA
//
//  Created by LiaoQiang on 2018/10/12.
//  Copyright © 2018年 Yiyuan Networks 上海义援网络科技有限公司. All rights reserved.
//

#import "UIView+NoDataWarning.h"
#import <objc/runtime.h>

@implementation UIView (NoDataWarning)

static const void *titleLabelKey = &titleLabelKey;
static const void *iconKey = &iconKey;


- (void)setWarningTitleLabel:(UILabel *)warningTitleLabel {
    objc_setAssociatedObject(self, titleLabelKey, warningTitleLabel, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (void)setIconIv:(UIImageView *)iconIv {
    objc_setAssociatedObject(self, iconKey, iconIv, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (UIImageView *)iconIv {
    UIImageView *iconIv = objc_getAssociatedObject(self, iconKey);
    if (iconIv == nil) {
        iconIv = [[UIImageView alloc] init];
        iconIv.contentMode = UIViewContentModeScaleAspectFit;
        [self addSubview:iconIv];
        [self setIconIv:iconIv];
    }
    return iconIv;
}

- (UILabel *)warningTitleLabel
{
    UILabel *label = objc_getAssociatedObject(self, titleLabelKey);
    if (label == nil) {
        label = [[UILabel alloc] init];
        label.font = [UIFont systemFontOfSize:16];
        label.numberOfLines = 0;
        label.textColor = kUIColorFromRGB(0x999999);
        label.textAlignment = NSTextAlignmentCenter;
        [self addSubview:label];
        [self setWarningTitleLabel:label];
    }
    return label;
}

- (void)showWarningWithIcon:(NSString *)icon andTitle:(NSString *)title {
    [self showWarningWithIcon:icon andTitle:title andTopSpace:140];
}

- (void)showWarningWithIcon:(nullable NSString *)icon andTitle:(nullable NSString *)title andTopSpace:(CGFloat)top {
    if (icon.length) {
        self.iconIv.hidden = NO;
    }
    if (title.length) {
        self.warningTitleLabel.hidden = NO;
    }
    __weak typeof(self) weakself = self;
    [self.iconIv mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakself).offset(top);
        make.centerX.equalTo(weakself);
        make.width.height.offset(76);
    }];

    [self.warningTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        if (icon.length) {
            make.top.equalTo(weakself.iconIv.mas_bottomMargin).offset(30);
        }
        else {
            make.top.equalTo(weakself).offset(top);
        }
        make.left.equalTo(weakself).offset(20);
        make.centerX.equalTo(weakself);
    }];
    self.iconIv.image = [UIImage imageNamed:icon];
    self.warningTitleLabel.text = title;

}

- (void)hideWarning {
    self.iconIv.image = nil;
    self.iconIv.hidden = YES;
    self.warningTitleLabel.text = @"";
    self.warningTitleLabel.hidden = YES;
}

@end
