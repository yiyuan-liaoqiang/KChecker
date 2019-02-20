//
//  keyboardHeaderView.m
//  yiyuan_OA
//
//  Created by Liao Qiang on 2018/3/22.
//  Copyright © 2018 Liao Qiang. All rights reserved.
//

#import "KeyboardHeaderView.h"

@implementation KeyboardHeaderView

- (id)initWithCancelBtnTitle:(NSString *)cancelTitle andOkBtnTitle:(NSString *)okTitle
{
    self = [super init];
    if (self) {
        [self setupUI];
        [self.cancelBtn setTitle:cancelTitle forState:UIControlStateNormal];
        [self.okBtn setTitle:okTitle forState:UIControlStateNormal];
    }
    return self;
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setupUI];
    }
    return self;
}

- (void)setupUI
{
    self.cancelBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.cancelBtn.frame = CGRectMake(0, 0, 60, 40);
    [self.cancelBtn setTitle:@"取消" forState:UIControlStateNormal];
    [self.cancelBtn setTitleColor:kUIColorFromRGB(0xCCCCCC) forState:UIControlStateNormal];
    self.cancelBtn.titleLabel.font = [UIFont systemFontOfSize:16];
    [self.cancelBtn addTarget:self action:@selector(cancel) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:self.cancelBtn];
    
    self.okBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.okBtn.frame = CGRectMake(MAIN_SCREEN_WIDTH-60, 0, 60, 40);
    [self.okBtn setTitle:@"确定" forState:UIControlStateNormal];
    [self.okBtn setTitleColor:kUIColorFromRGB(0x3E74E7) forState:UIControlStateNormal];
    self.okBtn.titleLabel.font = [UIFont systemFontOfSize:16];
    [self.okBtn addTarget:self action:@selector(ok) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:self.okBtn];
}

- (void)cancel
{
    [self.superview endEditing:YES];
    if (self.callback) {
        self.callback(0);
    }
}

- (void)ok
{
    [self.superview endEditing:YES];
    if (self.callback) {
        self.callback(1);
    }
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
