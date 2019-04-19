//
//  SettingModel.m
//  KChecker
//
//  Created by YanTing Zhang on 2019/4/19.
//

#import "SettingModel.h"

@implementation SettingModel

+ (instancetype)loadSettingModel:(NSDictionary *)dict
{
    SettingModel *model = [SettingModel new];
    [model setValuesForKeysWithDictionary:dict];
    return model;
}

+ (NSArray *)loadDataArray
{
    NSMutableArray *mArray = [NSMutableArray arrayWithCapacity:10];
    NSString *path = [[NSBundle mainBundle] pathForResource:@"Setting.plist" ofType:nil];
    NSArray *array = [NSArray arrayWithContentsOfFile:path];
    [array enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        SettingModel *model = [SettingModel loadSettingModel:obj];
        [mArray addObject:model];
    }];
    array = mArray.copy;
    return array;
}

@end
