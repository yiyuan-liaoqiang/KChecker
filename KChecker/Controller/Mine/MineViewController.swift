//
//  MineViewController.swift
//  KChecker
//
//  Created by LiaoQiang on 2019/2/20.
//

import UIKit

class MineViewController: BaseFormViewController {
    
    override func viewDidLoad() {
        let filePath = CommonUtils.bundlePathWithFileName(fileName: "Mine.plist")
        let dicArray = NSArray(contentsOfFile: filePath) as? Array<[String : AnyObject]>
        self.dataArray = [CommonCellDataModel].deserialize(from: dicArray) as Array<AnyObject>?
        
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    //点检记录selectWeekday:maintain
    @objc func dianjian() {
        YYRoute.pushToController("CheckViewController", data: nil)
    }
    @objc func oiling() {
        YYRoute.pushToController("OilingViewController", data: nil)
    }
    @objc func maintain(){
        YYRoute.pushToController("MaintainViewController", data: nil)
    }
    @objc func log(){
        YYRoute.pushToController("LogViewController", data: nil)
    }
    @objc func setting(){
        YYRoute.pushToController(SettingTableViewController(), data: nil)
    }
}
