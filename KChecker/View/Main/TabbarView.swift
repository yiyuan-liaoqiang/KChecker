//
//  TabbarView.swift
//  BaoLi
//
//  Created by Liao Qiang on 2018/1/15.
//  Copyright © 2018年 BaoLi. All rights reserved.
//

import Foundation
import UIKit

protocol TabbarViewDelegate {
    func hasSelectedIndex(index:NSInteger) -> ()
}

class TabbarView: UIView {
    @objc var callback = { (selectedIndex:Int) -> Void in
        
    }
    var selectedIndex:Int = 10
    
    @objc init(frame: CGRect,tabbarList:NSArray) {
        super.init(frame: frame)
        self.backgroundColor = UIColor.kUIColorFromRGB(hexString: "#f5f5f5")
        self.UIInital(tabbarList: tabbarList)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    func UIInital(tabbarList:NSArray) -> Void {
        let tabbarCount = tabbarList.count;
        let tabbarButtonWidth = MyConst.MAIN_SCREEN_WIDTH/CGFloat(tabbarCount);
        
        for index in 0..<tabbarCount {
            let dic = tabbarList[index]
            let singleView = TabbarSingleView.init(frame: CGRect.init(x: tabbarButtonWidth*CGFloat(index), y: CGFloat(0), width: tabbarButtonWidth, height: MyConst.TAB_BAR_HEIGHT()))
            singleView.setDataDic(dataDic: dic as! Dictionary<String, String>)
            singleView.tag = index+10
            self.addSubview(singleView)
            if index == 0{
                singleView.setSelected(isSelected: true)
            }
            
            let tap = UITapGestureRecognizer.init(target: self, action: #selector(tapClick(tap:)))
            singleView.addGestureRecognizer(tap)
        }
        
        let line = UIView()
        line.frame = CGRect.init(x: 0, y: 0, width: MyConst.MAIN_SCREEN_WIDTH, height: 0.5)
        line.backgroundColor = UIColor.kUIColorFromRGB(hexString: "#D9D9D9")
        self.addSubview(line);
    }
    
    //仅支持更新图片文字，不支持跟新tabbar个数
    @objc func updateTabbar(_ tabbarList:NSArray) -> Void {
        for index in 0..<tabbarList.count {
            let dic = tabbarList[index]
            let singleView = self.viewWithTag(index+10) as! TabbarSingleView
            singleView.setDataDic(dataDic: dic as! Dictionary<String, String>)
            if index+10 == self.selectedIndex{
                singleView.setSelected(isSelected: true)
            }
        }
    }
    
    @objc func setCurrentIndex(index:Int) -> Void {
        handleTap(tag: index+10)
    }
    
    @objc func tapClick(tap:UITapGestureRecognizer) -> Void {
        if tap.view?.tag == selectedIndex {
            return
        }
        else
        {
            handleTap(tag: (tap.view?.tag)!)
        }
    }
    
    func handleTap(tag:Int) -> Void {
        let temView = self.viewWithTag(selectedIndex) as! TabbarSingleView
        temView.setSelected(isSelected: false)
        
        let currentView = self.viewWithTag(tag) as! TabbarSingleView
        currentView.setSelected(isSelected: true)
        
        self.callback(tag-10)
        selectedIndex = tag
    }
}

class TabbarSingleView: UIView {
    
    let tabbarImgWidth = CGFloat(22)
    var dataDic:[String:String]?
    var iv = UIImageView.init()
    var label = UILabel.init()
    @objc var unreadCountLabel = UILabel.init()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    func setDataDic(dataDic:Dictionary<String,String>) -> Void {
        self.dataDic = dataDic
        
        iv.frame = CGRect.init(x: (self.frame.size.width-CGFloat(tabbarImgWidth))/2, y: CGFloat(4), width: tabbarImgWidth, height: tabbarImgWidth)
        iv.image = UIImage.init(named: dataDic["icon"]!)
        iv.contentMode = .scaleAspectFit
        self.addSubview(iv)
        
        label.frame = CGRect.init(x: CGFloat(0), y: CGFloat(28), width: self.frame.size.width, height: CGFloat(20))
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 12)
        label.textColor = UIColor.kUIColorFromRGB(hexString: "#B4B9C3")
        label.text = dataDic["title"]!
        self.addSubview(label)
        
        unreadCountLabel.frame = CGRect.init(x: self.frame.size.width/2+4, y: 2, width: 20, height: 18)
        unreadCountLabel.backgroundColor = UIColor.red
        unreadCountLabel.textColor = UIColor.white;
        unreadCountLabel.textAlignment = .center;
        unreadCountLabel.font = UIFont.systemFont(ofSize: 12)
        unreadCountLabel.layer.cornerRadius = 9
        unreadCountLabel.clipsToBounds = true
        unreadCountLabel.isHidden = true
        self.addSubview(unreadCountLabel);
    }
    
    @objc func updateUnreadLabelState(badgeValue:String){
        if (badgeValue.count>0) {
            unreadCountLabel.text = badgeValue
            unreadCountLabel.isHidden = false
            
            var size = badgeValue.boundingRect(with: CGSize.init(width: 100, height: 20), options: [.usesLineFragmentOrigin], attributes: [kCTFontAttributeName as NSAttributedString.Key : unreadCountLabel.font], context: nil).size
            size.width+=4
            if size.width<18{size.width = 18}
            var rect = unreadCountLabel.frame
            rect.size.width = size.width
            unreadCountLabel.frame = rect
        }
        else{
            unreadCountLabel.isHidden = true
        }
    }
    
    func setSelected(isSelected:Bool) -> Void {
        if isSelected {
            iv.image = UIImage.init(named: dataDic!["highlight_Icon"]!)
            label.textColor = UIColor.kUIColorFromRGB(hexString: "#0295FF")
        }
        else
        {
            iv.image = UIImage.init(named: dataDic!["icon"]!)
            label.textColor = UIColor.kUIColorFromRGB(hexString: "#B4B9C3")
        }
    }
}
