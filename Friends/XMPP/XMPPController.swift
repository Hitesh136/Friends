//
//  XMPPController.swift
//  Friends
//
//  Created by Hitesh Agarwal on 19/12/19.
//  Copyright © 2019 Hitesh  Agarwal. All rights reserved.
//

import Foundation
import XMPPFramework

enum XMPPControllerError: Error {
    case wrongUserJID
}

extension AppTabBarController {
     
    
    
    func connect() {
        if !xmppStream.isDisconnected {
            return
        }
        
        do {
            
            try xmppStream.connect(withTimeout: XMPPStreamTimeoutNone)
        } catch let error {
            print("\n\nXMPP Connection Error: \(error)\n\n")
        }
    }
}

extension AppTabBarController: XMPPStreamDelegate {
    
    func xmppStreamWillConnect(_ sender: XMPPStream) {
        print("\n\nStream: \("WillConnect to XMPP")")
    }
    
    func xmppStreamDidConnect(_ sender: XMPPStream) {
        print("\n\nStream: Connected")
        do {
            try xmppStream.authenticate(withPassword: self.password)
        } catch let error {
            print("Authenticate Error: \(error)")
        }
    }
    
    func xmppStreamDidAuthenticate(_ sender: XMPPStream) {
        print("\n\nStream: Authenticated")
        xmppStream.send(XMPPPresence())
    }
    
//    func xmppStreamWillConnect(sender: XMPPStream!) {
//        print("will connect")
//    }
    
    func xmppStreamConnectDidTimeout(sender: XMPPStream!) {
        print("timeout:")
    }

    func xmppStream(sender: XMPPStream!, didNotAuthenticate error: DDXMLElement!) {
        print("dint not auth")
        print(error)
    }
}

