//
//  WENavTabBarController.swift
//  WEPageNavigation
//
//  Created by 姚凤 on 16/9/9.
//  Copyright © 2016年 姚凤. All rights reserved.
//

import UIKit

class WENavTabBarController: UIViewController {
    
    var subViewControllers : [UIViewController]?
    var navTabBarColor : UIColor?{
        willSet{
            
            self.navTabBarColor = newValue != nil ? newValue : DefaultSetting.NavTabbarColor
        }
    }
    var navTabBarLineColor : UIColor?
    var itemSelectColor :UIColor?
    var currentIndex :Int = 0 {
        willSet{
            self.currentIndex = newValue
            self.navTabBar.currentItemIndex = newValue
            self.mainView.setContentOffset(CGPoint.init(x: newValue * WE_SCREEN_WIDTH, y: Int(NavigationParam.ODOT_COORDINATE)), animated: self.scrollAnimation)
            let subViewCtrl : UIViewController = self.subViewControllers![newValue]
            subViewCtrl.viewWillAppear(true)
        }
    }
    
    var scrollAnimation : Bool = false
    var enablePanGesture : Bool = true {
        willSet{
            self.enablePanGesture = newValue
            self.mainView.isScrollEnabled = newValue
        }
    }
    var mainViewBounces : Bool = false
    private var titls : NSMutableArray? = {
        let tit = NSMutableArray()
        return tit
    }()
    
    lazy var navTabBar : WENaviTabBar = {
        let navtab = WENaviTabBar.init(frame: CGRect(x: NavigationParam.ODOT_COORDINATE, y: NavigationParam.ODOT_COORDINATE, width: CGFloat(WE_SCREEN_WIDTH), height: CGFloat(WE_SCREEN_HEIGHT)))
        navtab.delegate = self
        navtab.backgroundColor = self.navTabBarColor
        navtab.lineColor =  self.navTabBarLineColor
        navtab.buttonSelectColor = self.itemSelectColor
        navtab.itemTitles = self.titls as! [String]
        return navtab
    }()
   
    lazy  var mainView : UIScrollView = {
        let main = UIScrollView.init(frame: CGRect(x: Int(NavigationParam.ODOT_COORDINATE), y: Int(NavigationParam.ODOT_COORDINATE+NavigationParam.ONAV_TAB_BAR_HEIGHT), width: WE_SCREEN_WIDTH, height: WE_SCREEN_HEIGHT - Int(NavigationParam.ODOT_COORDINATE) - Int(NavigationParam.ONAV_TAB_BAR_HEIGHT)-64))
        main.delegate = self
        main.isPagingEnabled = true
        main.bounces = self.mainViewBounces
        main.showsHorizontalScrollIndicator = false
        main.isScrollEnabled = true
        main.contentSize = CGSize(width: WE_SCREEN_WIDTH * (self.subViewControllers?.count)!, height: Int(NavigationParam.ODOT_COORDINATE))
        return main
    }()
    
    func addToParentController(superViewController : UIViewController) {
        if superViewController.responds(to: #selector(getter: edgesForExtendedLayout)){
            superViewController.edgesForExtendedLayout = UIRectEdge.init(rawValue: 0)
        }
        superViewController.addChildViewController(self)
        superViewController.view.addSubview(self.view)
    }
    
    

    override func viewDidLoad() {
        super.viewDidLoad()

        self.initConfig()
        self.vieConfig()
    }

    private func initConfig(){
        self.currentIndex = self.currentIndex == 0 ? 0 : self.currentIndex
        self.navTabBarColor = self.navTabBarColor != nil ? self.navTabBarColor : DefaultSetting.NavTabbarColor
         self.itemSelectColor = self.itemSelectColor != nil ? self.itemSelectColor : DefaultSetting.DefaultRedColor
        
        for viewController in self.subViewControllers! {
            self.titls?.add(viewController.title)
        }
        self.navTabBar.itemTitles = (self.titls as? [String])!
    }
    
    private func viewInit() {
        self.navTabBar.updateData()
        self.view.addSubview(self.mainView)
        self.view.addSubview(self.navTabBar)
    }
    
    private func vieConfig(){
        self.viewInit()
        
        for (index , value) in (self.subViewControllers?.enumerated())! {
            let viewController = value
            viewController.view.frame = CGRect(x: index * WE_SCREEN_WIDTH, y: Int(NavigationParam.ODOT_COORDINATE), width: WE_SCREEN_WIDTH, height: Int((self.mainView.frame.size.height)))
            self.mainView.addSubview(viewController.view)
            self.addChildViewController(viewController)
        }
    }
}

extension WENavTabBarController : UIScrollViewDelegate{
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        self.currentIndex = Int(scrollView.contentOffset.x) / WE_SCREEN_WIDTH
        self.navTabBar.currentItemIndex = self.currentIndex
    }
}

extension WENavTabBarController : WENavTabBarDelegate{
    func itemDidSelected(index: Int) {
        self.mainView.setContentOffset(CGPoint.init(x: index * WE_SCREEN_WIDTH, y: Int(NavigationParam.ODOT_COORDINATE)), animated: self.scrollAnimation)
    }
}
