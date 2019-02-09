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

// URL request attributes
let BASE_URL = "https://chatforexercise.herokuapp.com/v1/"
let URL_REGISTER = "\(BASE_URL)account/register"
let URL_LOGIN = "\(BASE_URL)account/login"
let URL_ADDUSER = "\(BASE_URL)user/add"
let URL_FINDBYEMAIL = "\(BASE_URL)user/byEmail/"

// NOTIF
let NOTIF_USERDATA_CHANGED = Notification.Name("notifUserDataChanged")

// Header
let HEADER = [ "Content-Type": "application/json; charset=utf-8" ]

