//
//  TitleValueTableViewCell.swift
//  KChecker
//
//  Created by LiaoQiang on 2019/1/24.
//  Copyright © 2019年 Liao Qiang. All rights reserved.
//

import UIKit

class TitleValueTableViewCell: CommonBaseCell {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var valueTf: UITextField!
    @IBOutlet weak var tfRightConstraint: NSLayoutConstraint!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
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
    
}
