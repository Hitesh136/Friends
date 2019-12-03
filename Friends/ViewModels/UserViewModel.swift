//
//  UserViewModel.swift
//  Friends
//
//  Created by Hitesh Agarwal on 03/12/19.
//  Copyright © 2019 Hitesh  Agarwal. All rights reserved.
//

import Foundation
import UIKit

class UserViewModel {
    
    private var user: User!
    
    var userName: String {
        return user.firstName + " " + user.lastName
    }
    
    var userEmailId: String {
        return user.email
    }
    
    var userImageURL: URL? {
        return URL(string: user.profileURL) 
    }
    
    init(user: User) {
        self.user = user
    }
}
