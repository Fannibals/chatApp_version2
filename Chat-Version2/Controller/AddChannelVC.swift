//
//  AddChannelVC.swift
//  Chat-Version2
//
//  Created by Ethan  on 10/2/19.
//  Copyright © 2019 Ethan . All rights reserved.
//

import UIKit

class AddChannelVC: UIViewController {
    
    // MARK: life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setUI()
        setLayout()
    }
    
    // MARK: set UI
    func setUI() {
        self.view.backgroundColor = UIColor.clear
        self.view.addSubview(self.bgView)
        self.bgView.addSubview(self.backView)
        
        self.backView.addSubview(self.closeBtn)
        self.backView.addSubview(self.topLbl)
        self.backView.addSubview(self.nameTF)
        self.backView.addSubview(self.seperateLine1)
        self.backView.addSubview(self.descriptionTF)
        self.backView.addSubview(self.seperateLine2)
        self.backView.addSubview(self.createChannelBtn)
    }
    
    func setLayout() {
        self.backView.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview()
            make.size.equalTo(CGSize(width: PROFILE_WIDTH, height: PROFILE_HEIGHT))
        }
        
        self.closeBtn.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(10)
            make.right.equalToSuperview().offset(-10)
            make.size.equalTo(CGSize(width: 30, height: 30))
        }
        
        self.topLbl.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().offset(PROFILE_HEIGHT*(1.5/10.0))
            make.size.equalTo(CGSize(width: PROFILE_WIDTH*(1.5/2.0), height: PROFILE_HEIGHT*(1.0/10.0)))
        }
        
        self.nameTF.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.top.equalTo(self.topLbl.snp.bottom).offset(PROFILE_HEIGHT*(1.0/10.0))
            make.size.equalTo(CGSize(width: PROFILE_WIDTH*(3.5/5.0), height: PROFILE_HEIGHT*(1.0/10.0)))
        }
        
        self.seperateLine1.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.top.equalTo(self.nameTF.snp.bottom).offset(5)
            make.size.equalTo(CGSize(width: PROFILE_WIDTH*(3.5/5.0), height:2))
        }
        
        self.descriptionTF.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.top.equalTo(self.seperateLine1.snp.bottom).offset(5)
            make.size.equalTo(CGSize(width: PROFILE_WIDTH*(3.5/5.0), height: PROFILE_HEIGHT*(1.0/10.0)))
        }
        
        self.seperateLine2.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.top.equalTo(self.descriptionTF.snp.bottom).offset(5)
            make.size.equalTo(CGSize(width: PROFILE_WIDTH*(3.5/5.0), height:2))
        }
        
        self.createChannelBtn.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.bottom.equalToSuperview().offset(-20)
            make.size.equalTo(CGSize(width: PROFILE_WIDTH*(3.5/5.0), height:PROFILE_HEIGHT*(1.0/10.0)))
        }
    }

    // control parts init
    
    lazy var closeBtn: UIButton = {
        let btn = UIButton()
        btn.setImage(UIImage(named: "closeButton"), for: .normal)
        btn.addTarget(self, action: #selector(closeBtnPressed), for: .touchUpInside)
        return btn
    }()
    
    lazy var bgView: UIView = {
        let bgView = UIView(frame: CGRect(x: 0, y: 0, width: SCREEN_WIDTH, height: SCREEN_HEIGHT))
        bgView.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.4)
        return bgView
    }()
    
    lazy var backView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.white
        return view
    }()
    
    lazy var topLbl: UILabel = {
        let lbl = UILabel()
        lbl.text = "Create Channel"
        lbl.textColor = #colorLiteral(red: 0.2196078449, green: 0.007843137719, blue: 0.8549019694, alpha: 1)
        lbl.textAlignment = .center
        lbl.font = UIFont(name: "AvenirNext-Bold", size: 26)
        return lbl
    }()
    
    lazy var nameTF: UITextField = {
        let name = UITextField()
        name.placeholder = "name"
        return name
    }()
    
    lazy var seperateLine1: UIView = {
        let line = UIView()
        line.backgroundColor = #colorLiteral(red: 0.1764705926, green: 0.4980392158, blue: 0.7568627596, alpha: 1)
        return line
    }()
    
    lazy var descriptionTF: UITextField = {
        let des = UITextField()
        des.placeholder = "description"
        return des
    }()
    
    lazy var seperateLine2: UIView = {
        let line = UIView()
        line.backgroundColor = #colorLiteral(red: 0.1764705926, green: 0.4980392158, blue: 0.7568627596, alpha: 1)
        return line
    }()
    
    lazy var createChannelBtn: UIButton = {
        let btn = NormalBtn()
        btn.setTitle("Create Channel", for: .normal)
        btn.addTarget(self, action: #selector(createBtnPressed), for: .touchUpInside)
        return btn
    }()
    
    // MARK: actions
    @objc func closeBtnPressed() {
        dismiss(animated: true, completion: nil)
    }
    
    @objc func createBtnPressed() {
        guard let name = nameTF.text, nameTF.text != "" else {return}
        guard let desc = descriptionTF.text, descriptionTF.text != "" else {return}
        SocketService.instance.addChannel(channelName: name, channelDescription: desc) { (success) in
            if success {
                self.dismiss(animated: true, completion: nil)
            }
        }
    }
}
