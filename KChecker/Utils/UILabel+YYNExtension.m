//
//  UILabel+YYNExtension.m
//  yiyuan_OA
//
//  Created by Liao Qiang on 2018/5/2.
//  Copyright © 2018 Yiyuan Networks 上海义援网络科技有限公司. All rights reserved.
//

#import "UILabel+YYNExtension.h"
#import "NSString+CalculateSize.h"
#import <objc/runtime.h>

@implementation UILabel (YYNExtension)

+ (void)load
{
    if ([self respondsToSelector:@selector(setText:)]) {
        Method originalM = class_getInstanceMethod([self class], @selector(setText:));
        
        Method exchangeM = class_getInstanceMethod([self class], @selector(lq_setText:));
        
        /** 交换方法 */
        method_exchangeImplementations(originalM, exchangeM);
    }
}

- (void)autoSetWidthConstraint
{
    [self autoSetWidthConstraint:3];
}

- (void)autoSetWidthConstraint:(CGFloat)space {
    CGSize size = [self.text sizeWithFont:self.font constrainedToSize:CGSizeMake(MAIN_SCREEN_WIDTH-100, 20)];
    BOOL hasWidthConstraint = NO;
    for (NSLayoutConstraint *constraint in self.constraints) {
        if (constraint.firstAttribute == NSLayoutAttributeWidth) {
            constraint.constant = size.width+space*2;
            hasWidthConstraint = YES;
        }
    }
    if (!hasWidthConstraint) {
        [self mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.offset(size.width+space*2);
        }];
    }
}

/** 自定义的方法 */
-(nullable instancetype)lq_setText:(id)text{

    if (text == [NSNull null]) {
        NSLog(@"string报null错了");
        return [self lq_setText:@""];
    }
    else
    {
        return [self lq_setText:text];
    }
}

@end
