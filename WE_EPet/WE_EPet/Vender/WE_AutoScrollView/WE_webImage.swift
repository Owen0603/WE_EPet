//
//  WE_webImage.swift
//  WE_EPet
//
//  Created by 姚凤 on 16/9/16.
//  Copyright © 2016年 姚凤. All rights reserved.
//

import Foundation
import UIKit

let k_maxDiskCacheTime:TimeInterval = 7*24*3600
var k_imageCacheKey = "we_imageCacheKey"

extension UIImageView{
    public func we_setImageWithUrl(urlString: String?, placeHolder: UIImage){
        let imageCache = NSCache<AnyObject,AnyObject>()
        objc_setAssociatedObject(self, &k_imageCacheKey, imageCache, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        
        let cachePath = NSSearchPathForDirectoriesInDomains(.libraryDirectory, .userDomainMask, true).last! + "/WE_AutoScrollViewDiskCache"
        self.diskCacheFile(path: cachePath)
        self.image = placeHolder
        if urlString == nil {
            return
        }
        var defaultPath = cachePath + "/" + String(describing: urlString?.hash)
        if (urlString?.hasPrefix("file://"))! {
            defaultPath = urlString!
        }
        
        let cache = objc_getAssociatedObject(self, k_imageCacheKey) as? NSCache<AnyObject, AnyObject>
        var data = cache?.object(forKey: defaultPath as AnyObject)
        if data != nil {
            self.image = UIImage(data: data as! Data)
        }else{
            if (urlString?.hasPrefix("file://"))! {
                let url : NSURL = NSURL(string: urlString!)!
                do {
                    try data = Data(contentsOf: url as URL) as AnyObject?
                } catch  {
                    print("转换错误")
                }
                if data != nil {
                    cache?.setObject(data!, forKey: cachePath as AnyObject)
                    self.image = UIImage(data: data as! Data)
                }
            }
            else{
                let exist = FileManager.default.fileExists(atPath: cachePath)
                if exist {
                    var attributes:Dictionary<FileAttributeKey,Any>?
                    do{
                        try attributes=FileManager.default.attributesOfItem(atPath: cachePath)
                    }catch{
                       print("文件错误")
                    }
                    let createDate:Date?=attributes?[FileAttributeKey.creationDate] as! Date?
                    let interval:TimeInterval?=Date.init().timeIntervalSince(createDate!)
                    let expired = interval! > k_maxDiskCacheTime
                    if expired{
                        self.downLoadDataAndRefreshImageView(urlString: urlString!, cachePath: cachePath)
                    }else{
                        let url: NSURL = NSURL (string: urlString!)!
                        data = NSData(contentsOf: url as URL)
                        if data != nil {
                            cache?.setObject(data!, forKey: cachePath as AnyObject)
                            self.image = UIImage(data: data as! Data)
                        }else{
                            let url:NSURL=NSURL.init(string: urlString!)!
                            do{
                                try data=Data.init(contentsOf: url as URL) as AnyObject?
                            }catch{
                                
                            }
                            //donwload agin
                            self.downLoadDataAndRefreshImageView(urlString: urlString!, cachePath: cachePath)
                        }
                    }
                    
                    
                }else{
                    self.downLoadDataAndRefreshImageView(urlString: urlString!, cachePath: cachePath)
                }
            }
        }
        
        
        
        
        
    }
    
    private func downLoadDataAndRefreshImageView(urlString: String, cachePath: String){
        do {
            try FileManager.default.removeItem(atPath: cachePath)
        } catch{
            print("文件存储移除错误")
        }
        
        let url = URL(string: urlString)
        let session=URLSession.shared.dataTask(with: url!, completionHandler: { (resultData, res, err) in
            let fileUrl=URL.init(fileURLWithPath: cachePath)
            do{
                try resultData?.write(to: fileUrl, options:.atomic)
            }catch{
                
            }
            let imageCache=objc_getAssociatedObject(self, &k_imageCacheKey) as! NSCache<AnyObject, AnyObject>
            imageCache.setObject(resultData as AnyObject, forKey: cachePath as AnyObject)
            if resultData != nil{
                self.image=UIImage(data: resultData!)
            }
        })
        session.resume()
    }
    
    private func diskCacheFile(path: String){
        if !FileManager.default.fileExists(atPath: path) {
            do {
                try FileManager.default.createDirectory(atPath: path, withIntermediateDirectories: true, attributes: nil)
            } catch  {
                print("路径创建错误")
            }
        }
    }
    
    private func setMemeryCache() ->NSCache<AnyObject, AnyObject>{
        return objc_getAssociatedObject(self, &k_imageCacheKey) as! NSCache<AnyObject, AnyObject>
    }
}
