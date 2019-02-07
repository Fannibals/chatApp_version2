//
//  Window.swift
//  Chat-Version2
//
//  Created by Ethan  on 8/2/19.
//  Copyright © 2019 Ethan . All rights reserved.
//

import UIKit

class Window: UIView {
    override init(frame: CGRect) {
        super.init(frame: frame)
        setView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setView() {
        self.backgroundColor = UIColor.clear
        let view2 = UIView(frame: CGRect(x: 0, y: 0, width: self.frame.width, height: self.frame.height))
        view2.backgroundColor = UIColor.init(red: 200.0/255.0, green: 200.0/255.0, blue: 200.0/255.0, alpha: 0.4)
        self.addSubview(view2)
    }
}
