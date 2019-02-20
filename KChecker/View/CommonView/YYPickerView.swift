//
//  YYPickerView.swift
//  KChecker
//
//  Created by LiaoQiang on 2019/1/31.
//  Copyright © 2019年 Liao Qiang. All rights reserved.
//

import UIKit

class YYPickerView: UIView,UIPickerViewDelegate,UIPickerViewDataSource {
    
    let control = UIControl()
    let picker = UIPickerView()
    let datePickerBackView = UIView()
    let okBtn = UIButton(type: UIButton.ButtonType.custom)
    let cancelBtn = UIButton(type: UIButton.ButtonType.custom)
    var callback:((_ index:Int) -> ())!
    var dataArray:[[String:AnyObject]]!
    
    //初始rect，供外部调用
    public class var defaultRect:CGRect {
        return CGRect(x: 0, y: Int(MyConst.MAIN_SCREEN_HEIGHT)-pickerHeight-135, width: Int(MyConst.MAIN_SCREEN_WIDTH), height: pickerHeight+135)
    }
    
    override init(frame: CGRect) {
        super.init(frame:frame)
        
        datePickerBackView.frame = CGRect(x: 10, y: 0, width: Int(frame.width-20), height: pickerHeight + 60 )
        datePickerBackView.backgroundColor = .white
        datePickerBackView.layer.cornerRadius = 8
        datePickerBackView.clipsToBounds = true
        self.addSubview(datePickerBackView)
        
        picker.frame = CGRect(x: 0, y: 0, width: Int(datePickerBackView.frame.width), height: pickerHeight)
        picker.delegate = self
        picker.dataSource = self
        datePickerBackView.addSubview(picker)
        
        okBtn.frame = CGRect(x: 0, y: picker.frame.maxY, width: datePickerBackView.frame.width, height: 60)
        okBtn.setTitleColor(UIColor.kUIColorFromRGB(hexString: "#3282F1"), for: .normal)
        okBtn.titleLabel?.font = UIFont.systemFont(ofSize: 20)
        okBtn.setTitle("确定", for: .normal)
        okBtn.addTarget(self, action: #selector(okBtnClick), for: .touchUpInside)
        datePickerBackView.addSubview(okBtn)
        
        let line = UIView(frame: CGRect(x: 0, y: picker.frame.maxY, width: datePickerBackView.frame.width, height: 0.5))
        line.backgroundColor = UIColor.kUIColorFromRGB(hexString: "#c5c5c5")
        datePickerBackView.addSubview(line)
        
        cancelBtn.frame = CGRect(x: 10, y: datePickerBackView.frame.maxY+8, width: datePickerBackView.frame.width, height: 60)
        cancelBtn.setTitleColor(UIColor.kUIColorFromRGB(hexString: "#3282F1"), for: .normal)
        cancelBtn.titleLabel?.font = UIFont.systemFont(ofSize: 20)
        cancelBtn.setTitle("取消", for: .normal)
        cancelBtn.addTarget(self, action: #selector(controlClick), for: .touchUpInside)
        cancelBtn.layer.cornerRadius = 8
        cancelBtn.clipsToBounds = true
        cancelBtn.backgroundColor = .white
        self.addSubview(cancelBtn)
        
        control.backgroundColor = UIColor.init(red: 0, green: 0, blue: 0, alpha: 0)
        control.addTarget(self, action: #selector(controlClick), for: UIControl.Event.touchUpInside)
    }
    
    //UIPickerViewDelegate,UIPickerViewDataSource
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return self.dataArray.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return self.dataArray[row]["value"] as? String
    }
    
    @objc func valueChanged() {
        
    }
    
    @objc func controlClick() {
        self.hide()
    }
    
    @objc func okBtnClick() {
        self.callback(self.picker.selectedRow(inComponent: 0))
        self.hide()
    }
    
    func show(inView view:UIView,dataArray:Array<[String:AnyObject]>) {
        //refresh data
        self.dataArray = dataArray
        self.picker.reloadAllComponents()
        
        control.frame = view.bounds
        view.addSubview(control)
        view.addSubview(self)
        UIView.animate(withDuration: 0.22) {
            self.control.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.3)
            var rect = self.frame
            rect.origin.y = MyConst.MAIN_SCREEN_HEIGHT-rect.height
            self.frame = rect
        }
    }
    
    func hide() {
        UIView.animate(withDuration: 0.22, animations: {
            self.control.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0)
            var rect = self.frame
            rect.origin.y = MyConst.MAIN_SCREEN_HEIGHT
            self.frame = rect
        }) { (completion) in
            self.control.removeFromSuperview()
            self.removeFromSuperview()
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
