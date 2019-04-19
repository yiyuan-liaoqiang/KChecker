//
//  SettingTableViewController.m
//  KChecker
//
//  Created by YanTing Zhang on 2019/4/19.
//

#import "SettingTableViewController.h"
#import "SettingTableViewCell.h"
#import "SettingModel.h"

@interface SettingTableViewController ()<UITableViewDelegate , UITableViewDataSource>
@property (nonatomic ,strong) NSArray *dataArray;
@property (nonatomic ,strong) UITableView *tableView;

@end

@implementation SettingTableViewController

//- (void)viewWillAppear:(BOOL)animated
//{
//    [super viewWillAppear:animated];
//    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
////    [appDelegate yourParam];
//    appDelegate.window.backgroundColor = [UIColor whiteColor];
//}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, NAV_BAR_HEIGHT, MAIN_SCREEN_WIDTH, 44 * self.dataArray.count) style:UITableViewStylePlain];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.rowHeight = 44;
    self.view.backgroundColor = [UIColor whiteColor];
    self.tableView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.tableView];
    NSLog(@"%@",self.dataArray);
    
}


- (NSArray *)dataArray
{
    if(_dataArray == nil)
    {
        _dataArray = [SettingModel loadDataArray];
    }
    return _dataArray;
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return self.dataArray.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {    
    static NSString *strID = @"cell";
    
    SettingTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:strID];
    if(cell == nil)
    {
        cell = [[SettingTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:strID];
    }
    

    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    SettingModel *model = self.dataArray[indexPath.row];
    cell.textLabel.text = model.title;
    return cell;
}

@end
