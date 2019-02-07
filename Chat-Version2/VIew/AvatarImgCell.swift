//
//  AvatarImgCell.swift
//  Chat-Version2
//
//  Created by Ethan  on 7/2/19.
//  Copyright © 2019 Ethan . All rights reserved.
//

import UIKit

enum AvatarType {
    case dark
    case light
}

class AvatarImgCell: UICollectionViewCell {
    override init(frame: CGRect) {
        super.init(frame: frame)
        setView()
    }
    
    func configureCell(index: Int, type: AvatarType) {
        if type == .dark {
            self.imgView.image = UIImage(named: "dark\(index)")
        } else {
            self.imgView.image = UIImage(named: "light\(index)")
        }
    }
    
    func setView() {
        self.addSubview(imgView)
        self.backgroundColor = #colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1)
        self.layer.cornerRadius = 5.0
    }
    
    lazy var imgView: UIImageView = {
        let imgView = UIImageView(frame:CGRect(x: 0, y: 0, width: self.frame.width, height: self.frame.height))
        return imgView
    }()
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

