//
//  CommonCellUtil.swift
//  KChecker
//
//  Created by LiaoQiang on 2019/1/24.
//  Copyright © 2019年 Liao Qiang. All rights reserved.
//

import UIKit

class CommonCellUtil: NSObject {
    //type 和 CellName一一对应起来
    class var configInfo:[String:String] {
        return ["title_value":"TitleValueTableViewCell","blank_space":"CommonBaseCell","title_switch":"TitleSwitchTableViewCell","title_textView":"TitleTextViewTableViewCell","title_timeRange":"TitleTimeRangeTableViewCell","icon_title":"IconTitleCell"]
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
