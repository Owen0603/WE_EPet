//
//  AutoScrollModel.swift
//  WE_EPet
//
//  Created by 姚凤 on 16/10/5.
//  Copyright © 2016年 姚凤. All rights reserved.
//

import UIKit

class AutoScrollModel: NSObject {
    var imageList : [NSDictionary]?   //轮播图
    var menuList : [NSDictionary]?    //特卖按钮
    var worthbuyList : [NSDictionary]? //物品列表
    var hotComments : [NSDictionary]?   //口碑评价
 
    
    
    

    static func modelWithDict(dict: [String : AnyObject]) -> AutoScrollModel {
        let model = AutoScrollModel()
        model.menuList = dict["menus"] as! [NSDictionary]?
        
    
        let subDict = dict["advs"] as AnyObject
        if let resultDict :Dictionary = subDict as? Dictionary<String, AnyObject>{
             model.imageList = resultDict["advarr_four"] as! [NSDictionary]?
        }
        
        model.worthbuyList = dict["worthbuy"] as! [NSDictionary]?
        
        model.hotComments = dict["hotcomments"] as! [NSDictionary]?
        return model
    }
}
