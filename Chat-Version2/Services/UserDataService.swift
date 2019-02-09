//
//  UserDataService.swift
//  Chat-Version2
//
//  Created by Ethan  on 31/1/19.
//  Copyright © 2019 Ethan . All rights reserved.
//

// U

import Foundation

class UserDataService {
    
    static let instance = UserDataService()
    
    // MARK: variables
    public private(set) var id = ""
    public private(set) var name = ""
    public private(set) var email = ""
    public private(set) var avatarName = ""
    public private(set) var avatarColor = ""
    
    // init the user data
    func setUserData(id: String, name: String, email: String, avatarName: String, avatarColor: String ) {
        self.id = id
        self.name = name
        self.email = email
        self.avatarName = avatarName
        self.avatarColor = avatarColor
    }
    
    func setAvatarName(name: String) {
        self.avatarName = name
    }
    
    func returnUIColor(components: String) -> UIColor {
        // "[0.8313725490196079,0.9333333333333333,0.8117647058823529,1.0]",
        if components == "hexValue" {
            return UIColor.white
        }
        if components.count > 0 {
            var myArr = components.split(separator: ",")
            myArr[0] = myArr[0].dropFirst()
            myArr[3] = myArr[3].dropLast()
            let rfloat = CGFloat(Float(myArr[0])!)
            let gfloat = CGFloat(Float(myArr[1])!)
            let bfloat = CGFloat(Float(myArr[2])!)
            let afloat = CGFloat(Float(myArr[3])!)
            
            let newUIColor = UIColor(red: rfloat, green: gfloat, blue: bfloat, alpha: afloat)
            return newUIColor
        }else {
            return UIColor.lightGray
        }
    }
    
    func logoutUser() {
        id = ""
        avatarName = ""
        avatarColor = ""
        email = ""
        name = ""
        AuthService.instance.userEmail = ""
        AuthService.instance.authToken = ""
    }
}

