//
//  CheckUPStandardsCell.m
//  KChecker
//
//  Created by LiaoQiang on 2019/4/20.
//

#import "CheckUPStandardsCell.h"

@implementation CheckUPStandardsCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setModel:(StandardListModel *)model {
    self.componentNameLabel.text = model.componentName;
    self.partNameLabel.text = model.partName;
    self.styleLabel.text = model.style;
    NSString *des = [NSString stringWithFormat:@" 点检规范   %@",model.standard];
    NSMutableAttributedString *attri = [[NSMutableAttributedString alloc] initWithString:des];
    [attri addAttribute:NSBackgroundColorAttributeName value:kUIColorFromRGB(0x0D94FD) range:NSMakeRange(0, 6)];
    [attri addAttribute:NSForegroundColorAttributeName value:kUIColorFromRGB(0xFFFFFF) range:NSMakeRange(0, 6)];
    NSMutableParagraphStyle * paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    [paragraphStyle setLineSpacing:4];
    
    [attri addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, [attri length])];
    self.standardLabel.attributedText = attri;
    [self.styleLabel autoSetWidthConstraint:4];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
