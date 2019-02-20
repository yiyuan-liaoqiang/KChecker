//
//  BaseViewController.swift
//  KChecker
//
//  Created by LiaoQiang on 2019/1/24.
//  Copyright © 2019年 Liao Qiang. All rights reserved.
//

import UIKit

class BaseViewController: UIViewController {

    @objc var baseData:AnyObject?
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.view.backgroundColor = UIColor.kUIColorFromRGB(hexString: "#F5F5F5")
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.font:UIFont.systemFont(ofSize: 17)]
        self.navigationController?.isNavigationBarHidden = false
        
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
        print(NSStringFromClass(type(of: self)),"dealloc")
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
