//
//  SettingModel.h
//  KChecker
//
//  Created by YanTing Zhang on 2019/4/19.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface SettingModel : NSObject
@property (nonatomic ,copy)NSString *title;
@property (nonatomic ,copy)NSString *rightarrows;
//点击箭头的方法名字
@property (nonatomic ,copy)NSString *selector;

+ (instancetype)loadSettingModel:(NSDictionary *)dict;
+ (NSArray *)loadDataArray;



@end

NS_ASSUME_NONNULL_END
