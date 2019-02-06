//
//  LetterBtn.swift
//  Chat-Version2
//
//  Created by Ethan  on 7/2/19.
//  Copyright © 2019 Ethan . All rights reserved.
//

import UIKit

class LetterBtn: UIButton {
    var myValue : Int
    
    required init(value: Int = 0) {
        // set myValue before super.init is called
        self.myValue = value
        
        super.init(frame: .zero)
        
        setUpView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setUpView() {
        btn.backgroundColor = UIColor.clear
        
        btn.setTitleColor(#colorLiteral(red: 0.1764705926, green: 0.4980392158, blue: 0.7568627596, alpha: 1), for: .normal)
        btn.setTitleColor(#colorLiteral(red: 0.2392156869, green: 0.6745098233, blue: 0.9686274529, alpha: 1), for: UIControl.State.highlighted)
        btn.titleLabel?.font = UIFont(name: "AvenirNext", size: 14)
    }
}
