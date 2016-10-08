//
//  SettingTableViewCell.swift
//  WE_EPet
//
//  Created by 姚凤 on 16/10/8.
//  Copyright © 2016年 姚凤. All rights reserved.
//

import UIKit

class SettingTableViewCell: UITableViewCell {

    @IBOutlet weak var iconImageView: UIImageView!
    
    @IBOutlet weak var titleLabel: UILabel!

    @IBOutlet weak var subTitleLabel: UILabel!
    
    func configData(dict: NSDictionary) {
        
        let imageUrl = dict["image"] as! String
        self.iconImageView.image = UIImage(named: imageUrl)
        
        self.titleLabel.text = dict["title"] as? String
        
        self.subTitleLabel.text = dict["subTitle"] as? String
    }
    
}
