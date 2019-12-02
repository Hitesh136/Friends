//
//  TabViewControllerTableViewController.swift
//  Friends
//
//  Created by Hitesh  Agarwal on 01/12/19.
//  Copyright © 2019 Hitesh  Agarwal. All rights reserved.
//

import UIKit

class AppTabBarController: UITabBarController {
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		tabBar.tintColor = UIColor(named: "AppBlue")
		setTabBarItems()
	}
	
	func setTabBarItems() {
		let callTabItem = self.tabBar.items![0]
		callTabItem.image = #imageLiteral(resourceName: "call")
		callTabItem.selectedImage = #imageLiteral(resourceName: "call").withRenderingMode(.alwaysTemplate)
		
		let chatTabItem = self.tabBar.items![1]
		chatTabItem.image = #imageLiteral(resourceName: "chat")
		chatTabItem.selectedImage = #imageLiteral(resourceName: "chat").withRenderingMode(.alwaysTemplate)
		
		let settingTabItem = self.tabBar.items![2]
		settingTabItem.image = #imageLiteral(resourceName: "settings")
		settingTabItem.selectedImage = #imageLiteral(resourceName: "settings").withRenderingMode(.alwaysTemplate)
	}
}
