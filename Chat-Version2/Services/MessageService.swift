//
//  MessageService.swift
//  Chat-Version2
//
//  Created by Ethan  on 10/2/19.
//  Copyright © 2019 Ethan . All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

class MessageService {
    static let instance = MessageService()
    
    var channels = [Channel]()
    var selectedChannel : Channel?
    var messages = [Message]()
    
    func findAllChannel(completion: @escaping CompletionHandler) {
        Alamofire.request(URL_FIND_CHANNELS, method: .get, parameters: nil, encoding: JSONEncoding.default, headers: BEARER_HEADER).responseJSON { (response) in
            print(response)
            if response.result.error == nil {
                guard let data = response.data else {return}
                if let json = try! JSON(data: data).array {
                    for item in json {
                        let name = item["name"].stringValue
                        let description = item["description"].stringValue
                        let id = item["_id"].stringValue
                        
                        let channel = Channel(name, description, id)
                        self.channels.append(channel)
                    }
                }
                NotificationCenter.default.post(name: NOTIF_CHANNEL_LOADED, object: nil)
                completion(true)
            }else {
                completion(false)
                debugPrint(response.result.error as Any)
            }
        }
    }
    
    func findAllMessages(completion: @escaping CompletionHandler) {
        guard let idSelected = self.selectedChannel?.id else {return}
        Alamofire.request("\(URL_FIND_MESSAGES)\(idSelected)", method: .get, parameters: nil, encoding: JSONEncoding.default, headers: BEARER_HEADER).responseJSON { (response) in
            print(response)
            if response.result.error == nil {
                self.clearMessages()
                guard let data = response.data else {return}
                if let json = try! JSON(data: data).array {
                    for item in json {
//                        let id = item["_id"].stringValue
                        let content = item["messageBody"].stringValue
                        let userId = item["userId"].stringValue
                        let channelId = item["channelId"].stringValue
                        let userName = item["userName"].stringValue
                        let userAvatar = item["userAvatar"].stringValue
                        let avaColor = item["userAvatarColor"].stringValue
                        let timeStamp = item["timeStamp"].stringValue
                     
                        let message = Message.init(message: content, userName: userName, channelId: channelId, userAvatar: userAvatar, userAvatarColor: avaColor, id: userId, timeStamp: timeStamp)
                        self.messages.append(message)
                    }
                }
                completion(true)
            } else {
                debugPrint(response.result.error as Any)
                completion(false)
            }
        }
    }
    
    func clearMessages() {
        messages.removeAll()
    }
    
    func clearChannels() {
        channels.removeAll()
    }
}
