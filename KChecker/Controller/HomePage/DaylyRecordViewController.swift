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
        // Do any additional setup after loading the view.
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
