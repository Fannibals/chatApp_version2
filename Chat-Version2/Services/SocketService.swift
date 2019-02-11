//
//  SocketService.swift
//  Chat-Version2
//
//  Created by Ethan  on 10/2/19.
//  Copyright © 2019 Ethan . All rights reserved.
//

import UIKit
import SocketIO

class SocketService: NSObject {
    
    static let instance = SocketService()
    
    override init() {
        super.init()
    }
    
    let manager = SocketManager(socketURL: URL(string: BASE_URL)!)
    lazy var socket: SocketIOClient = manager.defaultSocket
    
    // on and off
    func establishConnection() {
        socket.connect()
    }
    
    func closeConnection() {
        socket.disconnect()
    }
    
    func addChannel(channelName: String, channelDescription: String, completion: @escaping CompletionHandler) {
        socket.emit("newChannel", channelName, channelDescription)
        completion(true)
    }
    
    func getChannel(completion: @escaping CompletionHandler) {
        socket.on("channelCreated") { (dataArray, ack) in
            print("dataArray: \(dataArray)")
            guard let name = dataArray[0] as? String else {return}
            guard let desc = dataArray[1] as? String else {return}
            guard let id = dataArray[2] as? String else {return}
            let channel = Channel(name, desc, id)
            MessageService.instance.channels.append(channel)
        }
    }
}
