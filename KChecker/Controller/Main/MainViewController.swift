//
//  MainViewController.swift
//  KChecker
//
//  Created by LiaoQiang on 2019/1/24.
//  Copyright © 2019年 Liao Qiang. All rights reserved.
//

import UIKit

class MainViewController: UITabBarController {

    var tabbarArray:Array<[String:String]>!
    override func viewDidLoad() {
        super.viewDidLoad()

        let filePath = CommonUtils.bundlePathWithFileName(fileName: "WorkFinderTabbar.plist")
        self.tabbarArray = NSArray(contentsOfFile: filePath) as? Array<[String : String]>
        
        let tabbar = TabbarView(frame: CGRect(x: 0, y: MyConst.MAIN_SCREEN_HEIGHT-MyConst.SYSTEEM_BOTTOM_MARGIN-50, width: MyConst.MAIN_SCREEN_WIDTH, height: 50), tabbarList: self.tabbarArray as NSArray)
        weak var weakSelf = self
        tabbar.callback = {(index) in
            weakSelf?.selectedIndex = index
            weakSelf?.title = weakSelf?.tabbarArray[index]["title"]
        }
        self.view.addSubview(tabbar)
        
        var controllers = Array<UIViewController>()
        for dic in self.tabbarArray {
            let vc = (NSClassFromString("KChecker." + dic["controller"]!) as! BaseViewController.Type).init()
            controllers.append(vc)
        }
        self.viewControllers = controllers
        self.title = self.tabbarArray.first!["title"]
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.tabBar.isHidden = true
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
