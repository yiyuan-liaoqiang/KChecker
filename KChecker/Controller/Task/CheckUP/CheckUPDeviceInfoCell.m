//
//  CheckUPDeviceInfoCell.m
//  KChecker
//
//  Created by LiaoQiang on 2019/4/20.
//

#import "CheckUPDeviceInfoCell.h"

@implementation CheckUPDeviceInfoCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setModel:(CheckUPModel *)model {
    self.nameLabel.text = [NSString stringWithFormat:@"%@ %@",model.componentName,model.partName];
//    self.timeLabel.text = model.planTime;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
