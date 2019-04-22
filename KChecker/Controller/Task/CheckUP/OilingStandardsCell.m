//
//  OilingStandardsCell.m
//  KChecker
//
//  Created by YanTing Zhang on 2019/4/22.
//

#import "OilingStandardsCell.h"

@implementation OilingStandardsCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setModel:(StandardListModel *)model {
    self.componentName.text = model.componentName;
    self.partNameLbl.text = model.partName;
    
    
    if(model.contentId)
    {
        self.contentIdImage.image = [UIImage imageNamed:@"dagou"];
    }
    else
    {
        self.contentIdImage.image = [UIImage imageNamed:@"selected"];
    }
}


@end
