//
//  DaylyRecordViewController.swift
//  KChecker
//
//  Created by LiaoQiang on 2019/4/14.
//

import UIKit

class DaylyRecordViewController: BaseFormViewController {

    override func viewDidLoad() {
        
        let filePath = CommonUtils.bundlePathWithFileName(fileName: "DaylyRecord.plist")
        self.dataArray = [CommonCellDataModel].deserialize(from: NSArray(contentsOfFile: filePath)) as Array<AnyObject>?
        super.viewDidLoad()
        self.title = "日报填写"
        self.tableView.separatorStyle = .singleLine
        
        let item = UIBarButtonItem(title: "提交", style: UIBarButtonItem.Style.plain, target: self, action: #selector(publish))
        self.navigationItem.rightBarButtonItem = item
    }
    
    @objc func publish(){
        let param = CommonCellUtil.paramWithArray(models: self.dataArray as! [CommonCellDataModel])
        let session = YYNSessionManager.default()
        session?.requestSerializer = AFJSONRequestSerializer()
        ActivityIndicatorManager.showActivityIndicator(in: self.view)
        session?.method("post", urlString: "http://106.12.101.46:9094/day/report", andParams: param, andHttpHeaders: [:], success: { (ret) in
            ActivityIndicatorManager.hideActivityIndicator(in: self.view)
            if let ret = ret as? [String:Any] {
                ProgressHUD.showMessage(ret["msg"] as? String)
                if let code = ret["code"] as? Int,code == 200 {
                    YYRoute.pop()
                }
            }
        }, failure: { (err) in
            ActivityIndicatorManager.hideActivityIndicator(in: self.view)
            ProgressHUD.showMessage(err as? String)
        })
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
