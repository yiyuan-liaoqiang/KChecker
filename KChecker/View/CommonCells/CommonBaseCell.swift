//
//  CommonBaseCell.swift
//  KChecker
//
//  Created by LiaoQiang on 2019/1/24.
//  Copyright © 2019年 Liao Qiang. All rights reserved.
//

import UIKit

class CommonBaseCell: UITableViewCell,UITextFieldDelegate {
    private var model:CommonCellDataModel! {
        didSet {
            
        }
    }
    
    var callback:((_ type:String?,_ obj:AnyObject?) -> ())!
    
    override func awakeFromNib() {
        for view in self.contentView.subviews {
            if view.isKind(of: UITextField.self)  {
                let textField = view as! UITextField
                textField.returnKeyType = .done
                textField.delegate = (textField.delegate != nil) ? textField.delegate:self
            }
        }
    }
    
    //处理一些通用UI，非通用的在子类实现
    func renderUI(model:CommonCellDataModel) {
        self.model = model
        //必填*
        if self.responds(to: #selector(getter: UIButton.titleLabel)) {
            if model.titleAttribute != nil {
                self.setAttribute(model.titleAttribute!, forLabel: self.value(forKey: "titleLabel") as! UILabel)
            }
        }
        self.contentView.layoutIfNeeded()
        self.accessoryType = (model.showAccessory == true ? .disclosureIndicator:.none)
    }
    
    //设置 titleLabel font
    func setAttribute(_ attribute:Dictionary<String,AnyObject>, forLabel label:UILabel) {
        var font:UIFont?
        if attribute["fontSize"] != nil {
            font = UIFont.systemFont(ofSize: CGFloat(Int(attribute["fontSize"] as! String)!))
        }
        if attribute["textColor"] != nil {
            var color = attribute["textColor"] as! String
            if color.hasPrefix("#") == false {
                color = "#"+color
            }
            label.textColor = UIColor.kUIColorFromRGB(hexString: color)
        }
        if attribute["weight"] != nil {
            let fontSize = attribute["fontSize"] == nil ? 16:CGFloat(Int(attribute["fontSize"] as! String)!)
            let weight = attribute["weight"] as! String
            if weight == "medium" {
                font = UIFont.systemFont(ofSize: fontSize, weight: UIFont.Weight.medium)
            }
            else if weight == "bold" {
                font = UIFont.systemFont(ofSize: fontSize, weight: UIFont.Weight.bold)
            }
        }
        if font != nil {
            label.font = font
        }
    }
    
    //绘制分割线
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        
        guard let model = model, model.showSepLine == true else {
            return
        }
        
        let context = UIGraphicsGetCurrentContext()
        context!.beginPath()
        context!.move(to: CGPoint(x: CGFloat(truncating: model.lineInsetsOffset ?? 15), y: rect.size.height - 0.5))
        context!.addLine(to: CGPoint(x: rect.size.width, y: rect.size.height - 0.5))
        context!.setStrokeColor(UIColor.red.cgColor)
        context!.setLineWidth(0.5)
        context!.closePath()
        context!.drawPath(using: CGPathDrawingMode.fill)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
}
