//
//  PlanFormInputController.swift
//  KChecker
//
//  Created by LiaoQiang on 2019/4/21.
//

import UIKit
import SwiftyJSON

class PlanFormInputController: BaseFormViewController {
    var checkId:AnyObject!
    override func viewDidLoad() {
        
        let filePath = CommonUtils.bundlePathWithFileName(fileName: "PlanFormInput.plist")
        self.dataArray = [CommonCellDataModel].deserialize(from: NSArray(contentsOfFile: filePath)) as Array<AnyObject>?
        self.dataModel = self.baseData?["model"] as AnyObject?
        self.checkId = self.baseData?["checkId"] as AnyObject?
        super.viewDidLoad()
        self.title = "点检填报"
        self.tableView.separatorStyle = .singleLine
        
        let item = UIBarButtonItem(title: "提交", style: UIBarButtonItem.Style.plain, target: self, action: #selector(publish))
        self.navigationItem.rightBarButtonItem = item
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
        
    @objc func publish(){
        self.view.endEditing(true)
        var param = CommonCellUtil.paramWithArray(models: self.dataArray as! [CommonCellDataModel])
        if param == nil {
            return
        }
        param!["checkId"] = self.checkId
        let session = YYNSessionManager.default()
        session?.requestSerializer = AFJSONRequestSerializer()
        ActivityIndicatorManager.showActivityIndicator(in: self.view)
        session?.method("post", urlString: "http://106.12.101.46:9094/facility/check", andParams: param, andHttpHeaders: [:], success: { (ret) in
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
                    localRequest?["http://106.12.101.46:9094/facility/check"] = JSON(param ?? [:])
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
}
