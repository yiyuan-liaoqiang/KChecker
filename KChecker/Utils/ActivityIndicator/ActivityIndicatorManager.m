//
//  ActivityIndicatorManager.m
//  yiyuan_OA
//
//  Created by Liao Qiang on 2018/1/19.
//  Copyright © 2018 Liao Qiang. All rights reserved.
//

#import "ActivityIndicatorManager.h"
#import "KChecker-Swift.h"

@implementation ActivityIndicatorManager

static NSMutableDictionary *_AllDataDic;

+ (void)showActivityIndicatorInView:(UIView *)view
{
    if (_AllDataDic == nil) {
        _AllDataDic = [[NSMutableDictionary alloc] init];
    }
    if (view == nil) {
        return;
    }
    //获取内存地址作为key
    NSString *key = [NSString stringWithFormat:@"%p",view];
    NSMutableDictionary *subDic = [_AllDataDic objectForKey:key];
    if ([subDic[@"count"] integerValue] == 0) {
        //说明当前view没有正在loading，需要新建loading
        subDic = [[NSMutableDictionary alloc] init];
        subDic[@"count"] = @"1";
        _AllDataDic[key] = subDic;
        [ActivityIndicator progressHudShowWithViewOnView:view];
    }
    else
    {
        //当前view正在loading，只需要把"count"+1即可
        subDic[@"count"] =  [NSString stringWithFormat:@"%ld",[subDic[@"count"] integerValue]+1];
    }
}

+ (void)hideActivityIndicatorInView:(UIView *)view
{
    if (view == nil) {
        return;
    }
    NSString *key = [NSString stringWithFormat:@"%p",view];
    NSMutableDictionary *subDic = [_AllDataDic objectForKey:key];
    if ([subDic[@"count"] integerValue]>0) {
        //说明当前有view正在loading，需要count--
        subDic[@"count"] = [NSString stringWithFormat:@"%ld",[subDic[@"count"]integerValue]-1];
    }
    //判断，如果count==0，则移除indicator
    if ([subDic[@"count"]integerValue] == 0) {
        [ActivityIndicator progresshHUDRemovedWithViewOnView:view];
        //移除计数数据
        [_AllDataDic removeObjectForKey:key];
    }
}

+ (void)forceHideActivityIndicatorInView:(UIView *)view
{
    [ActivityIndicator progresshHUDRemovedWithViewOnView:view];
}

@end
