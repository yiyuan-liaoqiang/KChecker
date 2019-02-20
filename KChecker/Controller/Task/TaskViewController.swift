//
//  TaskViewController.swift
//  KChecker
//
//  Created by LiaoQiang on 2019/2/20.
//

import UIKit

class TaskViewController: BaseWebViewController {

//    var tableView:UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        self.title = "重庆市中久机电设备有限公司"
        let filePath = Bundle.main.path(forResource: "TaskList.html", ofType: nil)
        self.webView.load(URLRequest(url: URL(fileURLWithPath: filePath!)))
        
    }
    
    
    
//    func setupTableView() {
//        tableView = UITableView(frame: CGRect(x: 0, y: MyConst.NAV_BAR_HEIGHT(), width: MyConst.MAIN_SCREEN_WIDTH, height: MyConst.MAIN_SCREEN_HEIGHT-MyConst.TAB_BAR_HEIGHT()))
//        tableView.delegate = self
//        tableView.dataSource = self
//        self.view.addSubview(tableView)
//    }

}
