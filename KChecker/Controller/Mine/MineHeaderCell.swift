//
//  MineHeaderCell.swift
//  KChecker
//
//  Created by LiaoQiang on 2019/2/20.
//

import UIKit
import SwiftyJSON

class MineHeaderCell: CommonBaseCell {

    @IBOutlet weak var avatarIv: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        let userInfo = try? YYNCache.userRelatedStorage?.object(forKey: "userInfo").dictionaryValue
        if let userInfo = userInfo {
            if let nickJson = userInfo?["nick"]{
                self.nameLabel.text = nickJson.stringValue
            }
            
            if let avatarJson = userInfo?["avatar"] {
                self.avatarIv.sd_setImage(with: URL(string: avatarJson.stringValue))
            }
        }
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
