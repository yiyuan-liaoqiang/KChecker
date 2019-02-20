//
//  IconTitleCell.swift
//  KChecker
//
//  Created by LiaoQiang on 2019/2/20.
//

import UIKit

class IconTitleCell: CommonBaseCell {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var icon: UIImageView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func renderUI(model: CommonCellDataModel) {
        self.titleLabel.text = model.title
        self.icon.image = UIImage(named: model.icon ?? "")
        super.renderUI(model: model)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
