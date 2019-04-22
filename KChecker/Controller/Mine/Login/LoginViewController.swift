//
//  LoginViewController.swift
//  Jobnt
//
//  Created by LiaoQiang on 2019/2/13.
//  Copyright © 2019年 Yiyuan Networks 上海义援网络科技有限公司. All rights reserved.
//

import UIKit
import SwiftyJSON

class LoginViewController: BaseViewController,UITextFieldDelegate {
    
    @IBOutlet weak var phoneTf: UITextField!
    @IBOutlet weak var loginBtn: UIButton!
    @IBOutlet weak var passwordTf: UITextField!
    @IBOutlet weak var userNameView: UIView!
    @IBOutlet weak var passwordView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
       
        self.view.backgroundColor = .white
        self.loginBtn.layer.cornerRadius = 4
        self.loginBtn.clipsToBounds = true
        
        self.phoneTf.addObserver(self, forKeyPath: "text", options: .new, context: nil)
        self.passwordTf.addObserver(self, forKeyPath: "text", options: .new, context: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(textDidChange), name: UITextField.textDidChangeNotification, object: nil)
        self.phoneTf.text = AccountHelper.userInfo?.phone
        
        self.userNameView.layer.cornerRadius = 20;
        self.userNameView.clipsToBounds = true;
        self.userNameView.layer.borderColor = UIColor.kUIColorFromRGB(hexString: "#d9d9d9").cgColor
        self.userNameView.layer.borderWidth = 1
        
        self.passwordView.layer.cornerRadius = 20;
        self.passwordView.clipsToBounds = true;
        self.passwordView.layer.borderColor = UIColor.kUIColorFromRGB(hexString: "#d9d9d9").cgColor
        self.passwordView.layer.borderWidth = 1
    }
    
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        self.textDidChange()
    }
    
    @objc func textDidChange() {
        if (self.phoneTf.text?.count ?? 0 > 0) && (self.passwordTf.text?.count ?? 0 > 0)  {
            self.loginBtn.backgroundColor = UIColor.kUIColorFromRGB(hexString: "#0d94fd")
            self.loginBtn.isEnabled = true
        }
        else {
            self.loginBtn.backgroundColor = UIColor.kUIColorFromRGB(hexString: "#B4B9C3")
            self.loginBtn.isEnabled = false
        }
    }
    
    @IBAction func loginAction(_ sender: Any) {
        AccountHelper.loginWithPwd(["username":self.phoneTf.text as AnyObject,"password":self.passwordTf.text as AnyObject]) { (err, data) in
            guard err != nil else {
                //用户信息保存在本地
//                let user = UserModel.deserialize(from: data as? [String:Any])
//                AccountHelper.synchronizeUserInfo(user)
              try? YYNCache.userRelatedStorage?.setObject(JSON(true), forKey: "isLogin")
                try? YYNCache.userRelatedStorage?.setObject(JSON(data as Any), forKey: "token")
                YYRoute.pushToController(MainViewController(), data: nil)
                return
            }
            ProgressHUD.showMessage(err!)
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.isNavigationBarHidden = true
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
