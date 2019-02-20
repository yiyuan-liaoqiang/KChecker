//
//  TitleTimeRangeTableViewCell.swift
//  KChecker
//
//  Created by LiaoQiang on 2019/1/30.
//  Copyright © 2019年 Liao Qiang. All rights reserved.
//

import UIKit

//<??>
class TitleTimeRangeTableViewCell: CommonBaseCell {

    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var startTimeLabel: UITextField!
    @IBOutlet weak var endTimeLabel: UITextField!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func renderUI(model: CommonCellDataModel) {
        if model.placeholder?.isEmpty == false {
            self.startTimeLabel.placeholder = model.placeholder!.components(separatedBy: "<??>").first!
            self.endTimeLabel.placeholder = model.placeholder!.components(separatedBy: "<??>").last!
        }
        else {
            self.startTimeLabel.placeholder = "开始时间"
            self.endTimeLabel.placeholder = "结束时间"
        }
        
        if model.localValue?.isEmpty == false {
            self.startTimeLabel.text = model.localValue!.components(separatedBy: "<??>").first!
            self.endTimeLabel.text = model.localValue!.components(separatedBy: "<??>").last!
        }
        else {
            self.startTimeLabel.text = ""
            self.endTimeLabel.text = ""
        }
        
        self.titleLabel.text = model.title
        super.renderUI(model: model)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
