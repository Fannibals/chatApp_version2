//
//  ProfileVC.swift
//  Chat-Version2
//
//  Created by Ethan  on 9/2/19.
//  Copyright © 2019 Ethan . All rights reserved.
//

import UIKit
import SnapKit

let PROFILE_WIDTH = SCREEN_WIDTH * (9.0/10.0)
let PROFILE_HEIGHT = SCREEN_HEIGHT * (1.3/3.0)

class ProfileVC: UIViewController {
    
    var avatarName: String = ""

    override func viewDidLoad() {
        super.viewDidLoad()
        setUI()
        setLayout()
        setUserInfo()
    }
    
    func setUI() {
        self.view.backgroundColor = UIColor.clear
        self.view.addSubview(self.bgView)
        self.bgView.addSubview(self.backView)
        
        self.backView.addSubview(self.closeBtn)
        self.backView.addSubview(self.topLbl)
        self.backView.addSubview(self.avatarImgView)
        self.backView.addSubview(self.userNameLbl)
        self.backView.addSubview(self.emailLbl)
        self.backView.addSubview(self.logOutBtn)
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
            make.size.equalTo(CGSize(width: PROFILE_WIDTH*(1.0/2.0), height: PROFILE_HEIGHT*(1.0/10.0)))
        }
        
        self.avatarImgView.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.top.equalTo(self.topLbl.snp.bottom).offset(20)
            make.size.equalTo(CGSize(width: PROFILE_WIDTH*(1.2/4.0), height: PROFILE_WIDTH*(1.2/4.0)))
        }
        self.avatarImgView.layer.cornerRadius = PROFILE_WIDTH*(1.2/4.0) * 0.5
        
        self.userNameLbl.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.top.equalTo(self.avatarImgView.snp.bottom).offset(20)
            make.size.equalTo(CGSize(width: PROFILE_WIDTH*(1.0/2.0), height: PROFILE_HEIGHT*(1.0/10.0)))
        }
        
        self.emailLbl.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.top.equalTo(self.userNameLbl.snp.bottom).offset(5)
            make.size.equalTo(self.userNameLbl.snp.size)
        }
        
        self.logOutBtn.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.bottom.equalToSuperview().offset(-10)
            make.size.equalTo(self.topLbl.snp.size)
        }
    }
    
    func setUserInfo() {
        self.avatarImgView.image = UIImage(named: UserDataService.instance.avatarName)
        self.avatarImgView.backgroundColor = UserDataService.instance.returnUIColor(components: UserDataService.instance.avatarColor)
        self.userNameLbl.text = UserDataService.instance.name
        self.emailLbl.text = UserDataService.instance.email
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
        lbl.text = "Your Profile"
        lbl.textColor = #colorLiteral(red: 0.2196078449, green: 0.007843137719, blue: 0.8549019694, alpha: 1)
        lbl.textAlignment = .center
        lbl.font = UIFont(name: "AvenirNext-Bold", size: 23)
        return lbl
    }()
    
    lazy var avatarImgView: UIImageView = {
        let imgView = UIImageView()
        imgView.image = UIImage(named: avatarName)
        if avatarName == "" {
            imgView.image = UIImage(named: "profileDefault")
            imgView.backgroundColor = #colorLiteral(red: 0.7450980544, green: 0.1568627506, blue: 0.07450980693, alpha: 1)
        }
        return imgView
    }()
    
    lazy var userNameLbl: UILabel = {
        let lbl = UILabel()
        lbl.text = "userName"
        lbl.textColor = #colorLiteral(red: 0, green: 0.4784313725, blue: 1, alpha: 1)
        lbl.textAlignment = .center
        lbl.font = UIFont(name: "AvenirNext", size: 12)
        return lbl
    }()
    
    lazy var emailLbl: UILabel = {
        let lbl = UILabel()
        lbl.text = "email"
        lbl.textColor = #colorLiteral(red: 0, green: 0.4784313725, blue: 1, alpha: 1)
        lbl.textAlignment = .center
        lbl.font = UIFont(name: "AvenirNext", size: 12)
        return lbl
    }()
    
    lazy var logOutBtn: UIButton = {
        let btn = UIButton()
        btn.setTitle("Logout", for: .normal)
        btn.setTitleColor(#colorLiteral(red: 0.2196078449, green: 0.007843137719, blue: 0.8549019694, alpha: 1), for: .normal)
        btn.titleLabel?.font = UIFont(name: "AvenirNext-Bold", size: 20)
        btn.titleLabel?.textAlignment = .center
        btn.addTarget(self, action: #selector(logOutBtnPressed), for: .touchUpInside)
        return btn
    }()
    
    // MARK: actions
    @objc func closeBtnPressed() {
        dismiss(animated: true, completion: nil)
    }
    
    @objc func logOutBtnPressed() {
        AuthService.instance.isLoggedIn = false
        UserDataService.instance.logoutUser()
        NotificationCenter.default.post(name: NOTIF_USERDATA_CHANGED, object: nil)
        dismiss(animated: true, completion: nil)
    }
}


