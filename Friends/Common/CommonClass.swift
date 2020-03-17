//
//  CommonClass.swift
//  Friends
//
//  Created by Hitesh  Agarwal on 01/12/19.
//  Copyright © 2019 Hitesh  Agarwal. All rights reserved.
//

import Foundation
import SVProgressHUD
import Firebase

func showLoader() {
	SVProgressHUD.show()
}

func hideLoader() {
	SVProgressHUD.dismiss()
}

class CommonClass {
	static func getInitialViewController() -> UIViewController {
        if User.isLogined {
			let storyboard = UIStoryboard(name: "Main", bundle: nil)
			return storyboard.instantiateViewController(withIdentifier: "AppTabBarController") as! AppTabBarController
		} else {
			let storyboard = UIStoryboard(name: "Login", bundle: nil)
			let loginViewController = storyboard.instantiateViewController(withIdentifier: "LoginViewController") as! LoginViewController
			return UINavigationController(rootViewController: loginViewController)
		}
	}
	
	class func topViewController(controller: UIViewController? = UIApplication.shared.keyWindow?.rootViewController) -> UIViewController? {
		if let navigationController = controller as? UINavigationController {
			return topViewController(controller: navigationController.visibleViewController)
		}
		if let tabController = controller as? UITabBarController {
			if let selected = tabController.selectedViewController {
				return topViewController(controller: selected)
			}
		}
		if let presented = controller?.presentedViewController {
			return topViewController(controller: presented)
		}
		return controller
	}
}


