//
//  AutoScrollTableViewCell.swift
//  WE_EPet
//
//  Created by 姚凤 on 16/10/5.
//  Copyright © 2016年 姚凤. All rights reserved.
//

import UIKit
import YYKit

private var KeyWord = 0
private let ButtonWidth = 60
private let ButtonHeight = 60

class AutoScrollTableViewCell: UITableViewCell {
    
    var scrollMain : UIScrollView?
    
    var model : AutoScrollModel?
    
    
    func configData(model:AutoScrollModel) {
        self.model = model
        
        let view = self.viewWithTag(100)
        view?.removeFromSuperview()
        
        //轮播图
        var imageListArray = [NSString]()
        for dict in model.imageList! {
            imageListArray.append(dict["src"] as! NSString)
        }
        
        let scrollImage = WE_AutoScrollView.init(frame: CGRect.init(x: 0, y: 0, width: SCREEN_WIDTH, height: 150), placceHolder: UIImage(named:"pay_done"), remoteImageUrls: imageListArray as Array<String>?, selectImageAction: { (index) in
            
            let dict : NSDictionary = (self.model?.imageList![index])!
            let subDict = dict["param"] as! NSDictionary
            let string = subDict["param"] as! String
            let webView = CommonWebViewController()
            webView.webUrl = NSURL(string: string) as URL?
            webView.navTitle = subDict["mode"] as! String
            webView.hidesBottomBarWhenPushed = true
            RootViewController.currentViewController().navigationController?.pushViewController(webView, animated: true)
            
        });
        scrollImage.backgroundColor = UIColor.blue
        scrollImage.tag = 100
        self.addSubview(scrollImage)
        
        
        //按钮
        let array : Array = model.menuList!
        var width = 0
        for index in 0..<array.count {
            width += ButtonWidth
            
            let dict = array[index] as NSDictionary
            let button = UIButton.init(frame: CGRect(x: index*ButtonWidth, y: 0, width: ButtonWidth, height: ButtonHeight));
            button.setImageWith(NSURL(string: dict["hover_image"] as! String) as URL?, for: .normal, placeholder: UIImage(named: "pay_done"))
            objc_setAssociatedObject(button, &KeyWord, dict, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
            button.addTarget(self, action: #selector(AutoScrollTableViewCell.buttonClick(button:)), for: .touchUpInside)
            self.scrollMain?.addSubview(button)
        }
        self.scrollMain?.contentSize = CGSize(width: width, height: 0)
        self.scrollMain?.showsHorizontalScrollIndicator = false
    }
    
    func buttonClick(button:UIButton) {
        let dict : NSDictionary = objc_getAssociatedObject(button, &KeyWord) as! NSDictionary
        let webView = CommonWebViewController()
        webView.webUrl = NSURL(string: dict["wap_url"] as! String) as URL?
        webView.hidesBottomBarWhenPushed = true
        RootViewController.currentViewController().navigationController?.pushViewController(webView, animated: true)
    }
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.selectionStyle = .none
        //按钮
        scrollMain = UIScrollView.init(frame: CGRect(x: 0, y: 150, width: Int(SCREEN_WIDTH), height: ButtonHeight))
        self.addSubview(scrollMain!)
    }
    
//    func htmlTitleName(index: NSInteger) -> String {
//        switch index {
//        case 0:
//            return "全球特卖"
//        case 1:
//            return "全球特卖"
//        case 0:
//            return "全球特卖"
//        case 0:
//            return "全球特卖"
//        case 0:
//            return "全球特卖"
//        case 0:
//            return "全球特卖"
//        case 0:
//            return "全球特卖"
//        default:
//            <#code#>
//        }
//    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
