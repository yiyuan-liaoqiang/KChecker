//
//  JasonStringTransfer.m
//  RuYi
//
//  Created by DLin on 14-10-31.
//  Copyright (c) 2014-2015 DLin. All rights reserved.
//

#import "JsonStringTransfer.h"
#import "JSONKit.h"
#import "MJExtension.h"

@implementation JsonStringTransfer
//json字符串转字典，数组
+ (id)jsonStringToDictionary:(NSString *)jsonString
{
    id ob;
    if([jsonString isKindOfClass:[NSString class]])
    {
        ob = [jsonString objectFromJSONStringWithParseOptions:JKParseOptionLooseUnicode];
    }
    else
    {
        ob = jsonString;
    }
    return ob;
}
//字典，数组转json字符串
//数据量特别大的时候，好像不行
+ (NSString *)objectToJsonString:(id)object
{
    NSString *jsonString = [object JSONString];
//    NSString *jsonString = [self DataTOjsonString:object];
    return jsonString;
}

+(NSString*)DataTOjsonString:(id)object
{
    NSString *jsonString = nil;
    NSError *error;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:object
                                                       options:NSJSONWritingPrettyPrinted // Pass 0 if you don't care about the readability of the generated string
                                                         error:&error];
    if (! jsonData) {
        NSLog(@"Got an error: %@", error);
    } else {
        jsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    }
    return jsonString;
}

//字典转model
+(id)dictionary:(NSDictionary *)dic ToModel:(NSString*)modelStr
{
    Class class = NSClassFromString(modelStr);
    if ([dic isKindOfClass:class]) {
        return dic;
    }
    id model = [[class alloc] init];
    model = [[model class] mj_objectWithKeyValues:dic];
    return model;
}

//字典转model
+(id)dictionary:(NSDictionary *)dic ToModelWithClass:(Class)class
{
//    Class class = NSClassFromString(modelStr);
    id model = [[class alloc] init];
    model = [[model class] mj_objectWithKeyValues:dic];
    return model;
}

//字典array转model array
+(NSArray *)dictionaryArray:(NSArray *)dicArray ToModelArray:(NSString*)modelStr
{
    if ([dicArray isKindOfClass:NSArray.class]) {
        NSMutableArray *modelArray = [[NSMutableArray alloc] init];
        for (NSDictionary *dic in dicArray) {
            if ([dic isKindOfClass:NSDictionary.class]) {
                [modelArray addObject:[self dictionary:dic ToModel:modelStr]];
            }
            else if ([dic isKindOfClass:[NSArray<NSDictionary *> class]]) {
                [modelArray addObject:[self dictionaryArray:(id)dic ToModelArray:modelStr]];
            }
            else if ([dic isKindOfClass:NSClassFromString(modelStr)]) {
                [modelArray addObject:dic];
            }
        }
        return [modelArray copy];
    }
    else
    {
        if (dicArray == nil) {
            return nil;
        }
        return @[];
    }
}

+(NSArray *)dictionaryArray:(NSArray *)dicArray ToModelArrayWithClass:(Class)modelClass
{
    if ([dicArray isKindOfClass:NSArray.class]) {
        NSMutableArray *modelArray = [[NSMutableArray alloc] init];
        for (NSDictionary *dic in dicArray) {
            [modelArray addObject:[self dictionary:dic ToModelWithClass:modelClass]];
        }
        return [modelArray copy];
    }
    else
    {
        return @[];
    }
}
//model转字典
+ (NSDictionary *)modelToDictionary:(NSObject*)model
{
    NSDictionary *dict = model.mj_keyValues;
    return dict;
}
//model转jsonString
+ (NSString *)modelToJsonString:(NSObject *)model
{
    //先把model转字典，再把字典转jsonstring
    NSDictionary *dict = model.mj_keyValues;
    
    NSString *jsonString = [dict JSONString];
    return jsonString;
}

+ (id)modelArrayTotDicArray:(NSArray *)modelArray
{
    NSMutableArray *marray = [modelArray mutableCopy];
    for (NSInteger i = 0; i<modelArray.count; i++) {
        NSDictionary *tmpDic = [self modelToDictionary:modelArray[i]];
        [marray replaceObjectAtIndex:i withObject:tmpDic];
    }
    return marray;
}

@end
