//
//  NSArray+Ex.m
//  04-解决数组输出汉字的问题
//
//  Created by Apple on 15/10/20.
//  Copyright © 2015年 heima. All rights reserved.
//

#import "NSArray+Ex.h"

@implementation NSArray (Ex)

-(NSString *)descriptionWithLocale:(id)locale indent:(NSUInteger)level
{
    NSMutableString *mStr = [NSMutableString string];
    [mStr appendString:@"(\r\n"];
    [self enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [mStr appendFormat:@"\t%@,\r\n",obj];
    }];
    
    [mStr appendString:@")"];
    return mStr.copy;
    
}

//- (NSString *)descriptionWithLocale:(id)locale indent:(NSUInteger)level
//{
//
//}

//- (NSString *)descriptionWithLocale:(id)locale {
//    NSMutableString *mStr = [NSMutableString string];
//    [mStr appendString:@"(\r\n"];
//    [self enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
//        [mStr appendFormat:@"\t%@,\r\n",obj];
//    }];
//    
//    [mStr appendString:@")"];
//    return mStr.copy;
//}
@end
