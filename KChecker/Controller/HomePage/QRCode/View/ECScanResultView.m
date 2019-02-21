//
//  ECScanResultView.m
//  YTXSDKDemo
//
//  Created by xt on 2017/8/1.
//
//

#import "ECScanResultView.h"

@interface ECScanResultView ()

@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UILabel *resultLabel;

@end

@implementation ECScanResultView

- (instancetype)initWithFrame:(CGRect)frame{
    if(self = [super initWithFrame:frame]){
        [self buildUI];
    }
    return self;
}

- (void)setResult:(NSString *)result{
    _result = result;
    _resultLabel.text = result;
}

#pragma mark - UI创建
- (void)buildUI{
    [self addSubview:self.resultLabel];
    EC_WS(self)
    
    [self.resultLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf).offset(16);
        make.left.right.equalTo(weakSelf).offset(15);
    }];
}

- (UILabel *)resultLabel{
    if(!_resultLabel){
        _resultLabel = [[UILabel alloc] init];
        _resultLabel.numberOfLines = 0;
    }
    return _resultLabel;
}

@end
