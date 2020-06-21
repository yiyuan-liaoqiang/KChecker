//
//  TaskDetailViewController.m
//  KChecker
//
//  Created by LiaoQiang on 2019/4/19.
//

#import "TaskDetailViewController.h"
#import "CheckUPViewController.h"
#import "DMLazyScrollView.h"
#import "OilingPlanViewController.h"
#import "FaultViewController.h"
#import "FacilityInforController.h"

@interface TaskDetailViewController ()<DMLazyScrollViewDelegate>
{
    DMLazyScrollView *_lazyScrollView;
    NSMutableArray *_viewControllerArray;
    NSArray *categorys;
}
@property (nonatomic, strong)TitleIndexView *titleView;

@end

@implementation TaskDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = @"故障历史";
    
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithTitle:@"故障历史" style:UIBarButtonItemStylePlain target:self action:@selector(itemClick)];
    self.navigationItem.rightBarButtonItem = item;
    
    // Do any additional setup after loading the view.
    self.title = self.baseData[@"facilityName"];
    [self.view addSubview:self.titleView];
    categorys = @[@"check",@"lubrication",@"fasten",@"adjust",@"replace"];
    [self lazyViewInital];
}

- (void)itemClick
{
//    FaultViewController *view = [[FaultViewController alloc] init];
//    [self.navigationController pushViewController:view animated:YES];
    
    FacilityInforController *viewController = [[FacilityInforController alloc] init];
    [self.navigationController pushViewController:viewController animated:YES];
}

- (void)lazyViewInital
{
    NSUInteger numberOfPages = 5;
    _viewControllerArray = [[NSMutableArray alloc] initWithCapacity:numberOfPages];
    for (NSUInteger k = 0; k < numberOfPages; ++k) {
        [_viewControllerArray addObject:[NSNull null]];
    }
    _lazyScrollView = [[DMLazyScrollView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(self.titleView.frame), MAIN_SCREEN_WIDTH, MAIN_SCREEN_HEIGHT-CGRectGetMaxY(self.titleView.frame))];
    _lazyScrollView.scrollEnabled = YES;
    [_lazyScrollView setEnableCircularScroll:NO];
    [_lazyScrollView setAutoPlay:NO];
    __weak __typeof(&*self)weakSelf = self;
    _lazyScrollView.dataSource = ^(NSUInteger index) {
        return [weakSelf controllerAtIndex:index];
    };
    _lazyScrollView.numberOfPages = numberOfPages;
    _lazyScrollView.controlDelegate = self;
    [self.view addSubview:_lazyScrollView];
}

- (void)lazyScrollViewDidEndDecelerating:(DMLazyScrollView *)pagingView atPageIndex:(NSInteger)pageIndex
{
    [self.titleView setCurrentIndex:pageIndex+10];
}

- (UIViewController *) controllerAtIndex:(NSInteger) index {
    if (index > _viewControllerArray.count || index < 0) return nil;
    id res = [_viewControllerArray objectAtIndex:index];
    if (res == [NSNull null])
    {
        BaseOCViewController *vc;
//        if (index == 0) {
            vc = [[CheckUPViewController alloc] init];
        ((CheckUPViewController *)vc).category = categorys[index];
//        }
//        else {
//            vc = [[OilingPlanViewController alloc] init];
//        }
        [vc setValue:self.baseData forKey:@"baseData"];
        [_viewControllerArray replaceObjectAtIndex:index withObject:vc];
        return vc;
    }
    return res;
}

- (TitleIndexView *)titleView {
    if (_titleView == nil) {
        _titleView = [[TitleIndexView alloc] initWithFrame:CGRectMake(0, NAV_BAR_HEIGHT, MAIN_SCREEN_WIDTH, 46) andTitleArray:@[@"点检计划",@"润滑计划",@"紧固计划",@"调整计划",@"更换计划"]andNormalAttri:@{@"color":kUIColorFromRGB(0x808080),@"font":[UIFont systemFontOfSize:15]} andHighlightAttri:@{@"color":MAIN_THEME_COLOR,@"font":[UIFont systemFontOfSize:15]} andIsAverageDivision:false];
        [_titleView.sepLine removeFromSuperview];
        
        __weak typeof(self) weakSelf = self;
        _titleView.callback = ^(NSInteger tag) {
            [weakSelf handleIndexViewCallback:tag];
        };
    }
    return _titleView;
}

- (void)handleIndexViewCallback:(NSInteger)index
{
    NSInteger currentIndex = [_lazyScrollView currentPage];
    [_lazyScrollView moveByPages:index-currentIndex animated:YES];
}

/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

@end
