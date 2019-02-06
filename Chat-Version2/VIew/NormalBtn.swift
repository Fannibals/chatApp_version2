//
//  NormalBtn.swift
//  Chat-Version2
//
//  Created by Ethan  on 4/2/19.
//  Copyright © 2019 Ethan . All rights reserved.
//

import UIKit

class NormalBtn: UIButton {
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
        self.layer.cornerRadius = 5.0
        self.backgroundColor = #colorLiteral(red: 0.1764705926, green: 0.4980392158, blue: 0.7568627596, alpha: 1)
        self.setTitleColor(#colorLiteral(red: 1, green: 1, blue: 1, alpha: 1), for: .normal)
        self.setTitleColor(#colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1), for: UIControl.State.highlighted)
        self.titleLabel?.font = UIFont(name: "AvenirNext-Bold", size: 20)
    }
}
