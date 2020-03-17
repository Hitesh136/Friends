//
//  TabViewControllerTableViewController.swift
//  Friends
//
//  Created by Hitesh  Agarwal on 01/12/19.
//  Copyright © 2019 Hitesh  Agarwal. All rights reserved.
//

import UIKit
import Firebase
import XMPPFramework

class AppTabBarController: UITabBarController {
	
    var handle: AuthStateDidChangeListenerHandle!
    var xmppStream: XMPPStream!
    
    var hostName: String!
    var userJID: XMPPJID!
    var hostPort: UInt16!
    var password: String!
    
	override func viewDidLoad() {
		super.viewDidLoad()
		
		tabBar.tintColor = UIColor(named: "AppBlue")
		loadViewControllersView()
		setTabBarItems()
        
        do {
            try configure_XMPP(hostName: "host.com", userJIDString: "user@host.com", password: "password")
        } catch let error {
            print(error)
        }
	}
	
	func setTabBarItems() {
		let callTabItem = self.tabBar.items![0]
		callTabItem.image = #imageLiteral(resourceName: "call")
		callTabItem.selectedImage = #imageLiteral(resourceName: "call").withRenderingMode(.alwaysTemplate)
		callTabItem.title = "Calls"
		
		let chatTabItem = self.tabBar.items![1]
		chatTabItem.image = #imageLiteral(resourceName: "chat")
		chatTabItem.selectedImage = #imageLiteral(resourceName: "chat").withRenderingMode(.alwaysTemplate)
		chatTabItem.title = "Chats"
		
		let settingTabItem = self.tabBar.items![2]
		settingTabItem.image = #imageLiteral(resourceName: "settings")
		settingTabItem.selectedImage = #imageLiteral(resourceName: "settings").withRenderingMode(.alwaysTemplate)
		settingTabItem.title = "Setting"
		
		selectedIndex = 1
	}
	
	func loadViewControllersView() {
		for viewController in viewControllers ?? [] {
			_ = viewController.view
		}
	}
    
    func configure_XMPP(hostName: String,
         userJIDString: String,
         hostPort: UInt16 = 5222,
         password: String) throws {
        
        guard let userJID = XMPPJID(string: userJIDString) else {
            throw XMPPControllerError.wrongUserJID
        }
    
        self.hostName = hostName
        self.userJID = userJID
        self.hostPort = hostPort
        self.password = password
        
        xmppStream = XMPPStream()
        xmppStream.hostName = hostName
        xmppStream.myJID = userJID
        xmppStream.hostPort = hostPort
        xmppStream.startTLSPolicy = XMPPStreamStartTLSPolicy.allowed
        
//        super.init()
        xmppStream.addDelegate(self, delegateQueue: DispatchQueue.main)
        connect()
    }
}
