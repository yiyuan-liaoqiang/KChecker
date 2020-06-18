//
//  DaylyRecordViewController.swift
//  KChecker
//
//  Created by LiaoQiang on 2019/4/14.
//

import UIKit
import SwiftyJSON

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
        var param = CommonCellUtil.paramWithArray(models: self.dataArray as! [CommonCellDataModel])
        guard param != nil else {
            return
        }
        let session = YYNSessionManager.default()
        session?.requestSerializer = AFJSONRequestSerializer()
        ActivityIndicatorManager.showActivityIndicator(in: self.view)
        session?.method("post", urlString: "http://111.229.39.85:9094/day/report", andParams: param, andHttpHeaders: [:], success: { (ret) in
            ActivityIndicatorManager.hideActivityIndicator(in: self.view)
            if let ret = ret as? [String:Any] {
                ProgressHUD.showMessage(ret["msg"] as? String)
                if let code = ret["code"] as? Int,code == 200 {
                    YYRoute.pop()
                }
            }
        }, failure: { (err) in
            if let error = err as? NSError {
                if error.code == -1009 || error.code == -1004 {
                    //The Internet connection appears to be offline.
                    ProgressHUD.showMessage("网络连接中断，已将请求缓存在本地，待有网络再次提交")
                    var localRequest:[String:JSON]?
                    do {
                        localRequest = try YYNCache.requestStorage?.object(forKey: "request").dictionaryValue
                    }
                    catch {
                        localRequest = [String:JSON]()
                    }
                    param!["localTitle"] = "日报填写"
                    param!["style"] = "AFJSONRequestSerializer"
                    localRequest?["http://111.229.39.85:9094/day/report"] = JSON(param ?? [:])
                    try? YYNCache.requestStorage?.setObject(JSON(localRequest!), forKey: "request")
                }
                else {
                    ProgressHUD.showMessage(error.localizedDescription)
                }
            }
            else {
                ProgressHUD.showMessage(err as? String)
            }
            ActivityIndicatorManager.hideActivityIndicator(in: self.view)
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
