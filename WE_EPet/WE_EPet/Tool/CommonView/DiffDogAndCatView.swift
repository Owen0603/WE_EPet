//
//  DiffDogAndCatView.swift
//  WE_EPet
//
//  Created by 姚凤 on 16/10/2.
//  Copyright © 2016年 姚凤. All rights reserved.
//

import UIKit

enum AnimateType {
    case Dog
    case Cat
}

let BUTTONWIDTH :CGFloat = 100
let BUTTONGAP :CGFloat = (DIFFVIEWWIDTH-BUTTONWIDTH*2)/3
let DIFFVIEWWIDTH = SCREEN_WIDTH-40

protocol BGViewDelegate {
    func buttonClickAction(type: AnimateType)
}

class BGView: UIView {
    var dogButton : UIButton?
    var catButton : UIButton?
    var delegate : BGViewDelegate?
    
    override init(frame: CGRect) {
        super.init(frame: CGRect(x: frame.origin.x, y: frame.origin.y, width: SCREEN_WIDTH-40, height: 250))
        self.center = CGPoint(x: SCREEN_WIDTH/2, y: SCREEN_HEIGHT/2)
        self.createUI();
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func createUI() {
        let bgImageView = UIImageView.init(frame: self.bounds)
        bgImageView.image = UIImage(named: "index_type_bg")
        self.addSubview(bgImageView)
        
        //标题
        let titleLabel = self.createLabel(content: "小主终于来了，请选择你要去的星球？", frame: CGRect(x: 0, y: 10, width: DIFFVIEWWIDTH, height: 20))
        self.addSubview(titleLabel)
        
        //叉号
        let image2 = UIImageView.init(frame: CGRect(x: DIFFVIEWWIDTH-30, y: 5, width: 25, height: 25))
        image2.image = UIImage(named: "home_select_type_close")
        self.addSubview(image2)
        
        //狗按钮
        dogButton = self.createButton(type: .Dog, frame: CGRect(x: BUTTONGAP, y: 70, width: BUTTONWIDTH, height: BUTTONWIDTH))
        //猫按钮
        catButton  = self.createButton(type: .Cat, frame: CGRect(x:DIFFVIEWWIDTH-BUTTONGAP-BUTTONWIDTH, y: 70, width: BUTTONWIDTH, height: BUTTONWIDTH))
        self.addSubview(dogButton!)
        self.addSubview(catButton!)
        self.startAnimation(view: dogButton!)
        self.startAnimation(view: catButton!)
        
        
        //desc
        let descLabel = self.createLabel(content: "全国满 99元 包邮；重庆、四川、西安、武汉、贵阳、昆明满 38元 就包邮啦！", frame: CGRect(x: 10, y: 190, width: DIFFVIEWWIDTH-20, height: 40))
        self.addSubview(descLabel)
        
        //tag
        let tagImage = UIImageView.init(frame: CGRect(x: 0, y: 45, width: 94.5, height: 20.5))
        
        tagImage.centerX = (catButton?.frame)!.maxX - (catButton?.frame.width)!/2
        tagImage.image = UIImage(named: "index_cat_sha")
        self.addSubview(tagImage)
    }
    
    //创建View
    func createLabel(content: String, frame: CGRect) -> UILabel {
        let title = UILabel.init(frame: frame)
        title.text = content
        title.textColor = UIColor.white
        title.font = UIFont.systemFont(ofSize: 14)
        title.numberOfLines = 0
        title.textAlignment = .center
        return title
    }
    //创建按钮
    func createButton(type: AnimateType, frame: CGRect) -> UIButton {
        let button = UIButton.init(frame: frame)
        button.clipsToBounds = true
        button.layer.cornerRadius = frame.width/2
        
        //标题
        let image1 = UIImageView.init(frame: CGRect(x: 10, y: 0, width: frame.width-20, height: 30))
        image1.center = CGPoint(x: frame.width/2, y: frame.height/2)
    
        //副标题
        let descButton = UIButton.init(frame: CGRect(x: 0, y: 0, width: frame.width-20, height: 30))
        descButton.center = CGPoint(x: frame.width/2, y: frame.height/2)
        descButton.setImage(UIImage.init(named: "index_type"), for: .normal)
        descButton.setTitleColor(UIColor.red, for: .normal)
        descButton.isUserInteractionEnabled = false
        
        if type == .Dog {
            button.setImage(UIImage.init(named: "index_type_dog"), for: .normal)
            image1.image = UIImage(named: "home_dog_text")
            descButton.setTitle("46572种精选宝贝", for: .normal)
            button.addTarget(self, action: #selector(BGView.dogButtonClick(sender:)), for: .touchUpInside)
        }else{
            button.setImage(UIImage.init(named: "index_type_cat"), for: .normal)
            image1.image = UIImage(named: "home_cart_text")
            descButton.setTitle("14161种精选宝贝", for: .normal)
            button.addTarget(self, action: #selector(BGView.catButtonClick(sender:)), for: .touchUpInside)
        }
        button.addSubview(descButton)
        button.addSubview(image1)
        return button
    }
    //开始动画
    func startAnimation(view: UIView) {
        let rotation : CABasicAnimation = CABasicAnimation(keyPath: "transform.rotation.z")
        rotation.toValue = M_PI*2.0
        rotation.duration = 3
        rotation.isCumulative = true
        rotation.repeatCount = Float(CGFloat.greatestFiniteMagnitude)
        view.layer.add(rotation, forKey: "rotationAnimation")
    }
    
    //代理
    func dogButtonClick(sender : UIButton) {
        self.delegate?.buttonClickAction(type: .Dog)
    }
    func catButtonClick(sender : UIButton) {
        self.delegate?.buttonClickAction(type: .Cat)
    }
}






//--------------------------------------------------------------main

typealias ResultBlock = (_ clickType: AnimateType)->()

class DiffDogAndCatView: NSObject {
    
    lazy var backgroundView : UIView = {
       let window = UIView.init(frame: CGRect(x: 0, y: 0, width: SCREEN_WIDTH, height: SCREEN_HEIGHT))
        window.backgroundColor = UIColor(colorLiteralRed: 51.0/255.0, green: 51.0/255.0, blue: 51.0/255.0, alpha: 0.6)
        window.isUserInteractionEnabled = true
        window.addSubview(self.mainView)
        
        let tap : UITapGestureRecognizer = UITapGestureRecognizer.init(target: self, action: #selector(DiffDogAndCatView.hiddenView))
        window.addGestureRecognizer(tap)
        return window
    }()
    
    lazy var mainView : BGView = {
 
        let bgView = BGView.init(frame: CGRect.zero)
        bgView.delegate = self
        return bgView
    }()
    
    var resultBlock : ResultBlock!
    
    
    var diffHidden : Bool = false
    
    
    
    //出现按钮
    func showDiffView() {
        self.diffHidden = true
        UIApplication.shared.keyWindow?.addSubview(self.backgroundView)
    }
    
    //隐藏
    func hiddenView() {
        self.diffHidden = false
        self.backgroundView.removeFromSuperview()
    }
}

extension DiffDogAndCatView : BGViewDelegate{
    func buttonClickAction(type: AnimateType) {
        if let _ = resultBlock {
           self.resultBlock(type)
        }
        self.hiddenView()
    }
}

