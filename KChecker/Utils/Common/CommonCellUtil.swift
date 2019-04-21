//
//  CommonCellUtil.swift
//  KChecker
//
//  Created by LiaoQiang on 2019/1/24.
//  Copyright © 2019年 Liao Qiang. All rights reserved.
//

import UIKit
import HandyJSON

class CommonCellUtil: NSObject {    
    //type 和 CellName一一对应起来
    class var configInfo:[String:String] {
        return ["title_value":"TitleValueTableViewCell","blank_space":"CommonBaseCell","title_switch":"TitleSwitchTableViewCell","title_textView":"TitleTextViewTableViewCell","title_timeRange":"TitleTimeRangeTableViewCell","icon_title":"IconTitleCell","title_value_v":"TitleValueVTableViewCell"]
    }
    
    //根据model给dataArray赋值 使用泛型，兼容handyjson和dic
    static func setValue<T>(_ dataModel:T,_ array:[AnyObject]) {
        if array is [CommonCellDataModel] {
            for model in (array as! [CommonCellDataModel]) {
                //handyjson对象做为数据
                if let dataModel = dataModel as? HandyJSON {
                    if let localKey = model.localKey,localKey.contains("<??>") ,let key1 = localKey.components(separatedBy: "<??>").first,let key2 = localKey.components(separatedBy: "<??>").last {
                        //localKey里面包含<??>的
                        let value1 = dataModel.value(forKey: String(key1)) as? String ?? ""
                        let value2 = dataModel.value(forKey: String(key2)) as? String ?? ""
                        model.localValue = value1 + "<??>" + value2
                    }
                    else if let serverKey = model.serverKey,serverKey.contains("<??>") ,let key1 = serverKey.components(separatedBy: "<??>").first,let key2 = serverKey.components(separatedBy: "<??>").last {
                        //serverKey里面包含<??>的
                        let value1 = dataModel.value(forKey: String(key1)) as? String ?? ""
                        let value2 = dataModel.value(forKey: String(key2)) as? String ?? ""
                        model.serverValue = value1 + "<??>" + value2
                    }
                    else {
                        if let localKey = model.localKey ,let localValue = dataModel.value(forKey: localKey) {
                            model.localValue = localValue as? String
                        }
                        if let serverKey = model.serverKey,let serverValue = dataModel.value(forKey: serverKey) {
                            if let serverInt = serverValue as? Int {
                                model.serverValue = String(serverInt)
                            }
                            else {
                                model.serverValue = serverValue as? String
                            }
                        }
                    }
                }
                    //[String:Any]做为数据
                else if let dataModel = dataModel as? [String:Any] {
                    if let localKey = model.localKey,localKey.contains("<??>") == true,let key1 = localKey.components(separatedBy: "<??>").first,let key2 = localKey.components(separatedBy: "<??>").last {
                        //localKey里面包含<??>的
                        let value1 = dataModel[String(key1)] as? String ?? ""
                        let value2 = dataModel[String(key2)] as? String ?? ""
                        model.localValue = value1 + "<??>" + value2
                    }
                    else if let serverKey = model.serverKey,serverKey.contains("<??>") ,let key1 = serverKey.components(separatedBy: "<??>").first,let key2 = serverKey.components(separatedBy: "<??>").last {
                        //serverKey里面包含<??>的
                        let value1 = dataModel[String(key1)] as? String ?? ""
                        let value2 = dataModel[String(key2)] as? String ?? ""
                        model.serverValue = value1 + "<??>" + value2
                    }
                    else {
                        if let localKey = model.localKey ,let localValue = dataModel[localKey] {
                            model.localValue = localValue as? String
                        }
                        if let serverKey = model.serverKey,let serverValue = dataModel[serverKey] {
                            if let serverValue = serverValue as? Int {
                                model.serverValue = String(serverValue)
                            }
                            else {
                                model.serverValue = serverValue as? String
                            }
                        }
                    }
                }
                else if let dataModel = dataModel as? NSObject {
                    if let localKey = model.localKey,localKey.contains("<??>") == true,let key1 = localKey.components(separatedBy: "<??>").first,let key2 = localKey.components(separatedBy: "<??>").last {
                        //localKey里面包含<??>的
                        let value1 = dataModel.value(forKey: key1) as? String ?? ""
                        let value2 = dataModel.value(forKey: key2) as? String ?? ""
                        model.localValue = value1 + "<??>" + value2
                    }
                    else if let serverKey = model.serverKey,serverKey.contains("<??>") ,let key1 = serverKey.components(separatedBy: "<??>").first,let key2 = serverKey.components(separatedBy: "<??>").last {
                        //serverKey里面包含<??>的
                        let value1 = dataModel.value(forKey: key1) as? String ?? ""
                        let value2 = dataModel.value(forKey: key2) as? String ?? ""
                        model.serverValue = value1 + "<??>" + value2
                    }
                    else {
                        if let localKey = model.localKey ,let localValue = dataModel.value(forKey: localKey) {
                            model.localValue = localValue as? String
                        }
                        if let serverKey = model.serverKey,let serverValue = dataModel.value(forKey: serverKey) {
                            if let serverValue = serverValue as? Int {
                                model.serverValue = String(serverValue)
                            }
                            else {
                                model.serverValue = serverValue as? String
                            }
                        }
                    }
                }
                else {
                    print("不支持的dataModel类型")
                }
            }
        }
        else if array is [[CommonCellDataModel]] {
            
        }
    }
    
    //获取param
    static func paramWithArray(models:[CommonCellDataModel]) -> [String:Any]? {
        var param = Dictionary<String,AnyObject>()
        for model in models {
            let key = (model.serverKey == nil ? model.localKey:model.serverKey)
            if key == nil {
                continue
            }
            
            let value = (model.serverValue == nil ? model.localValue:model.serverValue)
            if let value = value, value.count > 0 {
                if key!.contains("<??>") {
                    param[(key!.components(separatedBy: "<??>").first)!] = value.components(separatedBy: "<??>").first as AnyObject
                    param[(key!.components(separatedBy: "<??>").last)!] = value.components(separatedBy: "<??>").last as AnyObject
                }
                param[key!] = value as AnyObject
            }
            else if model.required == true {
                ProgressHUD.showMessage((model.title ?? "") + "不能为空。")
                return nil
            }
        }
        
        return param
    }
    
    //获取对应cell
    class func configCell(CellDataModel model:CommonCellDataModel,tableView:UITableView) -> CommonBaseCell {
        var cell:CommonBaseCell!
        if model.cellName != nil && model.cellName!.count > 0 {
            cell = tableView.dequeueReusableCell(withIdentifier: model.cellName!) as? CommonBaseCell
            if cell == nil {
                tableView.register(UINib(nibName: model.cellName!, bundle: nil), forCellReuseIdentifier: model.cellName!)
                cell = tableView.dequeueReusableCell(withIdentifier: model.cellName!) as? CommonBaseCell
            }
        }
        else {
            cell = tableView.dequeueReusableCell(withIdentifier: model.type!) as? CommonBaseCell;
            if (cell == nil) {
                if Bundle.main.path(forResource: configInfo[model.type!]!, ofType: "nib") == nil {
                    tableView.register(NSClassFromString("KChecker."+configInfo[model.type!]!), forCellReuseIdentifier: model.type!)
                }
                else {
                    tableView.register(UINib(nibName: configInfo[model.type!]!, bundle: nil), forCellReuseIdentifier: model.type!)
                }
                cell = tableView.dequeueReusableCell(withIdentifier: model.type!) as? CommonBaseCell;
            }
            if model.type == "blank_space" {
                cell.contentView.backgroundColor = UIColor.kUIColorFromRGB(hexString: "#F5F5F5")
            }
        }
        return cell
    }
}
