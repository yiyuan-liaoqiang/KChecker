//
//  OilingStandardsCell.h
//  KChecker
//
//  Created by YanTing Zhang on 2019/4/22.
//

#import <UIKit/UIKit.h>
#import "CheckUPModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface OilingStandardsCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *componentName;
@property (weak, nonatomic) IBOutlet UILabel *partNameLbl;
@property (weak, nonatomic) IBOutlet UIImageView *contentIdImage;

@property (nonatomic, strong)StandardListModel *model;

@end

NS_ASSUME_NONNULL_END
