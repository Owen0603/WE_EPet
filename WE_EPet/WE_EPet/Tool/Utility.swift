//
//  Utility.swift
//  WE_EPet
//
//  Created by 姚凤 on 16/9/17.
//  Copyright © 2016年 姚凤. All rights reserved.
//

import Foundation
import UIKit


//MARK: 尺寸
let SCREEN_HEIGHT = UIScreen.main.bounds.height
let SCREEN_WIDTH = UIScreen.main.bounds.width


//MARK: 颜色
func RGBA(r: Float, g: Float, b: Float, a:Float) ->UIColor{
    return UIColor.init(colorLiteralRed: r, green: g, blue: b, alpha: a)
}

func RGB(r: Float, g: Float, b: Float) ->UIColor{
    return RGBA(r: r, g: g, b: b, a: 1.0)
}

let DefaultGreenColor = RGB(r: 50.0/255.0, g: 193.0/255.0, b: 108.0/255.0)

//MARK: 字体
let DEFAULT_TITLE_FONT = UIFont.systemFont(ofSize: 15)
let DEFAULT_SUBTITLE_FONT = UIFont.systemFont(ofSize: 13)



