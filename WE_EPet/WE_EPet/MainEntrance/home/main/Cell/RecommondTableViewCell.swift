//
//  RecommondTableViewCell.swift
//  WE_EPet
//
//  Created by 姚凤 on 16/10/7.
//  Copyright © 2016年 姚凤. All rights reserved.
//

import UIKit

class RecommondTableViewCell: UITableViewCell {

    @IBOutlet weak var leftBigImageView: UIImageView!
    
    @IBOutlet weak var leftMoneyLabel: UILabel!
    
    @IBOutlet weak var leftSmallImageView: UIImageView!

    @IBOutlet weak var leftTitleLabel: UILabel!
    
    @IBOutlet weak var rightBigImageView: UIImageView!
    
    @IBOutlet weak var rightMoneyLabel: UILabel!
    
    @IBOutlet weak var rightSmallImageView: UIImageView!
    
    @IBOutlet weak var rightTitleLabel: UILabel!
    
    @IBOutlet weak var leftView: UIView!
    @IBOutlet weak var rightView: UIView!
    override func layoutSubviews() {
        super.layoutSubviews()
        self.leftSmallImageView.clipsToBounds = true
        self.leftSmallImageView.layer.cornerRadius = self.leftSmallImageView.width/2
        self.rightSmallImageView.clipsToBounds = true
        self.rightSmallImageView.layer.cornerRadius = self.rightSmallImageView.width/2

        self.leftView.layer.borderColor = UIColor.lightGray.cgColor
        self.leftView.layer.borderWidth = 0.5
        self.rightView.layer.borderColor = UIColor.lightGray.cgColor
        self.rightView.layer.borderWidth = 0.5

    }
    

    func configData(leftDict: NSDictionary, rightDict: NSDictionary) {
        
        let leftStr = leftDict["photo"] as! String
        self.leftBigImageView.setImageWith(NSURL(string: leftStr) as URL?, options: .useNSURLCache)
        self.leftMoneyLabel.text = "￥\(leftDict["sale_price"]!)"
        
        let leftSub = leftDict["pet"] as! NSDictionary
        let leftSmall = leftSub["avatar"] as? String
        self.leftSmallImageView.setImageWith(NSURL(string: leftSmall!) as URL?, options: .useNSURLCache)
        self.leftTitleLabel.text = "\(leftSub["name"]!)(\(leftSub["age"]!))"
        
        
        let rightStr = rightDict["photo"] as! String
        self.rightBigImageView.setImageWith(NSURL(string: rightStr) as URL?, options: .useNSURLCache)
        self.rightMoneyLabel.text = "￥\(rightDict["sale_price"]!)"
        
        let rightSub = leftDict["pet"] as! NSDictionary
        let rightSmall = rightSub["avatar"] as? String
        self.rightSmallImageView.setImageWith(NSURL(string: rightSmall!) as URL?, options: .useNSURLCache)
        self.rightTitleLabel.text = "\(rightSub["name"]!)(\(rightSub["age"]!))"
        
    }
    
}
