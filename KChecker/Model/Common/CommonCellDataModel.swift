//
//  CommonCellDataModel.swift
//  Jobnt
//  表单通用数据模型--model for all form
//  Created by LiaoQiang on 2019/1/24.
//  Copyright © 2019年 Yiyuan Networks 上海义援网络科技有限公司. All rights reserved.
//

import UIKit
import HandyJSON

class CommonCellDataModel: HandyJSON {
    var id:String?                              //用来做一些特殊判断，不能用title来做判断
    var icon:String?
    var title:String?
    var showAccessory:Bool?                     //是否显示右箭头
    var localValue:String?                      //因为很多时候，本地展示的和传给服务端的并不是一个字段，比如本地显示name，传给服务端的则可能是id，所以才有localValue和serverValue之分。如果一个model保存了多个需要传给后端的数据，比如选择时间，则key和value之间均用 <??> 区分。eg. startDate<??>endDate
    var serverValue:String?
    var localKey:String?
    var serverKey:String?
    var height:NSNumber?                        //这里仅仅是plist初始高度或者默认高度，如果高度有改变，需要通过cHeight获取
    var type:String?                            //type类型
    var showSepLine:Bool?                       //是否显示cell分割线
    var placeholder:String?
    var inputPlaceholder:String?                //跳转到下一页输入的提示
    var lineInsetsOffset:NSNumber?              //分割线缩进
    var action:String?                          //点击调用方法名
    var enable:Bool?                            //textfield是否可编辑
    var required:Bool?                          //是否必填
    var format:NSNumber?                        //时间选择格式--1:date 2:date&time 3:time
    var keyboardType:NSNumber?                  //键盘类型  4-数字键盘 7-email地址
    var rule:String?                            //输入规则进行本地验证-:phone:手机号码（纯数字，11位），email:邮箱，maxLength@50：最大长度50，minLength@10：最小长度10 length:18：长度为18（身份证）      notnull/:key1/key2 请先选择key1或者key2    notnull&:key1&key2 请先选择key1和key2
    var buttonType:Bool?                        //type = button时候的样式  delete-删除样式，红底白字
    var enableSelectDate:String?                //past future all
    var cellName:String?                        //自定义cell名称，type为空生效
    var options:Array<[String:AnyObject]>?      //自带选项
    var selectStyle:String?                     //选中变色
    var titleAttribute:[String:AnyObject]?      //titleLabel 属性 support:fontSize、textColor、weight
    
    required init() {}
    
    var cHeight:NSNumber? {
        get {
            if let cellName = self.cellName , cellName == "ImgPickerTableViewCell" {
                //计算图片cell高度    77 12
                var lines = 1
                let imgCountPerLine = (Int(MyConst.MAIN_SCREEN_WIDTH)-15-(15-Const.imgPickerCell_ImageWidth)) / (Const.imgPickerCell_ImageWidth+Const.imgPickerCell_ImageSpace)
                let imgs = self.localValue?.split(separator: ",")
                if imgs != nil {
                    lines = (imgs!.count+1)/imgCountPerLine + ((imgs!.count+1)%imgCountPerLine == 0 ? 0:1)
                }
                return 52 + (Const.imgPickerCell_ImageWidth + Const.imgPickerCell_ImageSpace) * lines - Const.imgPickerCell_ImageSpace as NSNumber
            }
            return self.height
        }
    }
    
    //跳转到下一页输入的选项
    func getInputOptions() -> InputOptions {
        let options = InputOptions()
        options.rule = self.rule
        options.title = self.title
        options.placeHolder = self.inputPlaceholder
        options.defaultValue = self.localValue
        options.keyboardType = (self.keyboardType?.intValue).map { UIKeyboardType(rawValue: $0) } ?? .default
        return options
    }
    
    //local property ，本地属性，不用管，为了方便和统一
    var startTimePlaceholder:String? {
        get {
            guard self.placeholder != nil else {return nil}
            return self.placeholder!.components(separatedBy: "<??>").first!
        }
    }
    
    var endTimePlaceholder:String? {
        get {
            guard self.placeholder != nil else {return nil}
            return self.placeholder!.components(separatedBy: "<??>").last!
        }
    }
    
    var startTimeValue:String? {
        get {
            guard self.localValue != nil else {return nil}
            return self.localValue!.components(separatedBy: "<??>").first!
        }
    }
    
    var endTimeValue:String? {
        get {
            guard self.localValue != nil else {return nil}
            return self.localValue!.components(separatedBy: "<??>").last!
        }
    }
}
