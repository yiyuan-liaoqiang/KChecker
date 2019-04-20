//
//  JasonStringTransfer.h
//  RuYi
//
//  Created by Dlin on 14-10-31.
//  Copyright (c) 2014年 Dlin. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface JsonStringTransfer : NSObject
//json字符串转字典，数组
+ (id)jsonStringToDictionary:(NSString *)jsonString;

//字典，数组转json字符串
+ (NSString *)objectToJsonString:(id)object;

//字典转model
+(id)dictionary:(NSDictionary *)dic ToModel:(NSString*)modelStr;
//字典转model
+(id)dictionary:(NSDictionary *)dic ToModelWithClass:(Class)modelClass;

//字典array转model array
+(NSArray *)dictionaryArray:(NSArray *)dicArray ToModelArray:(NSString*)modelStr;

+(NSArray *)dictionaryArray:(NSArray *)dicArray ToModelArrayWithClass:(Class)modelClass;

//model转字典
+ (NSDictionary *)modelToDictionary:(NSObject*)model;

//model转jsonString
+ (NSString *)modelToJsonString:(NSObject *)model;

+ (id)modelArrayTotDicArray:(NSArray *)modelArray;

@end
