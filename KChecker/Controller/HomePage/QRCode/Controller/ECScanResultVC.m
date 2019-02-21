//
//  ECScanResultVC.m
//  YTXSDKDemo
//
//  Created by xt on 2017/8/1.
//
//

#import "ECScanResultVC.h"
#import "ECScanResultView.h"

@interface ECScanResultVC ()

@end

@implementation ECScanResultVC

#pragma mark - UI创建
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"扫描结果";
    if ([self.scanResultStr hasPrefix:@"http://"] || [self.scanResultStr hasPrefix:@"https://"]) {
        
    } else {
        ECScanResultView *resultView = [[ECScanResultView alloc] init];
        resultView.result = self.scanResultStr;
        [self.view addSubview:resultView];
        EC_WS(self)
        [resultView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.bottom.equalTo(weakSelf.view);
            make.top.equalTo(weakSelf.view).offset(NAV_BAR_HEIGHT);
        }];
    }
}

@end
