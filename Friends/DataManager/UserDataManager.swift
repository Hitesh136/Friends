//
//  UserDataManager.swift
//  Friends
//
//  Created by Hitesh Agarwal on 03/12/19.
//  Copyright © 2019 Hitesh  Agarwal. All rights reserved.
//

import Foundation
import FirebaseDatabase
import Firebase

class UserDataManager: NSObject {
    
    func getUsers(completion: @escaping (Result<[UserViewModel], AppError>) -> ()) {
        let ref = Database.database().reference()
        showLoader()
        ref.child(AppConstants.users).observeSingleEvent(of: .value) { (snapshot) in
            
            //            Auth.auth().listuser
            hideLoader()
            var userViewModels = [UserViewModel]()
            let currentUserId = Auth.auth().currentUser?.uid ?? ""
            if let usersDict = snapshot.value as? [String: Any] {
                let keys = Array(usersDict.keys)
                for key in keys {
                    
                    guard key != currentUserId else {
                        continue
                    }
                    if let userDict = usersDict[key] as? [String: Any] {
                        let userModel = User(city: userDict["city"] as! String,
                                             country: userDict["country"] as! String,
                                             firstName: userDict["firstName"] as! String,
                                             email: userDict["email"] as! String,
                                             lastName: userDict["lastName"] as! String,
                                             profileURL: userDict["profileURL"] as! String,
                                             phone: userDict["phone"] as! String)
                        
                        userViewModels.append(UserViewModel(user: userModel))
                    }
                }
                completion(.success(userViewModels))
                print(usersDict)
            }
        }
    }
}
