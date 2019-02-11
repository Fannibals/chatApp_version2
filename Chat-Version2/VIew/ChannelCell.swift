//
//  ChannelCell.swift
//  Chat-Version2
//
//  Created by Ethan  on 10/2/19.
//  Copyright © 2019 Ethan . All rights reserved.
//

import UIKit
import SnapKit

class ChannelCell: UITableViewCell {
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    func configureCell(channel: Channel) {
        self.channelTitle.text = "#\(channel.channelName!)"
    }
    
    func setupView() {
        self.addSubview(self.channelTitle)
        self.channelTitle.snp.makeConstraints { (make) in
            make.centerY.equalToSuperview()
            make.left.equalToSuperview().offset(20)
        }
    }
    
    lazy var channelTitle: UILabel = {
        let title = UILabel()
        title.textColor = UIColor.white
        return title
    }()

}
