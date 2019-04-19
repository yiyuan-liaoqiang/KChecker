//
//  UILabel+YYNExtension.h
//  yiyuan_OA
//
//  Created by Liao Qiang on 2018/5/2.
//  Copyright © 2018 Yiyuan Networks 上海义援网络科技有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UILabel (YYNExtension)

//根据label内容自动计算出大小，两边会各流出3px间距
- (void)autoSetWidthConstraint;
- (void)autoSetWidthConstraint:(CGFloat)space;

@end
