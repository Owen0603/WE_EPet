//
//  GoodCommondTableViewCell.swift
//  WE_EPet
//
//  Created by 姚凤 on 16/10/7.
//  Copyright © 2016年 姚凤. All rights reserved.
//

import UIKit

class GoodCommondTableViewCell: UITableViewCell {
    @IBOutlet weak var leftImageView: UIImageView!

    @IBOutlet weak var titleLabel: UILabel!
    
    @IBOutlet weak var subTitleLabel: UILabel!
    
    @IBOutlet weak var contentlabel: UILabel!
    
    @IBOutlet weak var desLabel: UILabel!
    @IBOutlet weak var starImageView: UIImageView!
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.leftImageView.clipsToBounds = true
        self.leftImageView.layer.cornerRadius = 25
    }

    func configData(dict: NSDictionary) {
        let userName = dict["avatar"] as! NSString
        self.leftImageView.setImageWith(NSURL(string: userName as String) as URL?, options: .useNSURLCache)
        self.titleLabel.text = dict["username"] as? String
        self.subTitleLabel.text = dict["reg_days"] as? String
        self.contentlabel.text = dict["content"] as? String
        self.desLabel.text = dict["subject"] as? String
        
        var star = ""
        switch dict["point"] as? String {
        case "1"?:
            star = "star_1"
        case "2"?:
            star = "star_2"
        case "3"?:
            star = "star_3"
        case "4"?:
            star = "star_4"
        case "5"?:
            star = "star_5"
        default:
            star = "star_5"
        }
        self.starImageView.image = UIImage(named: star)
    }
    
}
