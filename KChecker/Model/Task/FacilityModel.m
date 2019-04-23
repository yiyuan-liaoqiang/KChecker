//
//  FacilityModel.m
//  KChecker
//
//  Created by YanTing Zhang on 2019/4/23.
//

#import "FacilityModel.h"

@implementation FacilityModel

+ (instancetype)loadFacility:(NSDictionary *)dict
{
    FacilityModel *model = [FacilityModel new];
    [model setValuesForKeysWithDictionary:dict];
    return model;
}

- (void)setValue:(id)value forUndefinedKey:(NSString *)key{
    
}

@end
