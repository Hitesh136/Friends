//
//  UserListViewModels.swift
//  Friends
//
//  Created by Hitesh Agarwal on 03/12/19.
//  Copyright © 2019 Hitesh  Agarwal. All rights reserved.
//

import Foundation

class UserListViewModel {
    
    private var viewModels = [UserViewModel]()
    var rowCount: Int {
        return viewModels.count
    }

    let userDataManager = UserDataManager()

    func viewModel(atIndex index: Int) -> UserViewModel {
        return viewModels[index]
    }
    
    func getUsers(completion: @escaping (Bool) -> ()) {
        userDataManager.getUsers { [weak self] (result) in
            
            guard let self = self else { return }
            switch result {
            case .success(let viewModels):
                self.viewModels = viewModels
                completion(true)
            case .failure(let error):
                print(error)
            }
        }
    } 
}
