//
//  AutoScrollTableViewCell.swift
//  WE_EPet
//
//  Created by 姚凤 on 16/10/5.
//  Copyright © 2016年 姚凤. All rights reserved.
//

import UIKit

typealias CellClickIndex = (Int) ->Void

class AutoScrollTableViewCell: UITableViewCell {
    
    lazy var scrollImageView :WE_AutoScrollView = {
        
       let imageView = WE_AutoScrollView.init(frame: CGRect.init(x: 0, y: 0, width: SCREEN_WIDTH, height: self.bounds.height-40), placceHolder: nil, remoteImageUrls: [], selectImageAction: { (index) in
            if let _ = self.clickIndex{
                self.clickIndex!(index)
            }
        });
        imageView.tag = 100
        return imageView
    }()
    var scrollMain : UIScrollView?
    var clickIndex :CellClickIndex?
    
    
    
    
    var model : AutoScrollModel?
    
    
    func configData(model:AutoScrollModel) {
        
        let view = self.viewWithTag(100)
        view?.removeFromSuperview()
        
        //轮播图
        self.addSubview(self.imageView!)
        
        let array : Array = model.menuList!
        for index in 0...array.count {
            let dict = array[index] as NSDictionary
            let button = UIButton.init(frame: CGRect(x: index*40, y: 0, width: 40, height: 40));
        }
        
    }
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        //按钮
        scrollMain = UIScrollView.init(frame: CGRect(x: 0, y: self.bounds.height-40, width: SCREEN_WIDTH, height: 40))
        self.addSubview(scrollMain!)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
