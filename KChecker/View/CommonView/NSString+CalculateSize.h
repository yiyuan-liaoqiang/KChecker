//
//  NSString+CalculateSize.h
//  yiyuan_OA
//
//  Created by Liao Qiang on 2018/1/31.
//  Copyright © 2018 Yiyuan Networks 上海义援网络科技有限公司. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (CalculateSize)

//根据label内容计算label大小
- (CGSize)sizeWithFont:(UIFont *)font constrainedToSize:(CGSize)size;

@end
