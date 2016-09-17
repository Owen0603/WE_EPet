//
//  AppDelegateAction.swift
//  WE_EPet
//
//  Created by 姚凤 on 16/9/17.
//  Copyright © 2016年 姚凤. All rights reserved.
//

import Foundation
import UIKit

extension AppDelegate{
    func createRootAction() {
        let home : RootNavViewController = RootNavViewController(rootViewController: HomeIndexViewController())
        let category : RootNavViewController = RootNavViewController(rootViewController: CategoryViewController())
        let shopping : RootNavViewController = RootNavViewController(rootViewController: ShoppingCarViewController())
        let mine : RootNavViewController = RootNavViewController(rootViewController: MineViewController())
        let rootView = RootTabBarViewController(viewControllers: [home,category,UIViewController(),shopping,mine], type: .Dog)
        self.window?.rootViewController = rootView
        self.window?.backgroundColor = UIColor.white
        self.window?.makeKeyAndVisible()
    }
}
