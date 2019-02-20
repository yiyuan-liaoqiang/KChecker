//
//  BaseInputViewController.swift
//  KChecker
//
//  Created by LiaoQiang on 2019/1/28.
//  Copyright © 2019年 Liao Qiang. All rights reserved.
//

import UIKit
import KMPlaceholderTextView

class BaseInputViewController: BaseViewController,UITextFieldDelegate,UITextViewDelegate {

    var options:InputOptions?
    var textView:KMPlaceholderTextView?
    var textField:UITextField?
    var tipsLabel:UILabel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let rightItem = UIBarButtonItem(title: "保存", style: UIBarButtonItem.Style.plain, target: self, action: #selector(saveAction))
        self.navigationItem.rightBarButtonItems = [rightItem]
        
        self.options = self.baseData as? InputOptions
        self.title = self.options?.title
        
        if options?.rule == "email" {
            //邮箱
            self.setupField(-1)
        }
        else {
            if (options != nil && options?.rule != nil && (options?.rule?.hasPrefix("maxLength@"))!){
                let length = Int(options!.rule!.components(separatedBy: "@").last!)
                if length! <= 20 {
                    self.setupField(length!)
                }
                else {
                    self.setupTextView(length!)
                }
            }
            else {
                self.setupTextView(-1)
            }
        }
    }
    
    //delegate
    func textViewDidChange(_ textView: UITextView) {
        updateTipsStatus(currentLength: (textView.text?.count)!)
    }
    
    @objc func textFieldDidChanged(_ textField:UITextField) {
        updateTipsStatus(currentLength: (textField.text?.count)!)
    }
    
    func updateTipsStatus(currentLength:Int) {
        if options != nil && options?.rule != nil && (options?.rule?.hasPrefix("maxLength@"))! {
            let length = Int(options!.rule!.components(separatedBy: "@").last!)
            self.tipsLabel?.text = String(format: "%d/%d", currentLength,length!)
        }
    }
    
    //保存
    @objc private func saveAction() {
        if self.options?.callback != nil {
            if self.textField != nil {
                self.options?.callback!(self.textField?.text)
            }
            else {
                self.options?.callback!(self.textView?.text)
            }
        }
        self.navigationController?.popViewController(animated: true)
    }

    //one line
    func setupField(_ maxLength:Int) {
        let backView = setupBackView()
        backView.frame = CGRect(x: 0, y: 75+MyConst.EXTRA_BAR_HEIGHT(), width: MyConst.MAIN_SCREEN_WIDTH, height: 55)
        
        self.textField = UITextField(frame: CGRect(x: 10, y: 0, width: backView.frame.width-(maxLength > 0 ? 50:20), height: backView.frame.height))
        self.textField?.font = UIFont.systemFont(ofSize: 15)
        self.textField?.placeholder = self.options?.placeHolder
        self.textField?.text = self.options?.defaultValue
        self.textField?.delegate = self
        self.textField?.keyboardType = self.options?.keyboardType ?? .default
        self.textField?.addTarget(self, action: #selector(textFieldDidChanged(_ :)), for: UIControl.Event.editingChanged)
        backView.addSubview(self.textField!)
        
        if maxLength > 0 {
            setupTipsLabel()
            self.tipsLabel?.frame = CGRect(x: MyConst.MAIN_SCREEN_WIDTH-50, y: 0, width: 50, height: backView.frame.height)
            self.tipsLabel?.text = String(format: "0/%d", maxLength)
            backView.addSubview(self.tipsLabel!)
        }
    }
    
    //double line
    func setupTextView(_ maxLength:Int) {
        let backView = setupBackView()
        backView.frame = CGRect(x: 0, y: 75+MyConst.EXTRA_BAR_HEIGHT(), width: MyConst.MAIN_SCREEN_WIDTH, height: 120+30)
        
        self.textView = KMPlaceholderTextView(frame: CGRect(x: 10, y: 0, width: backView.frame.width-10, height: backView.frame.height-30))
        self.textView?.font = UIFont.systemFont(ofSize: 15)
        self.textView?.text = self.options?.defaultValue
        self.textView?.placeholder = self.options?.placeHolder ?? ""
        self.textView?.delegate = self
        backView.addSubview(self.textView!)
        
        if maxLength > 0 {
            setupTipsLabel()
            self.tipsLabel?.frame = CGRect(x: MyConst.MAIN_SCREEN_WIDTH-50, y: 120, width: 50, height: 30)
            self.tipsLabel?.text = String(format: "0/%d", maxLength)
            backView.addSubview(self.tipsLabel!)
        }
    }
    
    func setupBackView() -> UIView {
        let view = UIView()
        view.backgroundColor = .white
        self.view.addSubview(view)
        return view
    }
    
    func setupTipsLabel() {
        self.tipsLabel = UILabel()
        self.tipsLabel?.font = UIFont.systemFont(ofSize: 12)
        self.tipsLabel?.textAlignment = .center
    }
}

class InputOptions: NSObject {
    var rule:String?
    var title:String?
    var placeHolder:String?
    var defaultValue:String?
    var keyboardType:UIKeyboardType?
    var callback:((_ text:String?) -> ())?
}
