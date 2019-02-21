//
//  HomePageViewController.swift
//  KChecker
//
//  Created by LiaoQiang on 2019/2/20.
//

import UIKit
import WebKit

class HomePageViewController: BaseWebViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        self.webView.frame = CGRect(x: 0, y: MyConst.NAV_BAR_HEIGHT(), width: MyConst.MAIN_SCREEN_WIDTH, height: MyConst.MAIN_SCREEN_HEIGHT-MyConst.TAB_BAR_HEIGHT()-MyConst.NAV_BAR_HEIGHT())
        
        let filePath = Bundle.main.path(forResource: "HomePage.html", ofType: nil)
        self.webView.load(URLRequest(url: URL(fileURLWithPath: filePath!)))
        
        self.addActionsNames(actions: ["scan"])
        
    }
    
    override func userContentController(_ userContentController: WKUserContentController, didReceive message: WKScriptMessage) {
        if message.name == "scan" {
            //扫一扫
            YYRoute.pushToController("ECQRCodeScanVC", data: nil)
        }
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
