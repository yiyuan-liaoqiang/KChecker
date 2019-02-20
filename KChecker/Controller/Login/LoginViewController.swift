//
//  LoginViewController.swift
//  KChecker
//
//  Created by LiaoQiang on 2019/2/20.
//

import UIKit

class LoginViewController: BaseWebViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = "登录"
        
        let filePath = Bundle.main.path(forResource: "Login.html", ofType: nil)
        self.webView.load(URLRequest(url: URL(fileURLWithPath: filePath!)))
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
