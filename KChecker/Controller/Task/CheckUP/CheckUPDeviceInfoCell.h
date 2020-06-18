//
//  CheckUPDeviceInfoCell.h
//  KChecker
//
//  Created by LiaoQiang on 2019/4/20.
//

#import <UIKit/UIKit.h>
#import "CheckUPModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface CheckUPDeviceInfoCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;

@property (nonatomic, strong)CheckUPModel *model;

@end

NS_ASSUME_NONNULL_END
