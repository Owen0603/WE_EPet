//
//  HomeIndexViewController.swift
//  WE_EPet
//
//  Created by 姚凤 on 16/9/17.
//  Copyright © 2016年 姚凤. All rights reserved.
//

import UIKit
import Alamofire

let URL_Dog = "http://cdnapi.epet.com/appmall/main.html?do=index201602&appname=epetmall&duuid=AAEEDCD1-8804-45FA-B058-3526E1557649&iphone_model=iphone5&my_placeid=24&passkey=891bcda0bc55f0717607c5928b917ad5&pet_type=dog&postsubmit=r9b8s7m4&system=ios&version=3.400000"

let URL_Cat = "http://api.epet.com/appmall/v3/main.html?do=getDynamic&appname=epetmall&duuid=AAEEDCD1-8804-45FA-B058-3526E1557649&iphone_model=iphone5&my_placeid=24&passkey=891bcda0bc55f0717607c5928b917ad5&pet_type=dog&postsubmit=r9b8s7m4&system=ios&version=3.400000"

let ImageURL = "http://i.epetbar.com/2015-12/07/16/21064d11879da67623737d891691ee5b.jpg-222-226.png"


class HomeIndexViewController: RootViewController {

    
//    var areaButton : UIButton?
//    var textField : UITextField?
//    var messageButton : UIButton?
//    
//    var autoScrollView : WE_AutoScrollView?
//    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.requstData()
    }



}

//UI
extension HomeIndexViewController : UITextFieldDelegate{
    func createUI() {
//        self.topInputView()
////        self.autoScrollView()
//        self.htmlButtonView()
//        self.userListButtonsView()
    }
    
    //顶部输入框
//    func topInputView() {
//        let topView = UIView.init(frame: CGRect(x: 0, y: 0, width: SCREEN_WIDTH, height: 50))
//        self.view.addSubview(topView)
//        
//        areaButton = UIButton.init(frame: CGRect(x: 0, y: 0, width: 50, height: 100))
//        areaButton?.setTitle("江苏省", for: .normal)
//        areaButton?.setImage(UIImage(named: "downarrow"), for: .normal)
//        topView.addSubview(areaButton!)
//        
//        textField = UITextField.init(frame: CGRect(x: 100, y: 5, width: SCREEN_WIDTH-160, height: 40))
//        textField?.delegate = self
//        textField?.placeholder = "搜索宝贝"
//        topView.addSubview(textField!)
//        
//        messageButton = UIButton.init(frame: CGRect(x: SCREEN_WIDTH-60, y: 0, width: 50, height: 50))
//        messageButton?.setImage(UIImage(named: "user_mesage"), for: .normal)
//        topView.addSubview(messageButton!)
//    }
    
    //轮播图
//    func autoScrollView() {
//        
//    }
    
    //横向滑动按钮
    func htmlButtonView() {
        
    }
    
    //订单一系列
    func userListButtonsView() {
        
    }
    
    //
}

//requset
extension HomeIndexViewController{
    func requstData() {
        Alamofire.request(URL_Dog).responseJSON { response in
            print(response)
        }
    }
}
