//
//  AreaSelectViewController.swift
//  WE_EPet
//
//  Created by 姚凤 on 16/10/5.
//  Copyright © 2016年 姚凤. All rights reserved.
//

import UIKit
import Alamofire

typealias AreaSelectBlock = (NSDictionary)->Void

let RequestUrl = "http://api.epet.com/appmall/place.html?do=getList"

class AreaSelectViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {

    var areaSelectBlock : AreaSelectBlock?
    
    var dataArray : [AnyObject]?
    
    
    lazy var tableView : UITableView = {
      let tab = UITableView.init(frame: CGRect.init(x: 0, y: 64.5, width: SCREEN_WIDTH, height: SCREEN_HEIGHT-64), style: .plain)
        tab.backgroundColor = RGB(r: 225.0/255.0, g: 225.0/255.0, b: 225.0/255.0)
        tab.delegate = self
        tab.dataSource = self
        tab.sectionHeaderHeight = 30
        tab.rowHeight = 50
        return tab

    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.white
        self.creatUI()
        self.requstData()
    }
    
    func requstData() {
       Alamofire.request(RequestUrl).responseJSON { (response) in
        
        
        let dict : Any? = response.result.value as Any?
        if let resultDict :Dictionary = dict as? Dictionary<String, AnyObject>{
            self.dataArray = resultDict["places"] as! [AnyObject]?
            self.view.addSubview(self.tableView)
            self.tableView.reloadData()
          }
        }
    }
    
    func creatUI() {
        let topView = UIView.init(frame: CGRect(x: 0, y: 20, width: SCREEN_WIDTH, height: 44))
        self.view.addSubview(topView)
        
        let leftButton = UIButton.init(frame: CGRect(x: 0, y: 0, width: 44, height: 44))
        leftButton.setImage(UIImage(named:"return_app"), for: .normal)
        leftButton.addTarget(self, action: #selector(AreaSelectViewController.backAction), for: .touchUpInside)
        topView.addSubview(leftButton)
        
        let titleLabel = UILabel.init(frame: CGRect(x: 50, y: 0, width: SCREEN_WIDTH-100, height: 44));
        titleLabel.text = "选择收获地址"
        titleLabel.textAlignment = .center
        titleLabel.textColor = RGB(r: 50.0/255.0, g: 193.0/255.0, b: 108.0/255.0)
        titleLabel.font = UIFont.systemFont(ofSize: 16)
        topView.addSubview(titleLabel)
        
    }
    
    func backAction() {
        self.dismiss(animated: true) { 
            
        }
    }

    //MARK: 代理方法
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return (self.dataArray?.count)!
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let dict : Dictionary = self.dataArray![section] as! Dictionary<String, AnyObject>
        let array : [AnyObject] = dict["items"] as! [AnyObject]
        return array.count
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header = UILabel.init(frame: CGRect(x: 0, y: 0, width: SCREEN_WIDTH, height: 30))
        header.backgroundColor = RGB(r: 220.0/255.0, g: 220.0/255.0, b: 220.0/255.0)
        header.font = UIFont.systemFont(ofSize: 14)
        let dict : Dictionary = self.dataArray![section] as! Dictionary<String, AnyObject>
        header.text = "    \(dict["letter"]!)"
        
        return header
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellId = "cellID"
        let cell : UITableViewCell = UITableViewCell(style: .default, reuseIdentifier: cellId)
        let dict : Dictionary = self.dataArray![indexPath.section] as! Dictionary<String, AnyObject>
        let array : [AnyObject] = dict["items"] as! [AnyObject]
        let subDict : Dictionary = array[indexPath.row] as! Dictionary<String, AnyObject>
        cell.textLabel?.text = subDict["name"] as! String?
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        let dict : Dictionary = self.dataArray![indexPath.section] as! Dictionary<String, AnyObject>
        let array : [AnyObject] = dict["items"] as! [AnyObject]
        let subDict : Dictionary = array[indexPath.row] as! Dictionary<String, AnyObject>
        if  let _ = self.areaSelectBlock {
            self.areaSelectBlock!(subDict as NSDictionary)
            self.backAction()
        }
    }
    
    

    static func ShowAreaSelectView(block: @escaping (NSDictionary)->Void){
        let controller = AreaSelectViewController()
        controller.areaSelectBlock = block
        RootViewController.currentViewController().present(controller, animated: true) { 
            
        }
    }
    
}
