//
//  AuthService.swift
//  Chat-Version2
//
//  Created by Ethan  on 31/1/19.
//  Copyright © 2019 Ethan . All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

class AuthService {
    static let instance = AuthService()
    
    // user default
    let defaults = UserDefaults.standard
    
    var authToken: String {
        get {
            return defaults.value(forKey: "token") as! String
        }
        set {
            defaults.set(newValue, forKey: "token")
        }
    }
    
    var userEmail: String {
        get {
            return defaults.value(forKey: "email") as! String
        }
        set {
            defaults.set(newValue, forKey: "email")
        }
    }
    
    
    
    func registerUser(email: String, password: String, completion: @escaping (_ Success: Bool) -> ()) {
        
        let lowercasedEmail = email.lowercased()
        
        let body:[String:Any] = [
            "email": lowercasedEmail,
            "password": password
        ]
        
        Alamofire.request(URL_REGISTER, method: .post, parameters: body, encoding: JSONEncoding.default, headers: HEADER).responseString { (response) in
            print(response)
            print(type(of: response))
            if response.result.error == nil {
                completion(true)
            } else {
                completion(false)
                debugPrint(response.result.error as Any)
            }
        }
    }
    
    func loginUser(email: String, password: String, completion: @escaping CompletionHandler) {
        
        let lowercasedEmail = email.lowercased()
        
        let body:[String:Any] = [
            "email": lowercasedEmail,
            "password": password
        ]
        
        Alamofire.request(URL_LOGIN, method: .post, parameters: body, encoding: JSONEncoding.default, headers: HEADER).responseJSON{ (response) in
            print(response)
            print(type(of: response))
            if response.result.error == nil {
                guard let data = response.data else {return}
                let json = try! JSON(data: data)
                self.authToken = json["token"].stringValue
                self.userEmail = json["user"].stringValue
                
                completion(true)
            } else {
                completion(false)
                debugPrint(response.result.error as Any)
            }
        }
    }
}
