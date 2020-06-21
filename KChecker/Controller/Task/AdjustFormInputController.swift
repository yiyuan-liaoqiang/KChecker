//
//  PlanFormInputController.swift
//  KChecker
//
//  Created by LiaoQiang on 2019/4/21.
//

import UIKit
import SwiftyJSON

class AdjustFormInputController: BaseFormViewController {
    override func viewDidLoad() {
        
        let filePath = CommonUtils.bundlePathWithFileName(fileName: "adjustFormInput.plist")
        self.dataArray = [CommonCellDataModel].deserialize(from: NSArray(contentsOfFile: filePath)) as Array<AnyObject>?
        self.dataModel = self.baseData?["model"] as AnyObject?
        super.viewDidLoad()
        self.title = "设备数据填报"
        self.tableView.separatorStyle = .singleLine
        
        let item = UIBarButtonItem(title: "提交", style: UIBarButtonItem.Style.plain, target: self, action: #selector(publish))
        self.navigationItem.rightBarButtonItem = item
        
        getData()
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if let cellName = self.modelForIndexPath(indexPath).cellName,cellName == "MultipleInputCell" {
            if let value = (self.modelForIndexPath(indexPath).localValue as NSString?) {
                return value.size(with: UIFont.systemFont(ofSize: 15), constrainedTo: CGSize(width: .MAIN_SCREEN_WIDTH-30, height: 10000)).height + 42
            }
            return 50;
        }
        else {
            return super.tableView(tableView, heightForRowAt: indexPath)
        }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = super.tableView(tableView, cellForRowAt: indexPath)
        if let c = cell as? PlanInputHeaderCell {
            if let contentId = self.dataModel?.value(forKey: "contentId") as? String {
                let key = "planFormInput" + contentId
                if let value = try? YYNCache.userRelatedStorage?.object(forKey: key) {
                    c.timeLabel.text = "上一次填报时间：" + (value?.stringValue ?? "")
                }
                else {
                    c.timeLabel.text = "上一次填报时间："
                }
            }
        }
        return cell
    }
    
    func getData() {
        if let contentId = self.dataModel?.value(forKey: "contentId") as? String {
            let url = "http://111.229.39.85:9094/adjust/" + contentId
                ActivityIndicatorManager.showActivityIndicator(in: self.view)
                YYNSessionManager.default().method("get", urlString: url, andParams: [:], andHttpHeaders: [:], success: { (ret) in
                    if let ret = ret as? [String:Any] {
                        var r = ret["standard"] as? [String:Any]
                        if let result = ret["result"] {
                            r?["result"] = result
                        }
                        CommonCellUtil.setValue(r, self.dataArray)
                        self.tableView.reloadData()
                    }
                    ActivityIndicatorManager.hideActivityIndicator(in: self.view)
                }, failure: { (err) in
                    ActivityIndicatorManager.hideActivityIndicator(in: self.view)
            })
        }
    }
        
    @objc func publish(){
        self.view.endEditing(true)
        var param = CommonCellUtil.paramWithArray(models: self.dataArray as! [CommonCellDataModel])
        if param == nil {
            return
        }
        if let contentId = self.dataModel?.value(forKey: "contentId") as? String {
            param!["contentId"] = contentId
        }
        else {
            return
        }
        param?.removeValue(forKey: "style")
        param?.removeValue(forKey: "standard")
        param?.removeValue(forKey: "partName")
        param?.removeValue(forKey: "componentName")
        
        let session = YYNSessionManager.default()
        session?.requestSerializer = AFJSONRequestSerializer()
        ActivityIndicatorManager.showActivityIndicator(in: self.view)
        session?.method("post", urlString: "http://111.229.39.85:9094/facility/adjust", andParams: param, andHttpHeaders: [:], success: { (ret) in
            ActivityIndicatorManager.hideActivityIndicator(in: self.view)
            if let ret = ret as? [String:Any] {
                ProgressHUD.showMessage(ret["msg"] as? String)
                if let code = ret["code"] as? Int,code == 200 {
                    YYRoute.pop()
                }
            }
        }, failure: { (err) in
            ActivityIndicatorManager.hideActivityIndicator(in: self.view)
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
                    param!["localTitle"] = "点检填报"
                    param!["style"] = "AFJSONRequestSerializer"
                    localRequest?["http://111.229.39.85:9094/facility/adjust"] = JSON(param ?? [:])
                    try? YYNCache.requestStorage?.setObject(JSON(localRequest!), forKey: "request")
                }
                else {
                    ProgressHUD.showMessage(error.localizedDescription)
                }
            }
            else {
                ProgressHUD.showMessage(err as? String)
            }
        })
    }
    
    deinit {
        if let contentId = self.dataModel?.value(forKey: "contentId") as? String {
            let key = "planFormInput" + contentId
            let value = Date().timeStrWithFormat(format: "yyyy-MM-dd HH:mm:ss")
            try? YYNCache.userRelatedStorage?.setObject(JSON(value), forKey: key)
        }
    }
}
