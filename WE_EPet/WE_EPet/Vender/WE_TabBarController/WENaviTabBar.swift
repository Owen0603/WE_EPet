//
//  WENaviTabBar.swift
//  WEPageNavigation
//
//  Created by 姚凤 on 16/9/9.
//  Copyright © 2016年 姚凤. All rights reserved.
//

import UIKit

@objc protocol WENavTabBarDelegate {
    @objc optional func itemDidSelected(index: Int)
}

class WENaviTabBar: UIView {

    var delegate : WENavTabBarDelegate?
    var currentItemIndex : Int = 0 {
        willSet{
            self.currentItemIndex = newValue
            if self.items.count>0{
                let button : UIButton = self.items[newValue] as! UIButton
                self.selectButton?.isSelected = false
                button.isSelected = true
                self.selectButton = button
                if button.frame.origin.x + button.frame.size.width > CGFloat(WE_SCREEN_WIDTH) {
                    var offsetX = button.frame.origin.x + button.frame.size.width - CGFloat(WE_SCREEN_WIDTH)
                    if newValue < self.itemTitles.count-1 {
                        offsetX = offsetX + 40
                    }
                    self.navgationTabBar?.setContentOffset(CGPoint.init(x: offsetX, y: NavigationParam.ODOT_COORDINATE), animated: true)
                    
                }else{
                    self.navgationTabBar?.setContentOffset(CGPoint.init(x: NavigationParam.ODOT_COORDINATE, y: NavigationParam.ODOT_COORDINATE), animated: true)
                }
                
                UIView.animate(withDuration: 0.3) {
                    self.line?.frame = CGRect(x: button.frame.origin.x, y: (self.line?.frame.origin.y)!, width: CGFloat(self.itemsWidth[newValue]), height: (self.line?.frame.size.height)!)
                }
            }
        }
    }
    var itemTitles = [String]()
    var lineColor : UIColor?
    var buttonSelectColor : UIColor?
    
    private var navgationTabBar:UIScrollView?
    private var line :UIView?
    private lazy var items : NSMutableArray = {
      var item = NSMutableArray()
        return item;
    }()
    private var itemsWidth = [Float]()
    private var selectButton : UIButton?
    
    
    
    
    //MARK: 外部方法
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = UIColor.white
        self.viewConfig()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func viewConfig() {
        self.navgationTabBar = UIScrollView.init(frame: CGRect.init(x: NavigationParam.ODOT_COORDINATE, y: NavigationParam.ODOT_COORDINATE, width: CGFloat(WE_SCREEN_WIDTH), height: NavigationParam.ONAV_TAB_BAR_HEIGHT))
        self.navgationTabBar?.showsHorizontalScrollIndicator = false
        self.navgationTabBar?.backgroundColor = UIColor.white
        self.addSubview(self.navgationTabBar!)
    }
    
    func showLineWithButton(x: CGFloat, width: CGFloat) {
        self.line = UIView.init(frame: CGRect.init(x: x, y: NavigationParam.ONAV_TAB_BAR_HEIGHT-NavigationParam.ONAV_BAR_BOTTOMLINE_HEIGHT, width: width-4.0, height: NavigationParam.ONAV_BAR_BOTTOMLINE_HEIGHT))
        self.line?.backgroundColor = self.lineColor != nil ? self.lineColor : DefaultSetting.DefaultRedColor
        self.navgationTabBar?.addSubview(self.line!)
    }
    
    func contentWithAndAddNavTabBarItemsWithButtons(widths: NSArray)->CGFloat {
        var buttonX = NavigationParam.ODOT_COORDINATE
        var currentX = NavigationParam.ODOT_COORDINATE
        for index in 0 ..< self.itemTitles.count{
            let button = UIButton.init(type: .custom)
            button.backgroundColor = UIColor.white
            button.frame = CGRect.init(x: buttonX, y: NavigationParam.ODOT_COORDINATE, width: CGFloat(widths[index] as! NSNumber), height: NavigationParam.ONAV_TAB_BAR_HEIGHT)
            button.titleLabel?.font = UIFont.systemFont(ofSize: 15)
            button.setTitle(self.itemTitles[index], for: .normal)
            button.setTitleColor(UIColor.black, for: .normal)
            button.setTitleColor(DefaultSetting.DefaultRedColor, for: .selected)
            button.addTarget(self, action: #selector(WENaviTabBar.itemPressed(button:)), for: .touchUpInside)
            self.navgationTabBar?.addSubview(button)
            if index==self.currentItemIndex {
                button.isSelected = true
                self.selectButton = button
            }
            
            self.items.add(button)
            buttonX += CGFloat(widths[index] as! NSNumber)
            if index < self.currentItemIndex {
                currentX += CGFloat(widths[index] as! NSNumber)
            }
        }
        
        //下划线
        let lineView = UIView.init(frame: CGRect.init(x: -200, y: NavigationParam.ONAV_TAB_BAR_HEIGHT-NavigationParam.ONAV_BAR_BOTTOMLINE_HEIGHT/2, width: buttonX+400, height: 1/UIScreen.main.scale))
        lineView.backgroundColor = UIColor.black
        self.navgationTabBar?.addSubview(lineView)
        
        //移动下滑先
        self.showLineWithButton(x: currentX, width: CGFloat(widths[0] as! NSNumber))
        
        return buttonX
    }
    
    func itemPressed(button: UIButton) {
        let index = self.items.indexOfObjectIdentical(to: button)
        self.delegate?.itemDidSelected!(index: index)
    }
    
    func getButtonWidthWithTitles(titles:NSArray) -> NSArray {
        let  widths = NSMutableArray()
        var  totalWidth = 0
        for title in titles {
            let subTitle: String = title as! String
            let attributes = NSDictionary(object: UIFont.systemFont(ofSize: UIFont.systemFontSize), forKey: NSFontAttributeName as NSCopying)
            let size : CGSize = subTitle.size(attributes: attributes as? [String : Any])
            let width = size.width + CGFloat(40)
            widths.add(width)
            
            totalWidth += Int(width)
        }
        if totalWidth < WE_SCREEN_WIDTH {
            widths.removeAllObjects()
            for _ in 0  ..< titles.count{
                widths.add(WE_SCREEN_WIDTH/titles.count)
            }
        }
        return widths
    }
    
    func updateData() {
        self.itemsWidth = self.getButtonWidthWithTitles(titles: self.itemTitles as NSArray) as! [Float]
        if self.itemsWidth.count>0 {
            let contentWidth = self.contentWithAndAddNavTabBarItemsWithButtons(widths: self.itemsWidth as NSArray)
            self.navgationTabBar?.contentSize = CGSize(width: contentWidth, height: NavigationParam.ODOT_COORDINATE)
        }
    }
}
