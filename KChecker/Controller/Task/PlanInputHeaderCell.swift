//
//  PlanInputHeaderCell.swift
//  KChecker
//
//  Created by LiaoQiang on 2020/6/21.
//

import UIKit

class PlanInputHeaderCell: CommonBaseCell {

    @IBOutlet weak var iconIv: UIImageView!
    @IBOutlet weak var timeLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func renderUI(model: CommonCellDataModel) {
        if let url = model.localValue {
            self.iconIv?.sd_setImage(with: URL(string: url))
        }
        else {
            self.iconIv.image = UIImage(named: "tuxiangimages20")
        }
        
        super.renderUI(model: model)
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
