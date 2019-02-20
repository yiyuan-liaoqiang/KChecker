//
//  TitleSwitchTableViewCell.swift
//  KChecker
//
//  Created by LiaoQiang on 2019/1/29.
//  Copyright © 2019年 Liao Qiang. All rights reserved.
//

import UIKit

class TitleSwitchTableViewCell: CommonBaseCell {

    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var sw: UISwitch!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func renderUI(model: CommonCellDataModel) {
        self.titleLabel.text = model.title
        self.sw.isOn = Bool((model.localValue ?? "0")) ?? false
        
        super.renderUI(model: model)
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
