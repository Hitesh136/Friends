//
//  UserDefault.swift
//  Friends
//
//  Created by Hitesh  Agarwal on 01/12/19.
//  Copyright © 2019 Hitesh  Agarwal. All rights reserved.
//

import Foundation

extension UserDefaults {
    enum Key: String {
        case user = "User"
    }
}

extension UserDefaults {
    static var user: User? {
        set {
            let jsonEncoder = JSONEncoder()
            let encodedUser = try? jsonEncoder.encode(newValue)
            UserDefaults.standard.set(encodedUser, forKey: UserDefaults.Key.user.rawValue)
        }
        get {
            guard let userData = UserDefaults.standard.data(forKey: UserDefaults.Key.user.rawValue) else { return nil }
            let jsonDecoder = JSONDecoder()
            return try? jsonDecoder.decode(User.self, from: userData)
        }
    }
}


extension Notification.Name {
    static let didChangeUser = Notification.Name("UserDidChange")
}
