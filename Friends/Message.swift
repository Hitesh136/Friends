//
//  Message.swift
//  Friends
//
//  Created by Hitesh Agarwal on 30/11/19.
//  Copyright © 2019 Hitesh  Agarwal. All rights reserved.
//

import Foundation

enum MessageType {
    case receivedText
    case sendedText
}

struct Message {
    let text: String
    let messageType: MessageType
}
