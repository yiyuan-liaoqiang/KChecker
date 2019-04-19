//
//  CheckUPStandardsCell.h
//  KChecker
//
//  Created by LiaoQiang on 2019/4/20.
//

#import <UIKit/UIKit.h>
#import "CheckUPModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface CheckUPStandardsCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *componentNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *partNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *styleLabel;
@property (weak, nonatomic) IBOutlet UILabel *standardLabel;

@property (nonatomic, strong)StandardListModel *model;
@end

NS_ASSUME_NONNULL_END
