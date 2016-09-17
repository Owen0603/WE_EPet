//
//  RootTabBarViewController.swift
//  WE_EPet
//
//  Created by 姚凤 on 16/9/17.
//  Copyright © 2016年 姚凤. All rights reserved.
//

import UIKit

enum ImageType {
    case Dog
    case Cat
}

let normalImageArray = ["tab_home_m","tab_type_m","","tab_cart_m","tab_epet_m"]
let dogImageArray = ["cat_tab_1","cat_tab_2","","cat_tab_4","cat_tab_5"]
let catImageArray = ["dog_tab_1","dog_tab_2","","dog_tab_4","dog_tab_5"]
let titleNameArray = ["首页","分类","","购物车","我的E宠"]

class RootTabBarViewController: UITabBarController {
    
    var type : ImageType?{
        didSet{
            if type == .Dog {
                self.selectImageArray = dogImageArray
            }else{
                self.selectImageArray = catImageArray
            }
            self.changeTabBarImage()
        }
    }
    
    var selectImageArray : Array = dogImageArray  //选择数组
    var middleImage : String = "dog_tab_head"     //最中间的图片
    var currentItem : UITabBarItem?
    
    
    lazy var middleImageView : UIImageView = {
        let imageView = UIImageView.init(frame: CGRect(x: SCREEN_WIDTH/5*2+6, y: 2.0, width: 50.0, height: 50.0))
        imageView.center = CGPoint(x: SCREEN_WIDTH/2, y: imageView.centerY-10)
        imageView.image = UIImage(named: self.middleImage)
        return imageView
    }()
    
    //selectIndex set方法
    override var selectedIndex: Int{
        willSet{
            if newValue == 2 {
                return
            }
        }
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tabBar.addSubview(self.middleImageView)
        
    }
    
    convenience init(viewControllers: Array<UIViewController>, type: ImageType) {
        self.init()
        assert(viewControllers.count==5, "tabBar count less")
        self.viewControllers = viewControllers
        self.type = type
        self.changeTabBarImage()
        self.selectedIndex = 0
    }
    
    func getImageFile(type: ImageType, name: String) -> String {
        let bundle = Bundle.main.bundlePath
        var path = "/Dog"
        if type == .Cat {
            path = "/Cat"
        }
        return bundle + path + name + ".png"
    }
    
    //改变tabBar按钮
    func changeTabBarImage() {
        for i in 0..<normalImageArray.count {
            let item : UITabBarItem = self.tabBar.items![i]
            item.title = titleNameArray[i]
            item.tag = i
            let normalImage = UIImage(named: normalImageArray[i]) as UIImage?
            let selectImage = UIImage(named: self.selectImageArray[i]) as UIImage?
            item.image = normalImage
            item.selectedImage = selectImage
        }
    }
}
