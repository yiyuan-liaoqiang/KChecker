//
//  BaseFormViewController.swift
//  KChecker
//
//  Created by LiaoQiang on 2019/1/24.
//  Copyright © 2019年 Liao Qiang. All rights reserved.
//

import UIKit

class BaseFormViewController: BaseViewController,UITableViewDelegate,UITableViewDataSource,UIPickerViewDelegate,UIPickerViewDataSource {
    
    var dataArray:Array<AnyObject>!                            //数据源，支持一维、二维数组
    var tableView:UITableView!
    var temModel:CommonCellDataModel?
    var keyHeaderView = KeyboardHeaderView(frame: CGRect(x: 0, y: MyConst.MAIN_SCREEN_HEIGHT, width: MyConst.MAIN_SCREEN_WIDTH, height: 40))
    var picker:YYNPickerView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setupTableView()
        
        if #available(iOS 11.0, *) {
            self.tableView.contentInsetAdjustmentBehavior = .never
        } else {
            self.automaticallyAdjustsScrollViewInsets = false;
        }
        self.view.addSubview(self.keyHeaderView)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(_:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(_:)), name: UIResponder.keyboardWillHideNotification, object: nil)
        
        setupPicker()
    }
    
    func setupUI() {
        keyHeaderView.backgroundColor = .white
        keyHeaderView.callback = {(index) in
            
        }
        self.view.addSubview(keyHeaderView)
    }
    
    //UITableViewDelegate,UITableViewDataSource
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let array = self.dataArray as? Array<Array<CommonCellDataModel>>
        return array == nil ? self.dataArray.count : array![section].count
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return (self.dataArray as? Array<Array<CommonCellDataModel>>) == nil ? 1 : self.dataArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let model = modelForIndexPath(indexPath)

        let cell = CommonCellUtil.configCell(CellDataModel: model, tableView: tableView)
        cell.renderUI(model: model)
        cell.selectionStyle = (model.selectStyle == "none" ? .none:.default)
        
        weak var weakSelf = self
        cell.callback = {(type,obj) in
            weakSelf?.handleCellCallback(type, obj, indexPath)
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let model = modelForIndexPath(indexPath)
        
        if model.height != nil {
            return CGFloat(truncating: model.height!)
        }
        else {
            return 50
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        self.temModel = modelForIndexPath(indexPath)
        if self.temModel?.action != nil {
            let selector = NSSelectorFromString((self.temModel?.action)!)
            if self.responds(to: selector) {
                self.perform(selector, with: nil)
            }
        }
        else if (self.temModel?.options?.count ?? 0) > 0 {
            //从自己选项里面选择
            selectFromOptions()
        }
        else if self.temModel?.enable == true {
            
        }
    }
    
    //从options里面选择
    func selectFromOptions() {
        self.view.addSubview(self.picker)
        self.picker.picker.reloadComponent(0)
        self.picker.show()
    }
    
    //UIPickerViewDelegate,UIPickerViewDataSource
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return (self.temModel!.options?.count)!
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return self.temModel?.options![row]["name"] as? String
    }
    
    func modelForIndexPath(_ indexPath:IndexPath) -> CommonCellDataModel {
        let array = self.dataArray as? Array<Array<CommonCellDataModel>>
        if array == nil {
            return self.dataArray[indexPath.row] as! CommonCellDataModel
        }
        else {
            return array![indexPath.section][indexPath.row]
        }
    }
    
    func handleCellCallback(_ type:String?,_ obj:AnyObject?,_ indexPath:IndexPath) {

    }
    
    //actions
    //到下一个页面去输入
    @objc func gotoInput() {
        let options = self.temModel?.getInputOptions()
        weak var weakSelf = self
        options?.callback = {(text) in
            weakSelf?.temModel?.localValue = text
            weakSelf?.tableView.reloadData()
            weakSelf?.formDataHasChanged()
        }
        YYRoute.pushToController("BaseInputViewController", data: options)
    }
    
    //选择时间
    @objc func selectTime() {
        let datePickerView = YYDatePickerView(frame: YYDatePickerView.defaultRect)
        if self.temModel?.format != nil {
            if self.temModel?.format == NSNumber(integerLiteral: 1) {
                datePickerView.datePicker.datePickerMode = .date
            }
            else if self.temModel?.format == NSNumber(integerLiteral: 2) {
                datePickerView.datePicker.datePickerMode = .dateAndTime
            }
            else if self.temModel?.format == NSNumber(integerLiteral: 3) {
                datePickerView.datePicker.datePickerMode = .time
            }
        }
        //可选时间范围
        if self.temModel?.enableSelectDate != nil {
            if self.temModel?.enableSelectDate == "past" {
                datePickerView.datePicker.maximumDate = Date()
            }
            else if self.temModel?.enableSelectDate == "future" {
                datePickerView.datePicker.minimumDate = Date()
            }
            else {
                datePickerView.datePicker.minimumDate = nil
                datePickerView.datePicker.maximumDate = nil
            }
        }
        else {
            datePickerView.datePicker.minimumDate = nil
            datePickerView.datePicker.maximumDate = nil
        }
        
        if self.temModel?.localValue != nil {
            datePickerView.datePicker.date = YYDateUtil.dateStringToDate((self.temModel?.localValue)!)
        }
        datePickerView.show(inView: self.view)
        
        weak var weakSelf = self
        datePickerView.callback = {(datePicker,date) in
            weakSelf?.temModel?.localValue = date
            weakSelf?.tableView.reloadData()
            weakSelf?.formDataHasChanged()
        }
    }
    
    //选择时间区间
    @objc func selectTimeRange() {
        let datePickerView = YYDateRangePickerView(frame: YYDateRangePickerView.defaultRect)
        datePickerView.model = self.temModel
        if self.temModel?.format != nil {
            if self.temModel?.format == NSNumber(integerLiteral: 1) {
                datePickerView.datePicker.datePickerMode = .date
            }
            else if self.temModel?.format == NSNumber(integerLiteral: 2) {
                datePickerView.datePicker.datePickerMode = .dateAndTime
            }
            else if self.temModel?.format == NSNumber(integerLiteral: 3) {
                datePickerView.datePicker.datePickerMode = .time
            }
        }
        //可选时间范围
        if self.temModel?.enableSelectDate != nil {
            if self.temModel?.enableSelectDate == "past" {
                datePickerView.datePicker.maximumDate = Date()
            }
            else if self.temModel?.enableSelectDate == "future" {
                datePickerView.datePicker.minimumDate = Date()
            }
            else {
                datePickerView.datePicker.minimumDate = nil
                datePickerView.datePicker.maximumDate = nil
            }
        }
        else {
            datePickerView.datePicker.minimumDate = nil
            datePickerView.datePicker.maximumDate = nil
        }
        
        if self.temModel?.localValue != nil {
            datePickerView.datePicker.date = YYDateUtil.dateStringToDate((self.temModel?.startTimeValue)!)
        }
        datePickerView.show(inView: self.view)
        
        weak var weakSelf = self
        datePickerView.callback = {(datePicker,date) in
            weakSelf?.temModel?.localValue = date
            weakSelf?.tableView.reloadData()
            weakSelf?.formDataHasChanged()
        }
    }
    
    //form data has changed
    func formDataHasChanged() {
        
    }
    
    @objc func selectDataFromOptions() {
        //从options选取数据
        let pickerView = YYPickerView(frame: YYPickerView.defaultRect)
        weak var weakSelf = self
        pickerView.callback = {(index) in
            weakSelf?.temModel?.localValue = weakSelf?.temModel?.options![index]["value"] as? String
            weakSelf?.temModel?.serverValue = weakSelf?.temModel?.options![index]["id"] as? String
            weakSelf?.tableView.reloadData()
            weakSelf?.formDataHasChanged()
        }
        pickerView.show(inView: self.view, dataArray: (self.temModel?.options)!)
    }
    
    //键盘监听事件
    @objc func keyboardWillShow(_ noti:Notification) {
        if self.navigationController?.topViewController == self {
            let keyboardRect = noti.userInfo?["UIKeyboardFrameEndUserInfoKey"] as? CGRect
            self.keyHeaderView.superview?.bringSubviewToFront(self.keyHeaderView)
            UIView.animate(withDuration: 0.22) {
                self.keyHeaderView.frame = CGRect(x: 0, y: MyConst.MAIN_SCREEN_HEIGHT-(keyboardRect?.height)!-40, width: MyConst.MAIN_SCREEN_WIDTH, height: 40)
                var rect = self.tableView.frame
                rect.size.height = MyConst.MAIN_SCREEN_HEIGHT-MyConst.NAV_BAR_HEIGHT()-(keyboardRect?.height)!-40
                self.tableView.frame = rect
            }
        }
    }
    
    @objc func keyboardWillHide(_ noti:Notification) {
        if self.navigationController?.topViewController == self {
            UIView.animate(withDuration: 0.22) {
                self.keyHeaderView.frame = CGRect(x: 0, y: MyConst.MAIN_SCREEN_HEIGHT, width: MyConst.MAIN_SCREEN_WIDTH, height: 40)
                var rect = self.tableView.frame
                rect.size.height = MyConst.MAIN_SCREEN_HEIGHT-MyConst.NAV_BAR_HEIGHT()
                self.tableView.frame = rect
            }
        }
    }
    
    func setupTableView() {
        self.tableView = UITableView(frame: CGRect(x: 0, y: MyConst.NAV_BAR_HEIGHT(), width: MyConst.MAIN_SCREEN_WIDTH, height: MyConst.MAIN_SCREEN_HEIGHT-MyConst.NAV_BAR_HEIGHT()), style: .plain)
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.separatorStyle = .none
        self.tableView.tableFooterView = UIView()
        self.view.addSubview(self.tableView)
    }
    
    func setupPicker() {
        self.picker = YYNPickerView(frame: CGRect(x: 0, y: MyConst.MAIN_SCREEN_HEIGHT-200, width: MyConst.MAIN_SCREEN_WIDTH, height: 200))
        self.picker.picker.delegate = self
        self.picker.picker.dataSource = self
        self.picker.backgroundColor = .white
        
        weak var weakSelf = self
        self.picker.callback = {(index) in
            weakSelf?.temModel?.localValue = weakSelf?.temModel?.options![index]["name"] as? String
            weakSelf?.tableView.reloadData()
        }
    }
}
