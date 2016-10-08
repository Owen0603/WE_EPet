//
//  CategoryViewController.swift
//  WE_EPet
//
//  Created by 姚凤 on 16/9/17.
//  Copyright © 2016年 姚凤. All rights reserved.
//

import UIKit
import Alamofire

let LeftURL = "http://cdnapi.epet.com/appmall/categorys.html?do=index2&appname=epetmall&duuid=AAEEDCD1-8804-45FA-B058-3526E1557649&iphone_model=iphone5&my_placeid=24&passkey=00bb2c9bba1c8d213e16f042bb1a56db&pet_type=cat&postsubmit=r9b8s7m4&system=ios&version=3.400000"

class CategoryViewController: RootViewController,UISearchBarDelegate {

    var searchBar : UISearchBar?
    
    var doubleTabView : WE_DoubleTabView?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.white
        self.creatUI()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.navigationController?.isNavigationBarHidden = true
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }

    func creatUI() {
        
        searchBar = UISearchBar.init(frame: CGRect(x: 10, y: 20, width: SCREEN_WIDTH-20, height: 40))
        searchBar?.backgroundColor = UIColor.white
        searchBar?.delegate = self
        searchBar?.placeholder = "搜索宝贝"
        self.view.addSubview(searchBar!)
        let seachTextFeild:UITextField = searchBar?.subviews.first?.subviews.last as! UITextField
        seachTextFeild.backgroundColor = UIColor.white
        seachTextFeild.layer.borderColor = RGB(r: 220.0/255.0, g: 220.0/255.0, b: 220.0/255.0).cgColor
        seachTextFeild.layer.borderWidth = 0.5
        seachTextFeild.textColor = UIColor.lightGray
        seachTextFeild.clipsToBounds = true
        seachTextFeild.layer.cornerRadius = 5
        let searchBarBg: UIImage =  UIImage.getImageWithColor(color: RGB(r: 255.0, g: 255.0, b: 255.0))
        searchBar?.setBackgroundImage(searchBarBg, for: .any, barMetrics: .default)
        searchBar?.backgroundColor = UIColor.clear
    }
    
    func requestData() {
        
        Alamofire.request(LeftURL).responseJSON { response1 in
            
//            Alamofire.request(URL_Dog_Worth).responseJSON { response2 in
            
              let array1 : NSArray? = response1.result.value as! NSArray?
            
            }
//        }
    }
}
