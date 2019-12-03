//
//  User.swift
//  Friends
//
//  Created by Hitesh Agarwal on 03/12/19.
//  Copyright © 2019 Hitesh  Agarwal. All rights reserved.
//

import Foundation
 
struct User: Codable {
    let city, country, firstName, email, lastName, profileURL: String
    let phone: String
}
