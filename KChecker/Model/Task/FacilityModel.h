//
//  FacilityModel.h
//  KChecker
//
//  Created by YanTing Zhang on 2019/4/23.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface FacilityModel : NSObject

@property (nonatomic ,copy)NSString *endTime;

@property (nonatomic ,copy)NSString *faultDate;

@property (nonatomic ,copy)NSString *questionType;

@property (nonatomic ,copy)NSString *startTime;

+ (instancetype)loadFacility:(NSDictionary *)dict;


@end

NS_ASSUME_NONNULL_END
