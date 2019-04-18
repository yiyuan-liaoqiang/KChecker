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
    
    //点检记录
    @objc func dianjian() {
        YYRoute.pushToController(aaaaaaaaa(), data: nil)
    }
}
