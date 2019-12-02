//
//  SettingViewController.swift
//  Friends
//
//  Created by Hitesh  Agarwal on 02/12/19.
//  Copyright © 2019 Hitesh  Agarwal. All rights reserved.
//

import UIKit
import Firebase

class SettingViewController: BaseViewController {
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		// Do any additional setup after loading the view.
	}
	
	@IBAction func actionLogout(_ sender: Any) {
		do {
			try Auth.auth().signOut()
			appDelegate.redirectToViewController()
		} catch let error {
			print("SingOut Error:\(error)")
		}
	}
}
