//
//  ButtonListTableViewCell.swift
//  WE_EPet
//
//  Created by 姚凤 on 16/10/7.
//  Copyright © 2016年 姚凤. All rights reserved.
//

import UIKit

class ButtonListTableViewCell: UITableViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        let view = UIView.init(frame: CGRect(x: 0, y: 0, width: SCREEN_WIDTH, height: 0.5))
        view.backgroundColor = UIColor.lightGray
        self.addSubview(view)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
