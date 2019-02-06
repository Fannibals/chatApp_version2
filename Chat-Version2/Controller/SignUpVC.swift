//
//  SignUpVC.swift
//  Chat-Version2
//
//  Created by Ethan  on 6/2/19.
//  Copyright © 2019 Ethan . All rights reserved.
//

import UIKit

class SignUpVC: UIViewController {

    // MARK: life-cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setUI()
        setLayout()
    }
    
    // MARK: set UI
    func setUI() {
        self.view.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        self.view.addSubview(self.closeBtn)
        self.view.addSubview(self.logoLbl)
        self.view.addSubview(self.userName)
        self.view.addSubview(self.seperatorLine1)
        self.view.addSubview(self.email)
        self.view.addSubview(self.seperatorLine2)
        self.view.addSubview(self.passWord)
        self.view.addSubview(self.seperatorLine3)
        self.view.addSubview(self.avatarImgView)
        self.view.addSubview(self.chooseAvaBtn)
        self.view.addSubview(self.chooseBackColorBtn)
        self.view.addSubview(self.createAccBtn)
    }
    
    func setLayout() {
        self.closeBtn.snp.makeConstraints { (make) in
            make.right.equalToSuperview().offset(-10)
            make.top.equalToSuperview().offset(State_Bar_H+10)
            make.size.equalTo(CGSize(width: 40, height: 40))
        }
        
        self.logoLbl.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(State_Bar_H+60)
            make.centerX.equalToSuperview()
            make.size.equalTo(CGSize(width: SCREEN_WIDTH*(3.0/4.0), height: 50))
        }
        
        self.userName.snp.makeConstraints { (make) in
            make.top.equalTo(self.logoLbl.snp.bottom).offset(30)
            make.centerX.equalToSuperview()
            make.size.equalTo(CGSize(width: SCREEN_WIDTH*(3.0/4.0), height: 50))
        }
        
        self.seperatorLine1.snp.makeConstraints { (make) in
            make.top.equalTo(self.userName.snp.bottom).offset(2)
            make.centerX.equalToSuperview()
            make.size.equalTo(CGSize(width: SCREEN_WIDTH*(3.0/4.0), height: 3))
        }
        
        self.email.snp.makeConstraints { (make) in
            make.top.equalTo(self.seperatorLine1.snp.bottom).offset(5)
            make.centerX.equalToSuperview()
            make.size.equalTo(CGSize(width: SCREEN_WIDTH*(3.0/4.0), height: 50))
        }
        
        self.seperatorLine2.snp.makeConstraints { (make) in
            make.top.equalTo(self.email.snp.bottom).offset(2)
            make.centerX.equalToSuperview()
            make.size.equalTo(CGSize(width: SCREEN_WIDTH*(3.0/4.0), height: 3))
        }
        
        self.passWord.snp.makeConstraints { (make) in
            make.top.equalTo(self.seperatorLine2.snp.bottom).offset(5)
            make.centerX.equalToSuperview()
            make.size.equalTo(CGSize(width: SCREEN_WIDTH*(3.0/4.0), height: 50))
        }
        
        self.seperatorLine3.snp.makeConstraints { (make) in
            make.top.equalTo(self.passWord.snp.bottom).offset(2)
            make.centerX.equalToSuperview()
            make.size.equalTo(CGSize(width: SCREEN_WIDTH*(3.0/4.0), height: 3))
        }
        
        self.avatarImgView.snp.makeConstraints { (make) in
            make.top.equalTo(self.seperatorLine3.snp.bottom).offset(50)
            make.centerX.equalToSuperview()
            make.size.equalTo(CGSize(width: SCREEN_WIDTH*(1.0/4.0), height: SCREEN_WIDTH*(1.0/4.0)))
        }
        self.avatarImgView.layer.cornerRadius = SCREEN_WIDTH*(0.5/4.0)
        self.avatarImgView.backgroundColor = #colorLiteral(red: 0.9771530032, green: 0.7062081099, blue: 0.1748393774, alpha: 1)
        
        self.chooseAvaBtn.snp.makeConstraints { (make) in
            make.top.equalTo(self.avatarImgView.snp.bottom).offset(10)
            make.centerX.equalToSuperview()
            make.size.equalTo(CGSize(width: SCREEN_WIDTH*(1.5/4.0), height: 30))
        }
        
        self.chooseBackColorBtn.snp.makeConstraints { (make) in
            make.top.equalTo(self.chooseAvaBtn.snp.bottom).offset(15)
            make.centerX.equalToSuperview()
            make.size.equalTo(CGSize(width: SCREEN_WIDTH*(2.0/3.0), height: 15))
        }
        
        self.createAccBtn.snp.makeConstraints { (make) in
            make.bottom.equalToSuperview().offset(-30)
            make.centerX.equalToSuperview()
            make.size.equalTo(CGSize(width: SCREEN_WIDTH*(2.5/4.0), height: 50))
        }
    }
    
    // MARK: lazy init
    lazy var closeBtn: UIButton = {
        let btn = UIButton()
        btn.setImage(UIImage(named: "closeButton"), for: .normal)
        btn.addTarget(self, action: #selector(closeBtnPressed), for: .touchUpInside)
        return btn
    }()
    
    lazy var logoLbl: UILabel = {
        let lbl = UILabel()
        lbl.text = "Creat an account"
        lbl.textColor = #colorLiteral(red: 0.3647058904, green: 0.06666667014, blue: 0.9686274529, alpha: 1)
        lbl.textAlignment = .center
        lbl.font = UIFont(name: "AvenirNext-Bold", size: 23)
    
        return lbl
    }()
    
    lazy var userName: UITextField = {
        let userName = UITextField()
        userName.placeholder = "username"
        return userName
    }()
    
    lazy var seperatorLine1: UIView = {
        let line = UIView()
        line.backgroundColor = #colorLiteral(red: 0.1764705926, green: 0.4980392158, blue: 0.7568627596, alpha: 1)
        return line
    }()
    
    lazy var email: UITextField = {
        let email = UITextField()
        email.placeholder = "password"
        return email
    }()
    
    lazy var seperatorLine2: UIView = {
        let line = UIView()
        line.backgroundColor = #colorLiteral(red: 0.1764705926, green: 0.4980392158, blue: 0.7568627596, alpha: 1)
        return line
    }()
    
    lazy var passWord: UITextField = {
        let passWord = UITextField()
        passWord.placeholder = "password"
        return passWord
    }()
    
    lazy var seperatorLine3: UIView = {
        let line = UIView()
        line.backgroundColor = #colorLiteral(red: 0.1764705926, green: 0.4980392158, blue: 0.7568627596, alpha: 1)
        return line
    }()
    
    lazy var avatarImgView: UIImageView = {
        let imgView = UIImageView()
        return imgView
    }()
    
    lazy var chooseAvaBtn: UIButton = {
        let btn = LetterBtn()
        btn.setTitle("Choose avatar", for: .normal)
        return btn
    }()
    
    lazy var chooseBackColorBtn: UIButton = {
        let btn = LetterBtn()
        btn.setTitle("Generate background color", for: .normal)
        return btn
    }()
    
    lazy var createAccBtn: UIButton = {
        let btn = NormalBtn(value: 0)
        btn.setTitle("Create Account", for: .normal)
        return btn
    }()
    


    // MARK: actions
    @objc func closeBtnPressed() {
        
    }
}
