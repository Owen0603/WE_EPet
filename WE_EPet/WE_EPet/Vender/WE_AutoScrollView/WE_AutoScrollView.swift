//
//  WE_AutoScrollView.swift
//  WE_EPet
//
//  Created by 姚凤 on 16/9/16.
//  Copyright © 2016年 姚凤. All rights reserved.
//

import UIKit
typealias WE_ImageClickBlock = (Int) ->Void
typealias WE_ImageScrolledBlock = (Int) ->Void

let scrollInterval = 3.0
let we_cachePath = NSSearchPathForDirectoriesInDomains(.libraryDirectory, .userDomainMask, true).last! + "/WE_AutoScrollViewDiskCache"

class WE_AutoScrollView: UIView,UIScrollViewDelegate {
   
    let we_imageCache = NSCache<AnyObject, AnyObject>()
    let we_maxCacehCycle = TimeInterval(7*24*3600)
    private var didSelectedImageAction : WE_ImageClickBlock?
    private var imageDidScrolledBlock : WE_ImageScrolledBlock?
    private var imageUrlArray : Array<String>?{
        didSet{
            self.createScrollView()
        }
    }
    
    lazy var scrollView: UIScrollView = {
       let scrol  = UIScrollView.init(frame: self.bounds)
        scrol.delegate = self
        scrol.isPagingEnabled = true
        scrol.showsHorizontalScrollIndicator = false
        self.addSubview(scrol)
        return scrol
    }()
    private var timer: Timer!
    private var pageControl : UIPageControl!
    var  placeHolderImage : UIImage?
    
    
    private func diskCacheFile(path: String){
        if !FileManager.default.fileExists(atPath: path) {
            do {
                try FileManager.default.createDirectory(atPath: path, withIntermediateDirectories: true, attributes: nil)
            } catch  {
                print("路径创建错误")
            }
        }
    }
    
    //MARK: web image
    convenience init(frame: CGRect, placceHolder placeHolderImage: UIImage?, remoteImageUrls images: Array<String>?, selectImageAction imageDidSelectAction: @escaping WE_ImageClickBlock) {
        
        self.init(frame:frame)
        self.placeHolderImage = placeHolderImage
        self.didSelectedImageAction = imageDidSelectAction
        self.imageUrlArray = images
        self.createScrollView()
    }
    
    //MARK: loacl image
    convenience init(frame: CGRect, placceHolder placeHolderImage: UIImage?, localImageNames images: Array<String>?, selectImageAction imageDidSelectAction: @escaping WE_ImageClickBlock) {
        
        self.init(frame: frame)
        self.placeHolderImage = placeHolderImage
        var fileUrls : Array<String> = []
        for name in images!{
            
            var path:String?
            if name.hasSuffix("jpg")||name.hasSuffix("png"){
                path=Bundle.main.path(forResource: name, ofType: nil)
            }
            else{
                path=Bundle.main.path(forResource: name, ofType: "png")
            }
            if path==nil{
                path=""
            }
            path=path?.addingPercentEncoding(withAllowedCharacters: .urlPathAllowed)
            let fullPath=String.init(format: "file://%@", path!)
            fileUrls.append(fullPath)
        }
        self.didSelectedImageAction = imageDidSelectAction
        self.imageUrlArray = fileUrls
        self.createScrollView()
    }
    
    private func createScrollView(){
        
        var  counnt: Int = 0
        if self.imageUrlArray != nil {
            counnt = (self.imageUrlArray?.count)!
        }
        let width :CGFloat = CGFloat(counnt + 1) * self.bounds.size.width
        let height : CGFloat = self.bounds.size.height
        self.scrollView.contentSize = CGSize(width: width, height: height)
        if self.timer != nil {
            self.timer = nil
        }
        
        self.timer = Timer.scheduledTimer(withTimeInterval: scrollInterval, repeats: true, block: { (time) in
            if self.imageUrlArray?.count == 0{
                return
            }
            var index=Int((self.scrollView.contentOffset.x)/self.bounds.size.width);
            index+=1
            if index==self.imageUrlArray?.count{
                index=0
            }
            if self.imageDidScrolledBlock != nil{
                
                self.imageDidScrolledBlock!(Int(index))
            }
            self.pageControl.currentPage=index
            UIView.animate(withDuration: 0.2, animations: { 
                self.scrollView.contentOffset = CGPoint(x: self.bounds.size.width * CGFloat(index), y: 0)
            })
        })
        
        if counnt != 0 {
            for i in 0...counnt {
                let xpos=CGFloat(i)*self.bounds.size.width
                let frm=CGRect.init(x: xpos, y: 0, width: self.bounds.size.width, height: self.bounds.size.height)
                let imv=UIImageView.init(frame: frm)
                imv.image=self.placeHolderImage
                imv.isUserInteractionEnabled=true
                let tap:UITapGestureRecognizer=UITapGestureRecognizer.init(target: self, action:#selector(WE_AutoScrollView.tapImage))
                imv.addGestureRecognizer(tap)
                self.scrollView.addSubview(imv)
                var urlString:String?
                if i<counnt{
                    
                    urlString=self.imageUrlArray?[i]
                }else{
                    urlString=imageUrlArray?.first
                }
                imv.we_setImageWithUrl(urlString: urlString, placeHolder: self.placeHolderImage!)
            }
        }
        
        if self.pageControl != nil{
            self.pageControl.removeFromSuperview()
            self.pageControl=nil
        }
        let pageControlFrame=CGRect.init(x: 0, y: 0, width: 200, height: 17)
        self.pageControl=UIPageControl.init(frame: pageControlFrame)
        self.pageControl.center=CGPoint.init(x: self.bounds.size.width/2, y: self.bounds.size.height-10)
        self.pageControl.numberOfPages=counnt
        self.pageControl.pageIndicatorTintColor=UIColor.init(red: 225.0/255.0, green: 225.0/255.0, blue: 225.0/255.0, alpha: 1.0)
        self.pageControl.currentPageIndicatorTintColor=UIColor.orange
        self.addSubview(self.pageControl)
        
    }

    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        
        var index=Int((self.scrollView.contentOffset.x)/self.bounds.size.width);
        if index==self.imageUrlArray?.count{
            index=0;
        }
        if self.imageDidScrolledBlock != nil{
            
            self.imageDidScrolledBlock?(index)
        }
        self.pageControl.currentPage=index
        self.scrollView.contentOffset=CGPoint.init(x: self.bounds.size.width*CGFloat(index), y: 0)
    }
    
    func tapImage(){
        
        if self.didSelectedImageAction != nil{
            
            self.didSelectedImageAction?(Int(self.pageControl.currentPage));
        }
    }
}

extension WE_AutoScrollView{
    
    //we_setImageWithUrlString(imageView:UIImageView?,urlString:String?,placeHolder:UIImage?)
    //async image loading like `SDWebImage` with cache in memery an disk
    func we_setImageWithUrlString(imageView:UIImageView?,urlString:String?,placeHolder:UIImage?){
        
        if imageView==nil{
            return
        }
        imageView?.image=placeHolder
        if urlString==nil{
            return
        }
        var cachePath = we_cachePath+"/"+String(describing: urlString?.hash)
        if (urlString?.hasPrefix("file://"))!{//local path
            cachePath=urlString!
        }
        //check the memery chache exist or not(both local and web images)
        var data=we_imageCache.object(forKey: cachePath as AnyObject)
        if (data != nil) {//exist in memery cache
            
            imageView?.image=UIImage(data: data as! Data)

        }else{
            //local images
            if (urlString?.hasPrefix("file://"))!{
                
                let url:NSURL=NSURL.init(string: urlString!)!
                do{
                    try data=Data.init(contentsOf: url as URL) as AnyObject?
                }catch{
                    
                }
                //if local image exist
                if data != nil{
                    
                    we_imageCache.setObject(data as AnyObject, forKey: cachePath as AnyObject)
                    imageView?.image=UIImage(data: data as! Data)
                }
            }
                //web images
            else{
                //check if exist in disk
                let exist=FileManager.default.fileExists(atPath: cachePath)
                if exist {
                    //check if expired
                    var attributes:Dictionary<FileAttributeKey,Any>?
                    do{
                        try attributes=FileManager.default.attributesOfItem(atPath: cachePath)
                    }catch{
                        
                    }
                    let createDate:Date?=attributes?[FileAttributeKey.creationDate] as! Date?
                    let interval:TimeInterval?=Date.init().timeIntervalSince(createDate!)
                    let expired=(interval! > we_maxCacehCycle)
                    if expired{
                        //download image
                        self.donwloadDataAndRefreshImageView(imageView: imageView, urlString: urlString, cachePath: cachePath)
                    }
                    else{
                        //load from disk
                        let url:NSURL=NSURL.init(string: urlString!)!
                        do{
                            try data=Data.init(contentsOf: url as URL) as AnyObject?
                        }catch{
                            
                        }
                        if data != nil{//if has data
                            //cached in memery
                            we_imageCache.setObject(data as AnyObject, forKey: cachePath as AnyObject)
                            DispatchQueue.main.async{
                                imageView?.image=UIImage(data: data as! Data)
                            }
                        }
                        else{
                            //remove item from disk
                            let url:NSURL=NSURL.init(string: urlString!)!
                            do{
                                try data=Data.init(contentsOf: url as URL) as AnyObject?
                            }catch{
                                
                            }
                            //donwload agin
                            self.donwloadDataAndRefreshImageView(imageView: imageView, urlString: urlString, cachePath: cachePath)
                        }
                    }
                }
                    //not exist in disk
                else{
                    //download image
                    self.donwloadDataAndRefreshImageView(imageView: imageView, urlString: urlString, cachePath: cachePath)
                }
            }
        }
    }
    //async download image
    private func donwloadDataAndRefreshImageView(imageView:UIImageView?,urlString:String?,cachePath:String!){
        
        do{
            try FileManager.default.removeItem(atPath: cachePath)
        }catch{
            print("错误")
        }
        //download data
        let url=URL.init(string: urlString!)
        let session=URLSession.shared.dataTask(with: url!, completionHandler: { (resultData, res, err) in
            let fileUrl=URL.init(fileURLWithPath: cachePath)
            do{
                try resultData?.write(to: fileUrl, options:.atomic)
            }catch{
                print("写文件错误")
            }
            self.we_imageCache.setObject(resultData as AnyObject, forKey: cachePath as AnyObject)
            if resultData != nil{
                DispatchQueue.main.async{
                    imageView?.image=UIImage(data: resultData!)
                }
            }
        })
        session.resume()
    }
}
