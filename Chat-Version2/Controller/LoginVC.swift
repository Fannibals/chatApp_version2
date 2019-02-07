//
//  LoginVC.swift
//  Chat-Version2
//
//  Created by Ethan  on 31/1/19.
//  Copyright © 2019 Ethan . All rights reserved.
//

import UIKit
import SnapKit

class LoginVC: UIViewController {

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
        self.view.addSubview(self.logoView)
        self.view.addSubview(self.logoLbl)
        self.view.addSubview(self.userName)
        self.view.addSubview(self.seperatorLine1)
        self.view.addSubview(self.passWord)
        self.view.addSubview(self.seperatorLine2)
        self.view.addSubview(self.loginBtn)
        self.view.addSubview(self.signUpBtn)
    }
    
    func setLayout() {
        self.closeBtn.snp.makeConstraints { (make) in
            make.right.equalToSuperview().offset(-10)
            make.top.equalToSuperview().offset(STATUS_BAR_HEIGHT+10)
            make.size.equalTo(CGSize(width: 40, height: 40))
        }
        
        self.logoView.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(STATUS_BAR_HEIGHT+60)
            make.centerX.equalToSuperview().offset(-40)
            make.size.equalTo(CGSize(width: 60, height: 53))
        }
        
        self.logoLbl.snp.makeConstraints { (make) in
            make.centerY.equalTo(self.logoView)
            make.left.equalTo(self.logoView.snp.right).offset(10)
            make.size.equalTo(CGSize(width: 100, height: 50))
        }
        
        self.userName.snp.makeConstraints { (make) in
            make.top.equalTo(self.logoView.snp.bottom).offset(30)
            make.centerX.equalToSuperview()
            make.size.equalTo(CGSize(width: SCREEN_WIDTH*(3.0/4.0), height: 50))
        }
        
        self.seperatorLine1.snp.makeConstraints { (make) in
            make.top.equalTo(self.userName.snp.bottom).offset(2)
            make.centerX.equalToSuperview()
            make.size.equalTo(CGSize(width: SCREEN_WIDTH*(3.0/4.0), height: 3))
        }
        
        self.passWord.snp.makeConstraints { (make) in
            make.top.equalTo(self.seperatorLine1.snp.bottom).offset(5)
            make.centerX.equalToSuperview()
            make.size.equalTo(CGSize(width: SCREEN_WIDTH*(3.0/4.0), height: 50))
        }
        
        self.seperatorLine2.snp.makeConstraints { (make) in
            make.top.equalTo(self.passWord.snp.bottom).offset(2)
            make.centerX.equalToSuperview()
            make.size.equalTo(CGSize(width: SCREEN_WIDTH*(3.0/4.0), height: 3))
        }
        
        self.loginBtn.snp.makeConstraints { (make) in
            make.top.equalTo(self.seperatorLine2.snp.bottom).offset(40)
            make.centerX.equalToSuperview()
            make.size.equalTo(CGSize(width: SCREEN_WIDTH*(3.0/4.0), height: 60))
        }
        
        self.signUpBtn.snp.makeConstraints { (make) in
            make.top.equalTo(self.loginBtn.snp.bottom).offset(10)
            make.centerX.equalToSuperview()
            make.size.equalTo(CGSize(width: SCREEN_WIDTH*(3.0/4.0), height: 30))
        }
    }
    
    // MARK: lazy init
    lazy var closeBtn: UIButton = {
        let btn = UIButton()
        btn.setImage(UIImage(named: "closeButton"), for: .normal)
        btn.addTarget(self, action: #selector(closeBtnPressed), for: .touchUpInside)
        return btn
    }()
    
    lazy var logoView: UIImageView = {
        let logo = UIImageView()
        logo.image = UIImage(named: "smackLogo")
        return logo
    }()
    
    lazy var logoLbl: UILabel = {
        let Lbl = UILabel()
        Lbl.text = "Smack"
        Lbl.textColor = #colorLiteral(red: 0.2196078449, green: 0.007843137719, blue: 0.8549019694, alpha: 1)
        Lbl.font = UIFont(name: "AvenirNext-Bold", size: 25)
        return Lbl
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
    
    lazy var passWord: UITextField = {
        let passWord = UITextField()
        passWord.placeholder = "password"
        return passWord
    }()
    
    lazy var seperatorLine2: UIView = {
        let line = UIView()
        line.backgroundColor = #colorLiteral(red: 0.1764705926, green: 0.4980392158, blue: 0.7568627596, alpha: 1)
        return line
    }()
    
    lazy var loginBtn: UIButton = {
        let btn = NormalBtn(value: 0)
        btn.setTitle("Login", for: .normal)
        btn.addTarget(self, action: #selector(loginBtnPressed), for: .touchUpInside)
        return btn
    }()
    
    lazy var signUpBtn: UIButton = {
        let btn = LetterBtn()
        btn.setTitle("Don't have an account? Sign up here", for: .normal)
        btn.addTarget(self, action: #selector(signUpBtnPressed), for: .touchUpInside)
        return btn
    }()
    
    // MARK: Actions
    @objc func closeBtnPressed() {
        dismiss(animated: true, completion: nil)
    }
    
    @objc func signUpBtnPressed() {
        present(SignUpVC(), animated: true, completion: nil)
    }
    
    @objc func loginBtnPressed() {
        guard let email = self.userName.text, self.userName.text != "" else {return}
        guard let password = self.passWord.text, self.passWord.text != "" else {return}
        
//        AuthService.instance.registerUser(email: email, password: password) { (success) in
//            if success {
//                print("Successfully registered")
//            } else {
//                debugPrint()
//            }
//        }
        
        // TODO: decide when success or not
        AuthService.instance.loginUser(email: email, password: password) { (success) in
            if success {
                print("Successfully logged in")
                self.dismiss(animated: true, completion: nil)
                
            } else {
                debugPrint()
            }
            
        }
    }
}
