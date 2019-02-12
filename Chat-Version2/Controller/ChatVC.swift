//
//  ChatVC.swift
//  Chat-Version2
//
//  Created by Ethan  on 31/1/19.
//  Copyright © 2019 Ethan . All rights reserved.
//

import UIKit
import SnapKit

class ChatVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        setUI()
        setLayout()
        setNotIF()
    }
    
    func setNotIF() {
        view.bindToKeyboard()
        self.tableView.delegate = self
        self.tableView.dataSource = self
        
        //
        if AuthService.instance.isLoggedIn {
            AuthService.instance.findUser(completion: { (success) in
                NotificationCenter.default.post(name: NOTIF_USERDATA_CHANGED, object: nil)
            })
        }
        
        NotificationCenter.default.addObserver(self, selector: #selector(userDidChanged(_:)), name: NOTIF_USERDATA_CHANGED, object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(channelSelected(_:)), name: NOTIF_CHANNEL_SELECTED, object: nil)
    }

    
    func setUI() {
        self.view.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        self.navigationController?.navigationBar.isHidden = true
        self.view.addSubview(self.topView)
        self.topView.addSubview(self.drawerBtn)
        self.topView.addSubview(self.channelLbl)
        self.view.addSubview(self.tableView)
        self.view.addSubview(self.msgInputBox)
//        self.msgInputBox.addSubview(self.sendBtn)
        self.msgInputBox.rightView = self.sendBtn
        self.msgInputBox.rightViewMode = .always
    }
    
    func setLayout(){
        self.drawerBtn.snp.makeConstraints { (make) in
            make.size.equalTo(CGSize(width: 20, height: 20))
            make.centerY.equalToSuperview().offset(20)
            make.left.equalToSuperview().offset(20)
        }
        
        self.topView.snp.makeConstraints { (make) in
            make.height.equalTo(120)
            make.top.left.right.equalToSuperview()
        }
        
        self.channelLbl.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview().offset(20)
            make.size.equalTo(CGSize(width: 120, height: 40))
        }
        
        self.tableView.snp.makeConstraints { (make) in
            make.top.equalTo(self.topView.snp.bottom)
            make.left.right.equalToSuperview()
            make.bottom.equalTo(self.msgInputBox.snp.top)
        }
        
        self.msgInputBox.snp.makeConstraints { (make) in
            make.left.right.bottom.equalToSuperview()
            make.top.equalTo(self.view.snp.bottom).offset(-STATUS_BAR_HEIGHT-30)
        }
        
//        self.sendBtn.snp.makeConstraints { (make) in
//            make.centerY.equalToSuperview()
//            make.right.equalToSuperview().offset(-5)
//            make.size.equalTo(CGSize(width: 30, height: 30))
//        }
    }
    
    // MARK: UI parts initialization
    lazy var drawerBtn: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "smackBurger"), for: .normal)
        button.addTarget(self.revealViewController(), action: #selector(SWRevealViewController.revealToggle(_:)), for: .touchUpInside)
        return button
    }()
    
    lazy var topView: UIView = {
        let view = UIView()
        view.backgroundColor = #colorLiteral(red: 0.5843137503, green: 0.8235294223, blue: 0.4196078479, alpha: 1)
        return view
    }()
    
    lazy var channelLbl: UILabel = {
        let label = UILabel()
        label.text = "Chat APP"
        label.font = UIFont(name: "AvenirNext-Bold", size: 22)
        label.textAlignment = .center
        label.textColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        return label
    }()
    
    lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.backgroundColor = UIColor.clear
        tableView.register(MessageCell.self, forCellReuseIdentifier: "MessageCell")
        return tableView
    }()
    
    lazy var msgInputBox: UITextField = {
        let msg = UITextField()
        msg.placeholder = "Message:"
        msg.borderStyle = .roundedRect
        msg.isUserInteractionEnabled = true
        return msg
    }()
    
    lazy var sendBtn: UIButton = {
        let btn = UIButton(frame: CGRect(x: -10, y: 0, width: 50, height: 30))
        btn.setImage(UIImage(named: "send"), for: .normal)
        btn.addTarget(self, action: #selector(sendBtnPressed), for: .touchUpInside)
        return btn
    }()
    
    // MARK: actions
    @objc func userDidChanged(_ notif: Notification) {
        AuthService.instance.findUser { (success) in
            if success {
                MessageService.instance.findAllChannel(completion: { (success) in
                    if success {
                        
                    }
                })
            }
        }
    }
    
    @objc func channelSelected(_ notif: Notification) {
        guard let channelName = MessageService.instance.selectedChannel?.channelName else {return}
        self.channelLbl.text = "#\(channelName)"
        
        MessageService.instance.findAllMessages { (success) in
            if success {
                self.tableView.reloadData()
            }
        }
    }
    
    @objc func sendBtnPressed() {
        print(123)
        self.view.endEditing(true)
        if AuthService.instance.isLoggedIn {
            guard let channelId = MessageService.instance.selectedChannel?.id else { return }
            guard let message = msgInputBox.text else { return }
            
            SocketService.instance.addMessage(messageBody: message, userId: UserDataService.instance.id, channelId: channelId, completion: { (success) in
                if success {
                    self.msgInputBox.text = ""
                    self.msgInputBox.resignFirstResponder()
                    MessageService.instance.findAllMessages { (success) in
                        if success {
                            self.tableView.reloadData()
                        }
                    }
//                    self.messageTxtBox.resignFirstResponder()
//                    SocketService.instance.socket.emit("stopType", UserDataService.instance.name, channelId)
                }
            })
        }
    }
}

extension ChatVC: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return MessageService.instance.messages.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = self.tableView.dequeueReusableCell(withIdentifier: "MessageCell", for: indexPath) as? MessageCell {
            let message = MessageService.instance.messages[indexPath.row]
            cell.configureCell(message: message)
            return cell
        }
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return SCREEN_HEIGHT*(1.5/20.0)
    }
}

