//
//  keyboardHeaderView.h
//  yiyuan_OA
//
//  Created by Liao Qiang on 2018/3/22.
//  Copyright © 2018 Liao Qiang. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^KeyboardHeaderViewCallback)(NSInteger index);

@interface KeyboardHeaderView : UIView

@property (nonatomic, strong)UIButton *cancelBtn;
@property (nonatomic, strong)UIButton *okBtn;
@property (nonatomic, strong)KeyboardHeaderViewCallback callback;

- (id)initWithCancelBtnTitle:(NSString *)cancelTitle andOkBtnTitle:(NSString *)okTitle;

@end
