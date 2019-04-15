//
//  TitleValueTableViewCell.swift
//  KChecker
//
//  Created by LiaoQiang on 2019/1/24.
//  Copyright © 2019年 Liao Qiang. All rights reserved.
//

import UIKit

class TitleValueVTableViewCell: CommonBaseCell {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var valueTf: UITextField!
    @IBOutlet weak var tfRightConstraint: NSLayoutConstraint!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
//        NotificationCenter.default.addObserver(self, selector: #selector(textfieldDidChange(_ :)), name: UITextField.textDidChangeNotification, object: nil)
        self.valueTf.addTarget(self, action: #selector(textfieldDidChange), for: .editingChanged)
        self.valueTf.addObserver(self, forKeyPath: "text", options: .new, context: nil)
    }
    
    @objc func textfieldDidChange() {
        
        if self.titleLabel.isHidden {
            self.titleLabel.isHidden = false
            UIView.animate(withDuration: 0.15) {
                self.titleLabel.frame = CGRect(x: 15, y: 2, width: MyConst.MAIN_SCREEN_WIDTH-30, height: 20)
            }
        }
        else if self.valueTf.text?.count == 0 && self.titleLabel.isHidden == false {
            UIView.animate(withDuration: 0.15, animations: {
                self.titleLabel.frame = CGRect(x: 15, y: 10, width: MyConst.MAIN_SCREEN_WIDTH-30, height: 20)
                self.titleLabel.alpha = 0
            }) { (finish) in
                self.titleLabel.isHidden = true
                self.titleLabel.alpha = 1
            }
        }
    }
    
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        textfieldDidChange()
    }
    
    override func renderUI(model: CommonCellDataModel) {
        self.titleLabel.text = model.title
        
        if (model.localValue != nil && model.localValue!.count > 0) {
            self.valueTf.text = model.localValue;
        }
        else if (model.placeholder != nil)
        {
            self.valueTf.placeholder = model.placeholder;
        }
        
        //valueLabel 距离右边距距离
        if model.showAccessory == true {
            self.tfRightConstraint.constant = 0
        }
        else {
            self.tfRightConstraint.constant = 15
        }
        
        self.valueTf.isEnabled = model.enable ?? false
        super.renderUI(model: model)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
        self.valueTf.removeObserver(self, forKeyPath: "text")
    }
}
