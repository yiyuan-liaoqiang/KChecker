//
//  NSString+CalculateSize.m
//  yiyuan_OA
//
//  Created by Liao Qiang on 2018/1/31.
//  Copyright © 2018 Yiyuan Networks 上海义援网络科技有限公司. All rights reserved.
//

#import "NSString+CalculateSize.h"

@implementation NSString (CalculateSize)

//根据label内容计算label大小
- (CGSize)sizeWithFont:(UIFont *)font constrainedToSize:(CGSize)size
{
    NSDictionary *attributes = @{NSFontAttributeName:font};
    CGRect rect = [self boundingRectWithSize:size options:NSStringDrawingUsesLineFragmentOrigin attributes:attributes context:NULL];
    return rect.size;
}

@end
