//
//  CommonClass.swift
//  Friends
//
//  Created by Hitesh  Agarwal on 01/12/19.
//  Copyright © 2019 Hitesh  Agarwal. All rights reserved.
//

import Foundation
import SVProgressHUD

func showLoader() {
	SVProgressHUD.show()
}

func hideLoader() {
	SVProgressHUD.dismiss()
}

class CommonClass {
	static func getInitialViewController() -> UIViewController {
		if UserDefaults.isLogined {
			let storyboard = UIStoryboard(name: "Main", bundle: nil)
			return  storyboard.instantiateViewController(withIdentifier: "AppTabBarController") as! AppTabBarController
		} else {
			let storyboard = UIStoryboard(name: "Login", bundle: nil)
			let loginViewController = storyboard.instantiateViewController(withIdentifier: "LoginViewController") as! LoginViewController
			return UINavigationController(rootViewController: loginViewController)
		}
	}
}


