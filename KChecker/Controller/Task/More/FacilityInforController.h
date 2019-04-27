//
//  FacilityInforController.h
//  KChecker
//
//  Created by YanTing Zhang on 2019/4/22.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface FacilityInforController : UIViewController

@end

@interface TmpModel : NSObject

@property (nonatomic, strong) NSString *title;

@property (nonatomic, strong) NSString *serverKey;
@property (nonatomic, strong) id serverValue;

@end

NS_ASSUME_NONNULL_END
