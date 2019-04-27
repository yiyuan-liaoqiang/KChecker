//
//  CheckUPModel.m
//  KChecker
//
//  Created by LiaoQiang on 2019/4/20.
//

#import "CheckUPModel.h"
#import "NSString+CalculateSize.h"

@implementation CheckUPModel

- (void)setStandards:(NSArray<StandardListModel *> *)standards {
    if ([standards isKindOfClass:[NSArray<NSDictionary *> class]]) {
        _standards = [JsonStringTransfer dictionaryArray:standards ToModelArrayWithClass:StandardListModel.class];
    }
}

- (void)setValue:(id)value forUndefinedKey:(NSString *)key{}


@end

@implementation StandardListModel

- (CGFloat)height {
    if (_height == 0) {
        CGFloat oriHeight = 48;
        NSMutableParagraphStyle * paragraphStyle = [[NSMutableParagraphStyle alloc] init];
        [paragraphStyle setLineSpacing:4];
        CGFloat height = [self.attriStandard.string boundingRectWithSize:CGSizeMake(MAIN_SCREEN_WIDTH-79, 10000) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:14],NSParagraphStyleAttributeName :paragraphStyle} context:NULL].size.height;
        _height = oriHeight+height+20;
    }
    return _height;
}

- (NSAttributedString *)attriStandard {
    if (_attriStandard == nil) {
        NSString *des = [NSString stringWithFormat:@" 点检规范   %@",self.standard];
        NSMutableAttributedString *attri = [[NSMutableAttributedString alloc] initWithString:des];
        [attri addAttribute:NSBackgroundColorAttributeName value:kUIColorFromRGB(0x0D94FD) range:NSMakeRange(0, 6)];
        [attri addAttribute:NSForegroundColorAttributeName value:kUIColorFromRGB(0xFFFFFF) range:NSMakeRange(0, 6)];
        NSMutableParagraphStyle * paragraphStyle = [[NSMutableParagraphStyle alloc] init];
        [paragraphStyle setLineSpacing:4];
        
        [attri addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, [attri length])];
        _attriStandard = attri;
    }
    
    return _attriStandard;
}

- (void)setValue:(id)value forUndefinedKey:(NSString *)key{}

@end
