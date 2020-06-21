//
//  OilingViewController.swift
//  KChecker
//
//  Created by YanTing Zhang on 2019/4/19.
//

import UIKit
import WebKit

class AdjustViewController: BaseWebViewController {

    var dataArray = [[String:Any]]()
    var lock:NSLock = NSLock()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        
        self.title = "调整记录"
        let filePath = Bundle.main.path(forResource: "TaskList.html", ofType: nil)
        self.webView.frame = CGRect(x: .zero, y: .NAV_BAR_HEIGHT, width: .MAIN_SCREEN_WIDTH, height: .MAIN_SCREEN_HEIGHT - .NAV_BAR_HEIGHT)
        self.webView.load(URLRequest(url: URL(fileURLWithPath: filePath!)))
        
        weak var weakSelf = self
        self.webView.scrollView.footer = MJRefreshBackNormalFooter(refreshingBlock: {
            let page = (weakSelf?.dataArray.count)!/15 + 1
            weakSelf?.checkList(page)
        })
        
        self.checkList(1)
    }
    
    func checkList(_ page:Int) {
        ActivityIndicatorManager.showActivityIndicator(in: self.dataArray.count > 0 ? nil:self.view)
        AccountHelper.adjustList(["page":String(page) as AnyObject,"size":"15" as AnyObject]) { (err, obj) in
            ActivityIndicatorManager.hideActivityIndicator(in: self.dataArray.count > 0 ? nil:self.view)
            
            if let arr = obj as? [[String:AnyObject]], err == nil {
                if page == 1 {
                    self.dataArray.removeAll()
                }
                self.dataArray.addObjectFromArray(arr)
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
    
    //    func setupTableView() {
    //        tableView = UITableView(frame: CGRect(x: 0, y: MyConst.NAV_BAR_HEIGHT(), width: MyConst.MAIN_SCREEN_WIDTH, height: MyConst.MAIN_SCREEN_HEIGHT-MyConst.TAB_BAR_HEIGHT()))
    //        tableView.delegate = self
    //        tableView.dataSource = self
    //        self.view.addSubview(tableView)
    //    }

}
