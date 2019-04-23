//
//  FacilityInforController.m
//  KChecker
//
//  Created by YanTing Zhang on 2019/4/22.
//

#import "FacilityInforController.h"
#import "FaultModel.h"


@interface FacilityInforController ()<UITableViewDelegate , UITableViewDataSource>

@property (nonatomic ,strong) FaultModel *model;
@property (nonatomic ,strong) UITableView *tableView;


@property (nonatomic, strong)NSMutableArray *dataArray;
@property (nonatomic ,strong) NSMutableArray *mArray;

@end

@implementation FacilityInforController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    [self initUI];
    self.view.backgroundColor = [UIColor whiteColor];

    self.navigationItem.title = @"设备信息";
    
    NSString *path = [[NSBundle mainBundle] pathForResource:@"FacilityInfo.plist" ofType:nil];
    self.dataArray = [JsonStringTransfer dictionaryArray:[NSArray arrayWithContentsOfFile:path] ToModelArrayWithClass:TmpModel.class].mutableCopy;
    NSLog(@"%@",self.dataArray);
    
    
    [[YYNSessionManager defaultSessionManager] method:@"get" URLString:@"facility/999988/info" andParams:@{@"facilityId":@(999988) , @"page":@"1" , @"size": @"15"} andHttpHeaders:nil success:^(NSDictionary *ret) {
        NSMutableArray *array = [NSMutableArray arrayWithCapacity:10];
        for (TmpModel *model in self.dataArray) {
            model.serverValue = ret[model.serverKey];
            if(model.serverValue)
            {
                [array addObject:model.serverValue];
            }
            else
            {
                [array addObject:@""];
            }
            
        }
        [self.tableView reloadData];
        self.mArray = array;

    } failure:^(id error) {
        
    }];
}

- (void)setMArray:(NSMutableArray *)mArray
{
    _mArray = mArray;
    [self.tableView reloadData];
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.mArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *strId = @"fjd";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:strId];
    if(cell == nil)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:strId];
    }
    
    
    TmpModel *model = self.dataArray[indexPath.row];
    NSString *stri = self.mArray[indexPath.row];

    cell.textLabel.text = model.title;
    cell.detailTextLabel.text = model.serverValue;
    cell.detailTextLabel.textColor = [UIColor blackColor];
    return cell;
}

- (void)initUI
{
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, NAV_BAR_HEIGHT, MAIN_SCREEN_WIDTH, MAIN_SCREEN_HEIGHT - NAV_BAR_HEIGHT) style:UITableViewStylePlain];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
//    self.tableView.backgroundColor = [UIColor redColor];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:self.tableView];
}
@end


@implementation TmpModel

- (id)serverValue
{
    if([_serverValue isKindOfClass:[NSNumber class]])
    {
        return [NSString stringWithFormat:@"%@",[_serverValue stringValue]];
    }
    return _serverValue;
}

@end
