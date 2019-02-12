//
//  Constants.swift
//  Chat-Version2
//
//  Created by Ethan  on 31/1/19.
//  Copyright © 2019 Ethan . All rights reserved.
//

import Foundation

typealias CompletionHandler = (_ Success: Bool) -> ()

// screen size

let SCREEN_SIZE = UIScreen.main.bounds
let SCREEN_WIDTH = UIScreen.main.bounds.width
let SCREEN_HEIGHT = UIScreen.main.bounds.height

let STATUS_BAR_HEIGHT = UIApplication.shared.statusBarFrame.size.height

let PROFILE_WIDTH = SCREEN_WIDTH * (9.0/10.0)
let PROFILE_HEIGHT = SCREEN_HEIGHT * (1.3/3.0)

// URL request attributes
let BASE_URL = "https://chatforexercise.herokuapp.com/v1/"
let URL_REGISTER = "\(BASE_URL)account/register"
let URL_LOGIN = "\(BASE_URL)account/login"
let URL_ADDUSER = "\(BASE_URL)user/add"
let URL_FINDBYEMAIL = "\(BASE_URL)user/byEmail/"
let URL_FIND_CHANNELS = "\(BASE_URL)channel"
let URL_FIND_MESSAGES = "\(BASE_URL)message/byChannel/"

// NOTIF
let NOTIF_USERDATA_CHANGED = Notification.Name("notifUserDataChanged")
let NOTIF_CHANNEL_LOADED = Notification.Name("notifChannelLoaded")
let NOTIF_CHANNEL_SELECTED = Notification.Name("notifChannelSelected")

// Header
let HEADER = [ "Content-Type": "application/json; charset=utf-8" ]
let BEARER_HEADER: [String: String] = [
    "Authorization": "Bearer \(AuthService.instance.authToken)",
    "Content-Type": "application/json; charset=utf-8"
]


