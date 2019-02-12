//
//  MessageCell.swift
//  Chat-Version2
//
//  Created by Ethan  on 12/2/19.
//  Copyright © 2019 Ethan . All rights reserved.
//

import UIKit
import SnapKit

class MessageCell: UITableViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    // set up view
    func setupView() {
        self.addSubview(self.imgView)
        self.addSubview(self.name)
        self.addSubview(self.timeStamp)
        self.addSubview(self.content)
        
        let cell_height = self.frame.height
        let cell_width = self.frame.width
        
        self.imgView.snp.makeConstraints { (make) in
            make.left.equalToSuperview().offset(10)
            make.centerY.equalToSuperview()
            make.size.equalTo(CGSize(width: cell_height*(4.9/5.0), height: cell_height*(4.9/5.0)))
        }
        self.imgView.layer.cornerRadius = cell_height*(2.75/5.0)
        
        self.name.snp.makeConstraints { (make) in
            make.top.equalTo(self.imgView.snp.top)
            make.left.equalTo(self.imgView.snp.right).offset(10)
            make.size.equalTo(CGSize(width: cell_width*(1.0/5.0), height: cell_height*(2.0/5.0)))
        }
        
        self.timeStamp.snp.makeConstraints { (make) in
            make.top.equalTo(self.imgView.snp.top)
            make.left.equalTo(self.name.snp.right)
            make.size.equalTo(CGSize(width: cell_width*(3.0/5.0), height: cell_height*(1.5/5.0)))
        }
        
        self.content.snp.makeConstraints { (make) in
            make.bottom.equalTo(self.imgView.snp.bottom)
            make.left.equalTo(self.name.snp.left)
            make.size.equalTo(CGSize(width: cell_width*(4.0/5.0), height: cell_height*(2.0/5.0)))
        }
        
    }
    
    //lazy init
    lazy var imgView: UIImageView = {
        let img = UIImageView()
        img.backgroundColor = UIColor.orange
        return img
    }()
    
    lazy var name: UILabel = {
        let name = UILabel()
        name.textColor = #colorLiteral(red: 0.06274510175, green: 0, blue: 0.1921568662, alpha: 1)
        name.font = UIFont(name: "AvenirNext-Bold", size: 14)
        return name
    }()
    
    lazy var timeStamp: UILabel = {
        let time = UILabel()
        time.textColor = #colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1)
        time.font = UIFont(name: "AvenirNext", size: 6)
        return time
    }()
    
    lazy var content: UILabel = {
        let content = UILabel()
        content.textColor = #colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1)
        content.font = UIFont(name: "AvenirNext", size: 12)
        return content
    }()
    
    func configureCell(message: Message) {
        self.imgView.image = UIImage(named: message.userAvatar)
        self.imgView.backgroundColor = UserDataService.instance.returnUIColor(components: message.userAvatarColor)
        self.name.text = message.userName
        self.content.text = message.message
        
        // timeStamp
        guard var isoTime = message.timeStamp else {return}
        let endIndex = isoTime.index(isoTime.endIndex, offsetBy: -5)
        isoTime = isoTime.substring(to: endIndex)
        
        let chatTime = ISO8601DateFormatter().date(from: isoTime.appending("Z"))
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMM d, h:mm a"
    
        let finalTime = dateFormatter.string(from: chatTime!)
        self.timeStamp.text = finalTime
        self.timeStamp.font = UIFont(name: "Regular", size: 8)
    }
}
