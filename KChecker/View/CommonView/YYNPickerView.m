//
//  YYNPickerView.m
//  yiyuan_OA
//
//  Created by Liao Qiang on 2018/4/19.
//  Copyright © 2018 Yiyuan Networks 上海义援网络科技有限公司. All rights reserved.
//

#import "YYNPickerView.h"

@implementation YYNPickerView

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
    self.picker = [[UIPickerView alloc] initWithFrame:CGRectMake(0, 40, MAIN_SCREEN_WIDTH, self.frame.size.height-40)];
    
    self.control = [[UIControl alloc] init];
    self.control.frame = CGRectMake(0, 0, MAIN_SCREEN_WIDTH, MAIN_SCREEN_HEIGHT);
    self.control.backgroundColor = RGBA(0, 0, 0, 0.2);
}

- (KeyboardHeaderView *)headerView
{
    if (_headerView == nil) {
        _headerView = [[KeyboardHeaderView alloc] initWithFrame:CGRectMake(0, 0, MAIN_SCREEN_WIDTH, 40)];
        __weak typeof(self) weakself = self;
        _headerView.callback = ^(NSInteger index) {
            [weakself handleHeaderViewCallback:index];
        };
    }
    return _headerView;
}

- (void)handleHeaderViewCallback:(NSInteger)index
{
    [self hide];
    if (index == 1) {
        self.callback([self.picker selectedRowInComponent:0]);
    }
}

- (void)show
{
    [self.superview insertSubview:self.control belowSubview:self];
    [self addSubview:self.picker];
    [self addSubview:self.headerView];
}

- (void)hide
{
    [self removeFromSuperview];
    [self.control removeFromSuperview];
    [self.picker removeFromSuperview];
    [self.headerView removeFromSuperview];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
