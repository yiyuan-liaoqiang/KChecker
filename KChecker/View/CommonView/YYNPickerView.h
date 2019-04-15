//
//  YYNPickerView.h
//  yiyuan_OA
//
//  Created by Liao Qiang on 2018/4/19.
//  Copyright © 2018 Yiyuan Networks 上海义援网络科技有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "KeyboardHeaderView.h"

typedef void (^YYNPickerViewCallback)(NSInteger index);

@interface YYNPickerView : UIView

@property (nonatomic, strong)UIControl *control;
@property (nonatomic, strong)UIPickerView *picker;
@property (nonatomic, strong)KeyboardHeaderView *headerView;

@property (nonatomic, strong)YYNPickerViewCallback callback;

- (void)show;
- (void)hide;

@end
