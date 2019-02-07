//
//  AvatarVC.swift
//  Chat-Version2
//
//  Created by Ethan  on 7/2/19.
//  Copyright © 2019 Ethan . All rights reserved.
//

import UIKit
import SnapKit

class AvatarVC: UIViewController {
    
    var avatarType: AvatarType = .dark

    override func viewDidLoad() {
        super.viewDidLoad()
        setUI()
        setLayout()
    }
    
    // MARK: set UI
    func setUI() {
        self.view.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        self.view.addSubview(self.backBtn)
        self.view.addSubview(self.dark_light)
        self.view.addSubview(self.collectionView)
        self.collectionView.delegate = self
        self.collectionView.dataSource = self
    }
    
    func setLayout() {
        self.backBtn.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(STATUS_BAR_HEIGHT+10)
            make.left.equalToSuperview().offset(10)
            make.size.equalTo(CGSize(width: 30, height: 30))
        }
        
        self.dark_light.snp.makeConstraints { (make) in
            make.centerY.equalTo(self.backBtn.snp.centerY)
            make.centerX.equalToSuperview()
            make.size.equalTo(CGSize(width: SCREEN_WIDTH*(1.0/3.0), height: 30))
        }
        
        self.collectionView.snp.makeConstraints { (make) in
            make.top.equalTo(self.dark_light.snp.bottom).offset(20)
            make.left.equalToSuperview().offset(10)
            make.right.equalToSuperview().offset(-10)
            make.bottom.equalToSuperview()
        }
    }
    
    // control parts init
    lazy var backBtn: UIButton = {
        let btn = UIButton()
        btn.setImage(UIImage(named: "smackBack"), for: .normal)
        btn.addTarget(self, action: #selector(backBtnPressed), for: .touchUpInside)
        return btn
    }()
    
    lazy var dark_light: UISegmentedControl = {
        let tags = ["Dark","Light"] as [Any]
        let segmented = UISegmentedControl(items: tags)
        segmented.selectedSegmentIndex = 0
        segmented.addTarget(self, action: #selector(segmentDidChange(_:)), for: .valueChanged) // valuechanged not touchUpinside
        return segmented
    }()
    
    lazy var collectionView: UICollectionView = {
        var layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: SCREEN_WIDTH/5.0, height: SCREEN_WIDTH/5.0)
        
        let collectionView = UICollectionView(frame: CGRect(x: 0, y: 0, width: SCREEN_WIDTH, height: SCREEN_HEIGHT), collectionViewLayout: layout)
        collectionView.register(AvatarImgCell.self, forCellWithReuseIdentifier:"AvatarImgCell")
        collectionView.backgroundColor = UIColor.clear
        return collectionView
    }()
    
    
    // MARK: actions
    @objc func segmentDidChange(_ sender: UISegmentedControl) {
        
        if dark_light.selectedSegmentIndex == 0 {
            self.avatarType = .dark
        } else {
            self.avatarType = .light
        }
        self.collectionView.reloadData()
    }
    
    @objc func backBtnPressed() {
        dismiss(animated: true, completion: nil)
    }
    
}

extension AvatarVC: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 28
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if let cell = self.collectionView.dequeueReusableCell(withReuseIdentifier: "AvatarImgCell", for: indexPath) as? AvatarImgCell {
            cell.configureCell(index: indexPath.item, type: self.avatarType)
            return cell
        }
        return AvatarImgCell()
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        if self.avatarType == .dark {
            UserDataService.instance.setAvatarName(name:"dark\(indexPath.item)")
        } else {
            UserDataService.instance.setAvatarName(name:"light\(indexPath.item)")
        }
        
        dismiss(animated: true, completion: nil)
    }
}
