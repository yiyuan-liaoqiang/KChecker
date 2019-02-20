//
//  File.swift
//  KChecker
//
//  Created by LiaoQiang on 2019/1/28.
//  Copyright © 2019年 Liao Qiang. All rights reserved.
//

import Foundation
import UzysAssetsPickerController
import Photos

var optionsKey = "optionsKey"

extension UIViewController:UIImagePickerControllerDelegate,UINavigationControllerDelegate,UzysAssetsPickerControllerDelegate {
    
    var selectImageOptions: SelectImgOptions {
        set {
            if FileManager.default.fileExists(atPath: newValue.saveDirectory) == false {
                try? FileManager.default.createDirectory(atPath: newValue.saveDirectory, withIntermediateDirectories: true, attributes: nil)
            }
            objc_setAssociatedObject(self, &optionsKey, newValue, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN)
        }
        get {
            return objc_getAssociatedObject(self, &optionsKey) as! SelectImgOptions
        }
    }
    
    func selectImage(options:SelectImgOptions) {
        self.selectImageOptions = options
    }
    
    //拍照
    func handleCamaraCallback() {
        let picker = UIImagePickerController()
        if UIImagePickerController.isSourceTypeAvailable(UIImagePickerController.SourceType.camera) {
            picker.delegate = self
            picker.sourceType = .camera
            picker.allowsEditing = self.selectImageOptions.allowsEditing ?? false
        }
        else {
            ProgressHUD.showMessage("相机不可用")
            return
        }
        
        if self.selectImageOptions.allowsSelectVideo == true {
            picker.mediaTypes = ["kUTTypeImage","kUTTypeMovie"]
        }
        self.present(picker, animated: true, completion: nil)
    }
    
    //相册
    func handleAlbumCallback() {
        if self.selectImageOptions.maxNumberOfSelectionPhoto == 1 {
            //只选择一张图片可以用系统方法
            let picker = UIImagePickerController()
            if UIImagePickerController.isSourceTypeAvailable(UIImagePickerController.SourceType.savedPhotosAlbum) {
                picker.delegate = self
                picker.sourceType = UIImagePickerController.SourceType.savedPhotosAlbum
                picker.allowsEditing = self.selectImageOptions.allowsEditing ?? false
            }
            else {
                ProgressHUD.showMessage("相册不可用")
                return
            }
            if self.selectImageOptions.allowsSelectVideo == true {
                picker.mediaTypes = ["kUTTypeImage","kUTTypeMovie"]
            }
            self.present(picker, animated: true, completion: nil)
        }
        else {
            let uzyPicker = UzysAssetsPickerController()
            uzyPicker.delegate = self
            if self.selectImageOptions.allowsSelectVideo == true {
                uzyPicker.maximumNumberOfSelectionMedia = self.selectImageOptions.maxNumberOfSelectionPhoto ?? 1
            }
            else {
                uzyPicker.maximumNumberOfSelectionPhoto = self.selectImageOptions.maxNumberOfSelectionPhoto ?? 1
                uzyPicker.maximumNumberOfSelectionVideo = 0
            }
            self.present(uzyPicker, animated: true, completion: nil)
        }
    }
    
    //UIImagePickerControllerDelegate
    public func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        self.dismiss(animated: true, completion: nil)
        
        var filePath:String!
        if info[UIImagePickerController.InfoKey.mediaType] as? String == "public.movie" {
            let url = info[UIImagePickerController.InfoKey.mediaURL] as! URL
            let fileType = url.absoluteString.components(separatedBy: ".").last
            let fileName = String(format: "%@.%@", MyMD5.md5(url.absoluteString, uppercaseString: true),fileType ?? "")
            filePath = String(format: "%@/%@", self.selectImageOptions.saveDirectory,fileName)
            
            let fileData = try? Data(contentsOf: url)
            FileManager.default.createFile(atPath: filePath, contents: fileData, attributes: nil)
        }
        else {
            var img:UIImage!
            let fileName = String(format: "%@.png", MyMD5.md5(timeString(), uppercaseString: true))
            filePath = String(format: "%@/%@", self.selectImageOptions.saveDirectory,fileName)
            if self.selectImageOptions.allowsEditing == true {
                img = info[UIImagePickerController.InfoKey.editedImage] as? UIImage
            }
            else {
                img = info[UIImagePickerController.InfoKey.originalImage] as? UIImage
            }
            FileManager.default.createFile(atPath: filePath, contents: img.jpegData(compressionQuality: 1.0), attributes: nil)
        }
        self.sendbackValue(paths: [filePath])
    }
    
    //UzysAssetsPickerControllerDelegate
    public func uzysAssetsPickerController(_ picker: UzysAssetsPickerController!, didFinishPickingAssets assets: [Any]!) {
        print(assets)
    }
    
    func timeString() -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyyMMddHHmmssSSS"
        return String(format: "%@%d", formatter.string(from: Date()),arc4random()%100000)
    }
    
    //回调
    func sendbackValue(paths:Array<String>) {
        self.selectImageOptions.callback(self.selectImageOptions,paths)
    }
}

class SelectImgOptions: NSObject {
    var saveDirectory:String!                                           //图片保存在本地的路径
    var maxNumberOfSelectionPhoto:Int?                                  //最大图片数量
    var allowsEditing:Bool?                                             //是否允许编辑图片
    var allowsSelectVideo:Bool?                                         //是否允许选择视频
    var callback:((_ options:SelectImgOptions,_ imgs:Array<String>) -> ())!
    var tag:Int?
    
    override init() {
        super.init()
    }
}
