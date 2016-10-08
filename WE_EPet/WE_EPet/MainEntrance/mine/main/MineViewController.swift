//
//  MineViewController.swift
//  WE_EPet
//
//  Created by 姚凤 on 16/9/17.
//  Copyright © 2016年 姚凤. All rights reserved.
//

import UIKit
private let array1 = [["title":"好友基金计划","image":"user_110","subTitle":""],
              ["title":"退换记录","image":"user_2","subTitle":""],
              ["title":"我的钱包","image":"user_3","subTitle":"充值、提现"],
              ["title":"背包道具","image":"user_4","subTitle":""]]

private let array2 = [["title":"我的评价","image":"user_6","subTitle":""],
              ["title":"我的咨询","image":"user_7","subTitle":""],
              ["title":"我的收藏","image":"user_8","subTitle":""],
              ["title":"我的代言","image":"user_10","subTitle":""],
              ["title":"免费礼包兑换","image":"giftbag","subTitle":""]
]

private let array3 = [["title":"设置","image":"user_9","subTitle":"个人资料，我的宠物，地址管理"]]

private let paramArray = [array1,array2,array3]

private let CellID1 = "cellID1"
private let CellID2 = "cellID2"

class MineViewController: RootViewController,UITableViewDelegate,UITableViewDataSource {

    lazy var tabView : UITableView = {
        let tab = UITableView.init(frame: self.view.bounds, style: .plain)
        tab.delegate = self
        tab.dataSource = self
        tab.backgroundColor = UIColor.lightGray
        tab.register(UINib.init(nibName: "MineTopTableViewCell", bundle: Bundle.main), forCellReuseIdentifier: CellID1)
        tab.register(UINib.init(nibName: "SettingTableViewCell", bundle: Bundle.main), forCellReuseIdentifier: CellID2)
        return tab
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.addSubview(self.tabView)
        self.tabView.reloadData()
    }

    //MARK: 代理
    func numberOfSections(in tableView: UITableView) -> Int {

        return paramArray.count + 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section==0 {
            return 1
        }else{
            
            let array = paramArray[section-1] as NSArray
            return array.count
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 0 {
            return 200
        }else{
            return 60
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section==0 {

            let cell = tableView.dequeueReusableCell(withIdentifier: CellID1) as! MineTopTableViewCell

            return cell
            
        }else{
            let array = paramArray[indexPath.section-1] as NSArray
            let cell = tableView.dequeueReusableCell(withIdentifier: CellID2) as! SettingTableViewCell
            cell.accessoryType = .disclosureIndicator
            cell.configData(dict: array[indexPath.row] as! NSDictionary)
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
      
    }
}
