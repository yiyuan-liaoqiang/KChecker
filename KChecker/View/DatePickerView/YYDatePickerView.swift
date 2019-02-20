//
//  YYDatePickerView.swift
//  KChecker
//  时间选择、时间区间选择
//  Created by LiaoQiang on 2019/1/29.
//  Copyright © 2019年 Liao Qiang. All rights reserved.
//

import Foundation
import UIKit

var pickerHeight = 220
//选择时间
class YYDatePickerView: YYDatePickerBaseView {
    
    //初始rect，供外部调用
    public class var defaultRect:CGRect {
        return CGRect(x: 0, y: Int(MyConst.MAIN_SCREEN_HEIGHT)-pickerHeight-135, width: Int(MyConst.MAIN_SCREEN_WIDTH), height: pickerHeight+135)
    }
    
    override func okBtnClick() {
        self.callback(datePicker,self.dateString())
        self.hide()
    }
}

//选择时间区间
class YYDateRangePickerView: YYDatePickerBaseView,UITextFieldDelegate {
    var startTimeTf = UITextField()
    var endTimeTf = UITextField()
    var line = UILabel()
    var currentSelectTf:UITextField?
    var model:CommonCellDataModel? {
        didSet {
            self.startTimeTf.placeholder = model?.startTimePlaceholder
            self.endTimeTf.placeholder = model?.endTimePlaceholder
            
            self.startTimeTf.text = model?.startTimeValue
            self.endTimeTf.text = model?.endTimeValue
        }
    }
    
    //初始rect，供外部调用
    public class var defaultRect:CGRect {
        return CGRect(x: 0, y: Int(MyConst.MAIN_SCREEN_HEIGHT)-pickerHeight-185, width: Int(MyConst.MAIN_SCREEN_WIDTH), height: pickerHeight+185)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        startTimeTf.frame = CGRect(x: 15, y: 20, width: (self.datePickerBackView.bounds.width-30-40)/2, height: 32)
        startTimeTf.textAlignment = .center
        startTimeTf.layer.cornerRadius = 4
        startTimeTf.clipsToBounds = true
        startTimeTf.delegate = self
        startTimeTf.layer.borderColor = UIColor.kUIColorFromRGB(hexString: "#CCCCCC").cgColor
        startTimeTf.layer.borderWidth = 1
        startTimeTf.font = UIFont.systemFont(ofSize: 15)
        self.datePickerBackView.addSubview(startTimeTf)
        
        line.frame = CGRect(x: startTimeTf.frame.maxX, y: startTimeTf.frame.minY, width: 40, height: 32)
        line.textAlignment = .center
        line.text = "-"
        line.font = UIFont.systemFont(ofSize: 20)
        line.textColor = UIColor.kUIColorFromRGB(hexString: "#282F3F")
        self.datePickerBackView.addSubview(line)
        
        endTimeTf.frame = CGRect(x: startTimeTf.frame.maxX+40, y: startTimeTf.frame.minY, width: (self.datePickerBackView.bounds.width-30-40)/2, height: 32)
        endTimeTf.layer.cornerRadius = 4
        endTimeTf.clipsToBounds = true
        endTimeTf.delegate = self
        endTimeTf.layer.borderColor = UIColor.kUIColorFromRGB(hexString: "#CCCCCC").cgColor
        endTimeTf.layer.borderWidth = 1
        endTimeTf.font = startTimeTf.font
        endTimeTf.textAlignment = startTimeTf.textAlignment
        self.datePickerBackView.addSubview(endTimeTf)
        
    }
    
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        setSelectedTf(textField)
        return false
    }
    
    //设置
    func setSelectedTf(_ tf:UITextField) {
        currentSelectTf = tf
        if startTimeTf == tf {
            startTimeTf.layer.borderColor = UIColor.kUIColorFromRGB(hexString: "#3E74E7").cgColor
            endTimeTf.layer.borderColor = UIColor.kUIColorFromRGB(hexString: "#CCCCCC").cgColor
        }
        else {
            startTimeTf.layer.borderColor = UIColor.kUIColorFromRGB(hexString: "#CCCCCC").cgColor
            endTimeTf.layer.borderColor = UIColor.kUIColorFromRGB(hexString: "#3E74E7").cgColor
        }
    }
    
    override func show(inView view: UIView) {
        super.show(inView: view)
        setSelectedTf(startTimeTf)
        valueChanged()                                         //设置初始值
    }
    
    override func valueChanged() {
        (currentSelectTf ?? startTimeTf).text = self.dateString()
    }
    
    override func okBtnClick() {
        guard (self.startTimeTf.text?.count ?? 0) * (self.endTimeTf.text?.count ?? 0) > 0  else {
            return
        }
        let startDate = YYDateUtil.dateStringToDate(startTimeTf.text!)
        let endDate = YYDateUtil.dateStringToDate(endTimeTf.text!)
        guard startDate.compare(endDate).rawValue < 0 else {
            ProgressHUD.showMessage("开始时间要小于结束时间")
            return
        }
        self.callback(datePicker,startTimeTf.text! + "<??>" + endTimeTf.text!)
        self.hide()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

class YYDatePickerBaseView: UIView {
    let control = UIControl()
    let datePicker = UIDatePicker()
    let datePickerBackView = UIView()
    let okBtn = UIButton(type: UIButton.ButtonType.custom)
    let cancelBtn = UIButton(type: UIButton.ButtonType.custom)
    var callback:((_ datePicker:UIDatePicker,_ dateString:String) -> ())!
    
    override init(frame: CGRect) {
        super.init(frame:frame)
        
        datePickerBackView.frame = CGRect(x: 10, y: 0, width: Int(frame.width-20), height: pickerHeight + 60 + (NSStringFromClass(type(of: self)) == "KChecker.YYDatePickerView" ? 0:50))
        datePickerBackView.backgroundColor = .white
        datePickerBackView.layer.cornerRadius = 8
        datePickerBackView.clipsToBounds = true
        self.addSubview(datePickerBackView)
        
        datePicker.frame = CGRect(x: 0, y: NSStringFromClass(type(of: self)) == "KChecker.YYDatePickerView" ? 0:50, width: Int(datePickerBackView.frame.width), height: pickerHeight)
        if NSStringFromClass(type(of: self)) == "KChecker.YYDateRangePickerView" {
            datePicker.addTarget(self, action: #selector(valueChanged), for: .valueChanged)
        }
        datePickerBackView.addSubview(datePicker)
        
        okBtn.frame = CGRect(x: 0, y: datePicker.frame.maxY, width: datePickerBackView.frame.width, height: 60)
        okBtn.setTitleColor(UIColor.kUIColorFromRGB(hexString: "#3282F1"), for: .normal)
        okBtn.titleLabel?.font = UIFont.systemFont(ofSize: 20)
        okBtn.setTitle("确定", for: .normal)
        okBtn.addTarget(self, action: #selector(okBtnClick), for: .touchUpInside)
        datePickerBackView.addSubview(okBtn)
        
        let line = UIView(frame: CGRect(x: 0, y: datePicker.frame.maxY, width: datePickerBackView.frame.width, height: 0.5))
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
    
    @objc func valueChanged() {
        
    }
    
    @objc func controlClick() {
        self.hide()
    }
    
    @objc func okBtnClick() {/*在子类处理*/}
    
    fileprivate func dateFormat() -> String! {
        if datePicker.datePickerMode == .date {
            return "yyyy-MM-dd"
        }
        else if (datePicker.datePickerMode == .time) {
            return "HH:mm"
        }
        return "yyyy-MM-dd HH:mm"
    }
    
    fileprivate func dateString() -> String! {
        let formatter = DateFormatter()
        formatter.dateFormat = dateFormat()
        return formatter.string(from: datePicker.date)
    }
    
    func show(inView view:UIView) {
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
