//
//  TaskViewController.swift
//  KChecker
//
//  Created by LiaoQiang on 2019/2/20.
//

import UIKit
import WebKit

class TaskViewController: BaseWebViewController {

//    var tableView:UITableView!
    var dataArray = [[String:Any]]()
    var lock:NSLock = NSLock()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        self.title = "重庆市中久机电设备有限公司"
        let filePath = Bundle.main.path(forResource: "TaskList.html", ofType: nil)
        self.webView.frame = CGRect(x: .zero, y: .NAV_BAR_HEIGHT, width: .MAIN_SCREEN_WIDTH, height: .MAIN_SCREEN_HEIGHT - .NAV_BAR_HEIGHT - .TAB_BAR_HEIGHT)
        self.webView.load(URLRequest(url: URL(fileURLWithPath: filePath!)))
        self.addActionsNames(actions: ["didSelect"])
        
        weak var weakSelf = self
        self.webView.scrollView.footer = MJRefreshBackNormalFooter(refreshingBlock: {
            let page = (weakSelf?.dataArray.count)!/15 + 1
            weakSelf?.taskList(page)
        })
        
        self.taskList(1)
    }
    
    func taskList(_ page:Int) {
        ActivityIndicatorManager.showActivityIndicator(in: self.dataArray.count > 0 ? nil:self.view)
        AccountHelper.taskList(["page":String(page) as AnyObject,"size":"15" as AnyObject]) { (err, obj) in
//
            ActivityIndicatorManager.hideActivityIndicator(in: self.dataArray.count > 0 ? nil:self.view)
            
            if let arr = obj as? [[String:AnyObject]], err == nil {
                if page == 1 {
                    self.dataArray.removeAll()
                }
                
                self.dataArray.addObjectFromArray(arr)
                print(self.dataArray)
                self.reloadData()
                
                self.webView.scrollView.header?.endRefreshing()
                arr.count == 15 ? self.webView.scrollView.footer?.endRefreshing() : self.webView.scrollView.footer?.endRefreshingWithNoMoreData()
            }
            else {
                ProgressHUD.showMessage(err)
            }
        }
    }
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        self.reloadData()
    }
    
    override func userContentController(_ userContentController: WKUserContentController, didReceive message: WKScriptMessage) {
        YYRoute.pushToController("TaskDetailViewController", data: message.body as AnyObject)
    }
    
    func reloadData() {
        //刷新webView数据
        self.lock.lock()
        if self.webView.isLoading == false && self.dataArray.count > 0 {
            for dic in self.dataArray {
                let data : NSData! = try? JSONSerialization.data(withJSONObject: dic, options: []) as NSData
                let JSONString = NSString(data:data as Data,encoding: String.Encoding.utf8.rawValue)! as String
                self.webView.evaluateJavaScript("insertCell(\(String(describing: JSONString)))", completionHandler: { (ret, err) in
                    
                })
            }
        }
        self.lock.unlock()
    }

}
