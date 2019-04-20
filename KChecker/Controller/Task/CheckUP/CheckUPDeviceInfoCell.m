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
    self.nameLabel.text = model.facilityName;
    self.modelLabel.text = model.facilityModel;
    self.timeLabel.text = model.planTime;
    self.cycleLabel.text = [NSString stringWithFormat:@"周期%ld天",model.cycle];
    [self.modelLabel autoSetWidthConstraint:5];
    [self.cycleLabel autoSetWidthConstraint:5];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
