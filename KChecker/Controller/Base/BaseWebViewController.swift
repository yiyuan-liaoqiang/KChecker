//
//  BaseWebViewController.swift
//  KChecker
//
//  Created by LiaoQiang on 2019/1/24.
//  Copyright © 2019年 Liao Qiang. All rights reserved.
//

import UIKit
import WebKit

class BaseWebViewController: BaseViewController,WKUIDelegate,WKNavigationDelegate,WKScriptMessageHandler {

    var webView:WKWebView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupWebView()
    }
    
    //WKNavigationDelegate
    func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, decisionHandler: @escaping (WKNavigationActionPolicy) -> Void) {
        //如果是跳转一个新页面
        if (navigationAction.targetFrame == nil) {
            webView.load(navigationAction.request)
        }
        decisionHandler(WKNavigationActionPolicy.allow)
    }
    
    func webView(_ webView: WKWebView, decidePolicyFor navigationResponse: WKNavigationResponse, decisionHandler: @escaping (WKNavigationResponsePolicy) -> Void) {
        decisionHandler(WKNavigationResponsePolicy.allow)
    }
    
    func userContentController(_ userContentController: WKUserContentController, didReceive message: WKScriptMessage) { /*warning:该类不做任何操作，一律在子类实现*/ }
    
    //向WKWebView注入监听
    func addActionsNames(actions:Array<String>) {
        let config = self.webView.configuration
        for action in actions {
            config.userContentController.add(self, name: action)
        }
    }

    func setupWebView() {
        let config = WKWebViewConfiguration()
        config.userContentController = WKUserContentController()
        
        self.webView = WKWebView.init(frame: CGRect(x: 0, y: MyConst.NAV_BAR_HEIGHT(), width: MyConst.MAIN_SCREEN_WIDTH, height: MyConst.MAIN_SCREEN_HEIGHT-MyConst.NAV_BAR_HEIGHT()), configuration: config)
        self.webView.uiDelegate = self
        self.webView.navigationDelegate = self
        self.view.addSubview(self.webView)
    }
}
