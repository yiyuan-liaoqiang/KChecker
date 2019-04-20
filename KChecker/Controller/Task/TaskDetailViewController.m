//
//  TaskDetailViewController.m
//  KChecker
//
//  Created by LiaoQiang on 2019/4/19.
//

#import "TaskDetailViewController.h"
#import "TaskCheckViewController.h"
#import "TaskOilingViewController.h"
#import "TaskMaintainViewController.h"
#import "TaskJinguViewController.h"
#import "TaskAdjustViewController.h"
#import "TaskChangeViewController.h"
#import "DMLazyScrollView.h"
#import "TitleIndexView.h"
#import "viewController.h"
@interface TaskDetailViewController ()<DMLazyScrollViewDelegate>
{
    DMLazyScrollView *_lazyScrollView;
    NSMutableArray *_viewControllerArray;
}

@property (nonatomic, strong)TitleIndexView *titleView;
//记录当前label的索引
@property (nonatomic, assign) int currentIndex;
@end

@implementation TaskDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    [self setupTitleView];
    [self lazyViewInital];
}

////DMLazyScrollViewDelegate
//- (void)lazyScrollViewDidEndDecelerating:(DMLazyScrollView *)pagingView atPageIndex:(NSInteger)pageIndex
//{
//
//}

//callback
- (void)handleIndexViewCallback:(NSInteger)index
{
    NSInteger currentIndex = [_lazyScrollView currentPage];
    [_lazyScrollView moveByPages:index-currentIndex animated:YES];
}

- (void)setupTitleView
{
    NSArray *titleArray = @[@"点检计划",@"润滑计划",@"维修计划",@"紧固计划",@"调整计划",@"更换计划"];
    self.titleView = [[TitleIndexView alloc] initWithFrame:CGRectMake(0, NAV_BAR_HEIGHT, MAIN_SCREEN_WIDTH, 40) andTitleArray:titleArray andNormalAttri:nil andHighlightAttri:nil andIsAverageDivision:false];
    
    __weak typeof(self) weakself = self;
    self.titleView.callback = ^(NSInteger tag) {
        [weakself handleIndexViewCallback:tag];
    };
    [self.view addSubview:self.titleView];
}

- (void)lazyViewInital
{
    NSUInteger numberOfPages = 6;
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

- (UIViewController *) controllerAtIndex:(NSInteger) index {
    if (index > _viewControllerArray.count || index < 0) return nil;
    id res = [_viewControllerArray objectAtIndex:index];
    if (res == [NSNull null])
    {
        UIViewController *vc;
        if (index == 0)
        {
            vc = [[TaskCheckViewController alloc] init];
//            vc.view.backgroundColor = [UIColor redColor];
        }
        else if(index == 1)
        {
            vc = [[TaskOilingViewController alloc] init];
            vc.view.backgroundColor = [UIColor yellowColor];

        }
        else if(index == 2)
        {
            vc = [[TaskMaintainViewController alloc] init];
            vc.view.backgroundColor = [UIColor blueColor];

        }
        else if (index == 3)
        {
            vc = [[TaskJinguViewController alloc] init];
            vc.view.backgroundColor = [UIColor cyanColor];
        }
        else if (index == 4)
        {
            vc = [[TaskAdjustViewController alloc] init];
            vc.view.backgroundColor = [UIColor yellowColor];
        }
        else
        {
            vc = [[TaskChangeViewController alloc] init];
            vc.view.backgroundColor = [UIColor greenColor];
        }
        vc.view.frame = CGRectMake(0, 0, MAIN_SCREEN_WIDTH, _lazyScrollView.bounds.size.height);
        [_viewControllerArray replaceObjectAtIndex:index withObject:vc];
        return vc;
    }
    return res;
}


- (void)lazyScrollViewDidEndDecelerating:(DMLazyScrollView *)pagingView atPageIndex:(NSInteger)pageIndex
{
    [self.titleView setCurrentIndex:pageIndex+10];
    
    NSInteger currentIndex = [_lazyScrollView currentPage];
    
//    self.currentIndex = pagingView.contentOffset.x / pagingView.bounds.size.width;
    NSLog(@"%f",pagingView.contentOffset.x);
    NSLog(@"%d",self.currentIndex);
    //    //居中显示当前显示的标签
    //    HMChannelLabel *label = self.scrollView.subviews[self.currentIndex];
    UILabel *label = self.titleView.lblArray[currentIndex];
    CGFloat offset = label.center.x - self.titleView.scroll.bounds.size.width * 0.5;
    NSLog(@"%f",offset);
    CGFloat maxOffset = self.titleView.scroll.contentSize.width - label.bounds.size.width - self.titleView.scroll.bounds.size.width;
    NSLog(@"%f",maxOffset);
    if (offset < 0) {
        offset = 0;
    } else if (offset > maxOffset) {
        offset = maxOffset + label.bounds.size.width;
    }
    
    [self.titleView.scroll setContentOffset:CGPointMake(offset, 0) animated:YES];
}

//滚动结束之后，计算currentIndex
//- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
//    self.currentIndex = scrollView.contentOffset.x / scrollView.bounds.size.width;
//
////    //居中显示当前显示的标签
////    HMChannelLabel *label = self.scrollView.subviews[self.currentIndex];
//    UILabel *label = self.titleView.lblArray[self.currentIndex];
//    CGFloat offset = label.center.x - self.titleView.scroll.bounds.size.width * 0.5;
//    CGFloat maxOffset = self.titleView.scroll.contentSize.width - label.bounds.size.width - self.titleView.scroll.bounds.size.width;
//
//    if (offset < 0) {
//        offset = 0;
//    } else if (offset > maxOffset) {
//        offset = maxOffset + label.bounds.size.width;
//    }
//
//    [self.titleView.scroll setContentOffset:CGPointMake(offset, 0) animated:YES];
//
//
//}

@end
