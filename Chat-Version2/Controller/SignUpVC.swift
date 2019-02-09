//
//  SignUpVC.swift
//  Chat-Version2
//
//  Created by Ethan  on 6/2/19.
//  Copyright © 2019 Ethan . All rights reserved.
//

import UIKit

class SignUpVC: UIViewController {
    
    var bgColor: String?
    var avatarName: String?

    // MARK: life-cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setUI()
        setLayout()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        if UserDataService.instance.avatarName == "" {
            self.avatarImgView.image = UIImage(named: "profileDefault")
        } else {
            self.avatarImgView.image = UIImage(named: UserDataService.instance.avatarName)
            self.avatarName = UserDataService.instance.avatarName
        }
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
            make.top.equalToSuperview().offset(STATUS_BAR_HEIGHT+10)
            make.size.equalTo(CGSize(width: 40, height: 40))
        }
        
        self.logoLbl.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(STATUS_BAR_HEIGHT+60)
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
        email.placeholder = "email"
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
        imgView.image = UIImage(named: "profileDefault")
 
        return imgView
    }()
    
    lazy var chooseAvaBtn: UIButton = {
        let btn = LetterBtn()
        btn.setTitle("Choose avatar", for: .normal)
        btn.addTarget(self, action: #selector(chooseAvaBtnPressed), for: .touchUpInside)
        return btn
    }()
    
    lazy var chooseBackColorBtn: UIButton = {
        let btn = LetterBtn()
        btn.setTitle("Generate background color", for: .normal)
        btn.addTarget(self, action: #selector(chooseBackColorBtnPressed), for: .touchUpInside)
        return btn
    }()
    
    lazy var createAccBtn: UIButton = {
        let btn = NormalBtn(value: 0)
        btn.setTitle("Create Account", for: .normal)
        btn.addTarget(self, action: #selector(createAccBtnPressed), for: .touchUpInside)
        return btn
    }()
    

    // MARK: actions
    @objc func closeBtnPressed() {
        //获取根VC
        var rootVC = self.presentingViewController
        print(rootVC as Any)
        while let parent = rootVC?.presentingViewController {
            rootVC = parent
        }
        print(rootVC as Any)
        //释放所有下级视图
        rootVC?.dismiss(animated: true, completion: nil)
    }
    
    @objc func chooseAvaBtnPressed() {
        present(AvatarVC(), animated: true, completion: nil)
    }
    
    @objc func chooseBackColorBtnPressed() {
        let r = CGFloat(arc4random_uniform(255))/255.0
        let g = CGFloat(arc4random_uniform(255))/255.0
        let b = CGFloat(arc4random_uniform(255))/255.0
        let alpha = 1.0
        
        self.bgColor = "[\(r),\(g),\(b),\(alpha)]"
        
        UIView.animate(withDuration: 0.2) {
            self.avatarImgView.backgroundColor = UIColor.init(red: r, green: g, blue: b, alpha: 1.0)
        }
    }
    
    @objc func createAccBtnPressed() {
        guard let name = self.userName.text, self.userName.text != "" else {return}
        guard let email = self.email.text, self.email.text != "" else {return}
        guard let password = self.passWord.text, self.passWord.text != "" else {return}
        guard let avatarName = self.avatarName, self.avatarName != "" else {return}
        guard let avatarColor = self.bgColor, self.bgColor != "" else {return}
        
        AuthService.instance.registerUser(email: email, password: password) { (success) in
            if success {
                AuthService.instance.loginUser(email: email, password: password, completion: { (success) in
                    if success {
                        AuthService.instance.createUser(name: name, email: email, avatarName: avatarName, avatarColor: avatarColor) { (success) in
                            if success {
                                let alertController = UIAlertController(title: "Thanks for Sign Up",
                                                                        message: "", preferredStyle: .alert)
                                let cancelAction = UIAlertAction(title: "cancel", style: .cancel, handler: nil)
                                let okAction = UIAlertAction(title: "ok", style: .default, handler: {
                                    action in
                                    self.closeBtnPressed()
                                })
                                alertController.addAction(cancelAction)
                                alertController.addAction(okAction)
                                self.present(alertController, animated: true, completion: nil)
                                
                            }
                        }
                    }
                })
            }
        }

    }
}
