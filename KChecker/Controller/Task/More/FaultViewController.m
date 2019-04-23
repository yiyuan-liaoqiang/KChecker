//
//  FaultViewController.m
//  KChecker
//
//  Created by YanTing Zhang on 2019/4/22.
//

#import "FaultViewController.h"
#import "YYNSessionManager.h"
#import "FacilityModel.h"
@interface FaultViewController ()<UITableViewDelegate , UITableViewDataSource>

@property (nonatomic ,strong) FacilityModel *model;
@property (nonatomic ,strong) NSMutableArray *dataArray;
@property (nonatomic ,strong) UITableView *tableView;



@end

@implementation FaultViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = @"故障历史";
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.dataArray = [NSMutableArray arrayWithCapacity:15];
    [self getRequest];
    [self initUI];
    
   
    
    
}

#pragma UITableViewDelegat---

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *strID = @"cellID";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:strID];
    if(cell == nil)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:strID];
    }
    FacilityModel *model = self.dataArray[indexPath.row];
    
//    cell.textLabel.textColor = [UIColor b];
    cell.textLabel.text = model.questionType;
    cell.textLabel.font = [UIFont systemFontOfSize:20];
    cell.detailTextLabel.font = [UIFont systemFontOfSize:18];
    cell.detailTextLabel.textColor = [UIColor lightGrayColor];
    cell.detailTextLabel.text = [NSString stringWithFormat:@"%@ %@ 到 %@",model.faultDate,model.startTime ,model.endTime];
//    cell.spre
    return cell;
}

- (void)getRequest
{
    [[YYNSessionManager defaultSessionManager] method:@"get" URLString:@"facility/999988/faults" andParams:@{@"page":@"1" , @"size": @"15"} andHttpHeaders:nil success:^(NSArray *ret) {
        
        [ret enumerateObjectsUsingBlock:^(NSDictionary *obj, NSUInteger idx, BOOL * _Nonnull stop) {
            FacilityModel *model = [FacilityModel loadFacility:obj];
            [self.dataArray addObject:model];
        }];
        [self.tableView reloadData];
//        NSArray *array = [JsonStringTransfer dictionaryArray:ret ToModelArray:@"FaultModel"];
//        [self.dataArray addObjectsFromArray:array];
//        [self.tableView reloadData];
//        NSLog(@"%@",array);
        
    } failure:^(id error) {
        
    }];
}

- (void)initUI
{
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, NAV_BAR_HEIGHT, MAIN_SCREEN_WIDTH, MAIN_SCREEN_HEIGHT - NAV_BAR_HEIGHT) style:UITableViewStylePlain];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:self.tableView];
}
@end
