//
//  MultipleInputCell.swift
//  KChecker
//
//  Created by LiaoQiang on 2019/4/21.
//

import UIKit

class MultipleInputCell: CommonBaseCell {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var valueLabel: UILabel!
    
    override func renderUI(model: CommonCellDataModel) {
        self.titleLabel.text = model.title
        
        if (model.localValue != nil && model.localValue!.count > 0) {
            self.valueLabel.text = model.localValue;
        }
        else {
            self.valueLabel.text = ""
        }
        super.renderUI(model: model)
    }
}
