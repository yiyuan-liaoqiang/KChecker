//
//  OilingPlanViewController.m
//  KChecker
//
//  Created by YanTing Zhang on 2019/4/22.
//

#import "OilingPlanViewController.h"
#import "CheckUPDeviceInfoCell.h"
#import "CheckUPStandardsCell.h"
#import "OilingStandardsCell.h"
@interface OilingPlanViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong)UITableView *tableView;
@property (nonatomic, strong)CheckUPModel *model;

@end

@implementation OilingPlanViewController

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self oilingPlan];
    
}

- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        CheckUPDeviceInfoCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell1"];
        cell.model = self.model;
        return cell;
    }
    else {
        OilingStandardsCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell2"];
        cell.model = self.model.standards[indexPath.row];
        return cell;
    }
}

- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0) {
        return 1;
    }
    return self.model.standards.count;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        return 85;
    }
    return 90;
//    return self.model.standards[indexPath.row].height;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 0.01;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    return UIView.new;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    if (section == 0) {
        return 26;
    }
    return 0.01;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    UIView *v = UIView.new;
    v.backgroundColor = kUIColorFromRGB(0xf5f5f5);
    return v;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

//获取当前设备润滑计划
- (void)oilingPlan
{
    NSString *urlString = [NSString stringWithFormat:@"http://111.229.39.85:9094/v2/facility/%@/plan/lubrication",self.baseData[@"facilityId"]];
    [YYNSessionManager.defaultSessionManager method:@"get" URLString:urlString andParams:nil andHttpHeaders:nil success:^(id ret) {
        self.model = [JsonStringTransfer dictionary:ret ToModel:@"CheckUPModel"];
        [self setupTableView];
    } failure:^(id error) {
        //没有找到润滑计划
        self.model = nil;
        [self.view showWarningWithIcon:nil andTitle:@"该设备没有润滑计划" andTopSpace:140];
        NSLog(@"");
    }];
}

- (void)setupTableView {
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, MAIN_SCREEN_WIDTH, MAIN_SCREEN_HEIGHT) style:UITableViewStyleGrouped];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.tableView registerNib:[UINib nibWithNibName:@"CheckUPDeviceInfoCell" bundle:nil] forCellReuseIdentifier:@"cell1"];
    [self.tableView registerNib:[UINib nibWithNibName:@"OilingStandardsCell" bundle:nil] forCellReuseIdentifier:@"cell2"];
    self.tableView.separatorStyle = UITableViewCellSelectionStyleNone;
    self.tableView.backgroundColor = kUIColorFromRGB(0xf5f5f5);
    [self.view addSubview:self.tableView];
}


@end
