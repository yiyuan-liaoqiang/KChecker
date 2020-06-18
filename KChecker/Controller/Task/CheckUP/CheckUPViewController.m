//
//  CheckUPViewController.m
//  KChecker
//
//  Created by LiaoQiang on 2019/4/19.
//

#import "CheckUPViewController.h"
#import "CheckUPDeviceInfoCell.h"
#import "CheckUPStandardsCell.h"
#import "KChecker-Swift.h"

@interface CheckUPViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong)UITableView *tableView;
@property (nonatomic, strong)NSArray<CheckUPModel *> *dataArray;
@end

@implementation CheckUPViewController

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
   
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self getPlan];
    
}

- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    CheckUPDeviceInfoCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell1"];
    cell.model = self.dataArray[indexPath.section];
    return cell;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.dataArray.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 10;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    return UIView.new;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 10;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    UIView *v = UIView.new;
    v.backgroundColor = kUIColorFromRGB(0xf5f5f5);
    return v;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
//    [YYRoute pushToController:@"PlanFormInputController" data:@{@"model":self.model.standards[indexPath.row],@"checkId":@(self.model.checkId)}];
}

//获取当前设备点检计划
- (void)getPlan {
    //
    NSString *urlString = [NSString stringWithFormat:@"http://111.229.39.85:9094/v2/facility/%@/plan/check",self.baseData[@"facilityId"]];

    [ActivityIndicatorManager showActivityIndicatorInView:self.view];
    [YYNSessionManager.defaultSessionManager method:@"get" URLString:urlString andParams:nil andHttpHeaders:nil success:^(id ret) {
        self.dataArray = [JsonStringTransfer dictionaryArray:ret ToModelArray:@"CheckUPModel"];
        [self setupTableView];
        [ActivityIndicatorManager hideActivityIndicatorInView:self.view];
    } failure:^(id error) {
        [self.view showWarningWithIcon:nil andTitle:@"该设备没有点检计划" andTopSpace:140];
        [ActivityIndicatorManager hideActivityIndicatorInView:self.view];
    }];
}

- (void)setupTableView {
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, MAIN_SCREEN_WIDTH, MAIN_SCREEN_HEIGHT) style:UITableViewStyleGrouped];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.rowHeight = 70;
    [self.tableView registerNib:[UINib nibWithNibName:@"CheckUPDeviceInfoCell" bundle:nil] forCellReuseIdentifier:@"cell1"];
    [self.tableView registerNib:[UINib nibWithNibName:@"CheckUPStandardsCell" bundle:nil] forCellReuseIdentifier:@"cell2"];
    self.tableView.separatorStyle = UITableViewCellSelectionStyleNone;
    self.tableView.backgroundColor = kUIColorFromRGB(0xf5f5f5);
    [self.view addSubview:self.tableView];
}

@end
