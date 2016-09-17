//
//  Common.swift
//  WEPageNavigation
//
//  Created by 姚凤 on 16/9/9.
//  Copyright © 2016年 姚凤. All rights reserved.
//

import Foundation
import UIKit

public let WE_SCREEN_WIDTH :Int = Int(UIScreen.main.bounds.size.width)
public let WE_SCREEN_HEIGHT :Int = Int(UIScreen.main.bounds.size.height)

struct NavigationParam {
    static let ONAV_BAR_BOTTOMLINE_HEIGHT : CGFloat = 2.0
    static let ODOT_COORDINATE : CGFloat = 0.0
    static let ONAVIGATION_BAR_HEIGHT : CGFloat = 44
    static let ONAV_TAB_BAR_HEIGHT : CGFloat = 40
    static let OSTATUS_BAR_HEIGHT : CGFloat = 20
}

struct DefaultSetting {
//    func colorWithRGBA(r: Float, g: Float, b:Float,a:Float )->(UIColor) {
//        return UIColor.init(colorLiteralRed: r, green: g, blue: b, alpha: a)
//    }
    
    static let NavTabbarColor = UIColor.init(colorLiteralRed: 240.0/255.0, green: 230.0/255.0, blue: 230.0/255.0, alpha: 1)
    static let DefaultRedColor = UIColor.init(colorLiteralRed: 226.0/255.0, green: 58.0/255.0, blue: 58.0/255.0, alpha: 1)
    
}
