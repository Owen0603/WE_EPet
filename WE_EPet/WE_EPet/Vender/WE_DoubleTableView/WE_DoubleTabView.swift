//
//  DoubleTabView.swift
//  WE_EPet
//
//  Created by 姚凤 on 16/10/8.
//  Copyright © 2016年 姚凤. All rights reserved.
//

import UIKit

let LeftPro :CGFloat = 0.3

class WE_DoubleTabView: UIView,UITableViewDelegate,UITableViewDataSource {
    
    var viewFrame: CGRect = CGRect(x: 0, y: 0, width: 0, height: 0)
    var leftArray = NSArray()
    var rightArray = NSArray()
    var leftSelectIndex = 0
    var rightSelectIndex = 0
    
    
    
    lazy var leftTabView : UITableView = {
        let tabView = UITableView.init(frame: CGRect.init(x: 0, y: 0, width: LeftPro * SCREEN_WIDTH, height: self.viewFrame.height), style: .plain)
        tabView.delegate = self
        tabView.dataSource = self
        tabView.backgroundColor = UIColor.lightGray
        return tabView
    }()
    
    lazy var rightTabView : UITableView = {
        let tabView = UITableView.init(frame: CGRect.init(x: LeftPro * SCREEN_WIDTH, y: 0, width: (1-LeftPro) * SCREEN_WIDTH, height: self.viewFrame.height), style: .plain)
        tabView.delegate = self
        tabView.dataSource = self
        tabView.backgroundColor = UIColor.lightGray
        return tabView
    }()
    

    convenience init(leftArray: NSArray, rightArray: NSArray, frame: CGRect) {
        self.init(frame: frame)
        self.viewFrame = frame
        self.leftArray = leftArray
        self.rightArray = rightArray
    }
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        if tableView == self.leftTabView {
            return 1
        }else{
            let array = self.leftArray[self.leftSelectIndex] as! NSArray
            return array.count
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView == self.leftTabView {
            return self.leftArray.count
        }else{
//            let array = self.leftArray[self.leftSelectIndex] as! NSArray
            return 1
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if tableView == self.leftTabView {
            
            let cell = UITableViewCell.init(style: .default, reuseIdentifier: "cell")
            cell.textLabel?.text = "11111";
            return cell
            
        }else{
            let cell = UITableViewCell.init(style: .default, reuseIdentifier: "cell")
            cell.textLabel?.text = "22222";
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if tableView == self.leftTabView {
            
            self.leftSelectIndex = indexPath.row
            self.rightTabView.reloadData()
            
        }else{
            
            self.rightSelectIndex = indexPath.row
            
        }
    }

}
