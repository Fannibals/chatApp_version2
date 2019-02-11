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
        self.view.backgroundColor = #colorLiteral(red: 0.9607843161, green: 0.7058823705, blue: 0.200000003, alpha: 1)
        self.navigationController?.navigationBar.isHidden = true
        self.view.addSubview(self.topView)
        self.topView.addSubview(self.drawerBtn)
        self.topView.addSubview(self.channelLbl)
        self.view.addSubview(self.tableView)
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
            make.centerX.equalToSuperview().offset(10)
            make.centerY.equalToSuperview().offset(20)
            make.size.equalTo(CGSize(width: 120, height: 40))
        }
        
        self.tableView.snp.makeConstraints { (make) in
            make.top.equalTo(self.topView.snp.bottom)
            make.left.right.equalToSuperview()
            make.bottom.equalToSuperview().offset(40)
        }
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
        label.textColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        return label
    }()
    
    lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.backgroundColor = UIColor.clear
        return tableView
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
    }
    
}

