//
//  Channnel.swift
//  Chat-Version2
//
//  Created by Ethan  on 10/2/19.
//  Copyright © 2019 Ethan . All rights reserved.
//

import Foundation

struct Channel {
    public private(set) var channelName : String!
    public private(set) var channelDescription : String!
    public private(set) var id: String!
    
    init(_ name: String, _ description: String, _ id: String) {
        self.channelName = name
        self.channelDescription = description
        self.id = id
    }
}
