//
//  UserDefault.swift
//  Friends
//
//  Created by Hitesh  Agarwal on 01/12/19.
//  Copyright © 2019 Hitesh  Agarwal. All rights reserved.
//

import Foundation

extension UserDefaults {
	
	static var isLogined: Bool {
		set {
			UserDefaults.standard.set(newValue, forKey: "isLogined")
		}
		get {
			return UserDefaults.standard.bool(forKey: "isLogined")
		}
	}
}
