//
//  TaskCheckViewController.m
//  KChecker
//
//  Created by YanTing Zhang on 2019/4/19.
//

#import "TaskCheckViewController.h"
#import "KChecker-Swift.h"
@interface TaskCheckViewController ()

@end

@implementation TaskCheckViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
//    AccountHelper.checkProject(["facilityId":String(page) as AnyObject,"size":"15" as AnyObject]) { (err, obj) in
//        ActivityIndicatorManager.hideActivityIndicator(in: self.dataArray.count > 0 ? nil:self.view)
//        
//        if let arr = obj as? [[String:AnyObject]], err == nil {
//            if page == 1 {
//                self.dataArray.removeAll()
//            }
//            self.dataArray.addObjectFromArray(arr)
//            self.reloadData()
//            
//            self.webView.scrollView.header?.endRefreshing()
//            arr.count == 15 ? self.webView.scrollView.footer?.endRefreshing() : self.webView.scrollView.footer?.endRefreshingWithNoMoreData()
//        }
//        else {
//            ProgressHUD.showMessage(err)
//        }
//    }
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
