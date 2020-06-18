//
//  CheckUPModel.h
//  KChecker
//
//  Created by LiaoQiang on 2019/4/20.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@class StandardListModel;

@interface CheckUPModel : NSObject

@property (nonatomic, strong)NSString *facilityName;

@property (nonatomic, strong)NSString *facilityModel;

@property (nonatomic, strong)NSString *planTime;

@property (nonatomic, assign)NSInteger cycle;

@property (nonatomic, assign)NSInteger checkId;

@property (nonatomic, strong)NSArray<StandardListModel *> *standards;

//new
@property (nonatomic, strong)NSString *partName;

@property (nonatomic, strong)NSString *contentId;

@property (nonatomic, assign)NSInteger type;

@property (nonatomic, strong)NSString *componentName;


@end

@interface StandardListModel : NSObject

@property (nonatomic, strong)NSString *partName;

@property (nonatomic, strong)NSString *standard;

@property (nonatomic, strong)NSString *style;

@property (nonatomic, strong)NSString *componentName;

@property (nonatomic, assign)NSInteger standardId;

@property (nonatomic, assign)CGFloat height;

@property (nonatomic, strong)NSAttributedString *attriStandard;

@property (nonatomic ,copy)NSString *contentId;


@end

NS_ASSUME_NONNULL_END
