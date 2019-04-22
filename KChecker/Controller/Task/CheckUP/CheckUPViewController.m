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
@property (nonatomic, strong)CheckUPModel *model;

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
    [self setupTableView];
    
    
    
}

- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        CheckUPDeviceInfoCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell1"];
        cell.model = self.model;
        return cell;
    }
    else {
        CheckUPStandardsCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell2"];
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
    return self.model.standards[indexPath.row].height;
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
    
    [YYRoute pushToController:@"PlanFormInputController" data:@{@"model":self.model.standards[indexPath.row],@"checkId":@(self.model.checkId)}];
}

//获取当前设备点检计划
- (void)getPlan {
    NSLog(@"%@",self.baseData);
    //
    NSString *urlString = [NSString stringWithFormat:@"http://106.12.101.46:9094/facility/%@/plan/check",self.baseData[@"facilityId"]];
    [YYNSessionManager.defaultSessionManager method:@"get" URLString:urlString andParams:nil andHttpHeaders:nil success:^(id ret) {
        NSLog(@"%@",ret);
        self.model = [JsonStringTransfer dictionary:ret ToModel:@"CheckUPModel"];
        [self.tableView reloadData];
    } failure:^(id error) {
        NSLog(@"");
    }];
}

- (void)setupTableView {
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, MAIN_SCREEN_WIDTH, MAIN_SCREEN_HEIGHT) style:UITableViewStyleGrouped];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.tableView registerNib:[UINib nibWithNibName:@"CheckUPDeviceInfoCell" bundle:nil] forCellReuseIdentifier:@"cell1"];
    [self.tableView registerNib:[UINib nibWithNibName:@"CheckUPStandardsCell" bundle:nil] forCellReuseIdentifier:@"cell2"];
    self.tableView.separatorStyle = UITableViewCellSelectionStyleNone;
    self.tableView.backgroundColor = kUIColorFromRGB(0xf5f5f5);
    [self.view addSubview:self.tableView];
}

@end
