//
//  AppDelegate.swift
//  Friends
//
//  Created by Hitesh  Agarwal on 28/11/19.
//  Copyright © 2019 Hitesh  Agarwal. All rights reserved.
//

import UIKit
import Firebase
import SVProgressHUD
import IQKeyboardManagerSwift

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
	
	var window: UIWindow?

	func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
		// Override point for customization after application launch.
		FirebaseApp.configure()
		SVProgressHUD.setDefaultMaskType(.gradient)
		IQKeyboardManager.shared.enable = true
		IQKeyboardManager.shared.disabledToolbarClasses = [ChatViewController.self]
		showViewController()
		return true
	}
	
	func showViewController() {
		let rootNavigationController = CommonClass.getInitialViewController()
		window = UIWindow(frame: UIScreen.main.bounds)
		window?.rootViewController = rootNavigationController
		window?.makeKeyAndVisible()
	}
	
	func redirectToViewController() {
		let rootNavigationController = CommonClass.getInitialViewController()
		
		if #available(iOS 13.0, *) {
			if let scence = UIApplication.shared.connectedScenes.first {
				guard let windwoScence = (scence as? UIWindowScene) else { return }
				let window = UIWindow(windowScene: windwoScence)
				window.rootViewController = rootNavigationController
				window.makeKeyAndVisible()
				appDelegate.window = window
			}
		} else {
			window = UIWindow(frame: UIScreen.main.bounds)
			window?.rootViewController = rootNavigationController
			window?.makeKeyAndVisible()
		}
	}
}

