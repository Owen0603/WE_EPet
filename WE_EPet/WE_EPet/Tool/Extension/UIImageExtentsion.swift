//
//  UIImageExtentsion.swift
//  WE_EPet
//
//  Created by 姚凤 on 16/10/8.
//  Copyright © 2016年 姚凤. All rights reserved.
//

import UIKit

extension UIImage{
    
    static func getImageWithColor(color: UIColor) -> UIImage {
        let rect = CGRect(x: 0.0, y: 0.0, width: 1.0, height: 1.0)
        UIGraphicsBeginImageContext(rect.size)
        let context = UIGraphicsGetCurrentContext()
        context!.setFillColor(color.cgColor)
        context!.fill(rect);
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return image!
    }
    
}
