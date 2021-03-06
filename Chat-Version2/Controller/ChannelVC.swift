//
//  ChannelVC.swift
//  Chat-Version2
//
//  Created by Ethan  on 31/1/19.
//  Copyright © 2019 Ethan . All rights reserved.
//

import UIKit
import SnapKit

class ChannelVC: UIViewController {
    
    // variables
    var avatarName: String = ""
    var userName: String = "Please Log In"

    // MARK: life-cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setUI()
        setLayout()
        setNotif()
        setChannelView()
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        setUserInfo()
    }
    
    // MARK: set UI
    func setUI() {
        self.view.backgroundColor = #colorLiteral(red: 0.2392156869, green: 0.6745098233, blue: 0.9686274529, alpha: 1)
        self.navigationController?.navigationBar.isHidden = true
        self.view.addSubview(self.appTitle)
        self.view.addSubview(self.subTitles)
        self.view.addSubview(self.channelTableView)
        self.view.addSubview(self.avatarImgView)
        self.view.addSubview(self.loginBtn)
        self.view.addSubview(self.addChannelBtn)
        self.channelTableView.delegate = self
        self.channelTableView.dataSource = self
    }
    
    func setLayout() {
        self.appTitle.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(60)
            make.left.equalToSuperview().offset(20)
            make.size.equalTo(CGSize(width: 90, height: 40))
        }
        
        self.subTitles.snp.makeConstraints { (make) in
            make.top.equalTo(self.appTitle.snp.bottom).offset(10)
            make.left.equalTo(self.appTitle.snp.left)
            make.size.equalTo(CGSize(width: 90, height: 40))
        }
        
        self.channelTableView.snp.makeConstraints { (make) in
            make.top.equalTo(self.subTitles.snp.bottom).offset(10)
            make.left.right.equalToSuperview()
            make.bottom.equalTo(self.avatarImgView.snp.top).offset(-10)
        }
        
        self.avatarImgView.snp.makeConstraints { (make) in
            make.left.equalTo(self.appTitle.snp.left)
            make.bottom.equalToSuperview().offset(-30)
            make.size.equalTo(CGSize(width: 70, height: 70))
        }
        self.avatarImgView.layer.cornerRadius = 70 / 2.0
        
        self.loginBtn.snp.makeConstraints { (make) in
            make.left.equalTo(self.avatarImgView.snp.right).offset(10)
            make.centerY.equalTo(self.avatarImgView.snp.centerY)
            make.size.equalTo(CGSize(width: 150, height: 40))
        }
        
        self.addChannelBtn.snp.makeConstraints { (make) in
            make.centerY.equalTo(self.subTitles.snp.centerY)
            make.right.equalToSuperview().offset(-SCREEN_WIDTH*(1.0/5.0))
            make.size.equalTo(CGSize(width: 30, height: 30))
        }
    }
    
    // MARK: Lazy init
    lazy var appTitle: UILabel = {
        let label = UILabel()
        label.text = "Chat APP"
        label.font = UIFont(name: "AvenirNext-Bold", size: 20)
        label.textColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        return label
    }()
    
    lazy var subTitles: UILabel = {
        let label = UILabel()
        label.text = "CHANNELS"
        label.font = UIFont(name: "AvenirNext", size: 17)
        label.textColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        return label
    }()
    
    lazy var channelTableView: UITableView = {
        let tableView = UITableView()
        tableView.backgroundColor = UIColor.clear
        tableView.register(ChannelCell.self, forCellReuseIdentifier: "channelCell")
        return tableView
    }()
    
    lazy var avatarImgView: UIImageView = {
        let imgView = UIImageView()
        imgView.image = UIImage(named: avatarName)
        if avatarName == "" {
            imgView.backgroundColor = #colorLiteral(red: 0.7450980544, green: 0.1568627506, blue: 0.07450980693, alpha: 1)
        }
        return imgView
    }()
    
    lazy var loginBtn: UIButton = {
        let name = UIButton()
        name.setTitle(userName, for: .normal)
        name.setTitleColor(#colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0), for: .normal)
        name.setTitleColor(#colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1), for: UIControl.State.highlighted)
        name.titleLabel?.font = UIFont(name: "AvenirNext-Bold", size: 20)!
        name.addTarget(self, action: #selector(loginBtnPressed), for: .touchUpInside)
        return name
    }()
    
    lazy var addChannelBtn: UIButton = {
        let btn = UIButton()
        btn.setImage(UIImage(named: "addChannelButton"), for: .normal)
        btn.addTarget(self, action: #selector(addChannelBtnPressed), for: .touchUpInside)
        return btn
    }()
    
    // MARK: Actions
    @objc func loginBtnPressed() {
        if AuthService.instance.isLoggedIn {
            // UIModalPresentationStyle ???
            let profileVC = ProfileVC()
            profileVC.modalPresentationStyle = UIModalPresentationStyle.overCurrentContext
            present(profileVC, animated: true, completion: nil)
        } else {
            present(LoginVC(), animated: true, completion: nil)
        }
    }
    
    @objc func addChannelBtnPressed() {
        if AuthService.instance.isLoggedIn {
            let channelVC = AddChannelVC()
            channelVC.modalPresentationStyle = UIModalPresentationStyle.overCurrentContext
            present(channelVC, animated: true, completion: nil)
        } else {
            // do nothing
        }
    }
    
    @objc func userDataChanged( _ notif: Notification) {
        setUserInfo()
    }
    
    @objc func channelLoaded( _ notif: Notification){
        self.channelTableView.reloadData()
    }
    
    // functions
    func setUserInfo() {
        if AuthService.instance.isLoggedIn {
            self.avatarImgView.image = UIImage(named: UserDataService.instance.avatarName)
            self.avatarImgView.backgroundColor = UserDataService.instance.returnUIColor(components: UserDataService.instance.avatarColor)
            self.loginBtn.setTitle(UserDataService.instance.name, for: .normal)
        } else {
            self.avatarImgView.image = UIImage(named: "profileDefault")
            self.avatarImgView.backgroundColor = UIColor.clear
            self.loginBtn.setTitle(userName, for: .normal)
        }
    }
    
    // set notifications
    func setNotif() {
        NotificationCenter.default.addObserver(self, selector: #selector(userDataChanged(_:)), name: NOTIF_USERDATA_CHANGED, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(channelLoaded(_:)), name: NOTIF_CHANNEL_LOADED, object: nil)
    }
    
    func setChannelView() {
        SocketService.instance.getChannel { (success) in
            if success {
                self.channelTableView.reloadData()
            }
        }
    }
}


extension ChannelVC : UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return MessageService.instance.channels.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = self.channelTableView.dequeueReusableCell(withIdentifier: "channelCell", for: indexPath) as? ChannelCell {
            let channel = MessageService.instance.channels[indexPath.row]
            cell.configureCell(channel: channel)
            cell.backgroundColor = UIColor.clear
            return cell
        }
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let channel = MessageService.instance.channels[indexPath.row]
        MessageService.instance.selectedChannel = channel
        
        NotificationCenter.default.post(name: NOTIF_CHANNEL_SELECTED, object: nil)
        self.revealViewController()?.revealToggle(animated: true)
    }
    
    
    
}
