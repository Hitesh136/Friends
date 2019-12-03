//
//  UsersViewController.swift
//  Friends
//
//  Created by Hitesh  Agarwal on 02/12/19.
//  Copyright © 2019 Hitesh  Agarwal. All rights reserved.
//

import UIKit
import FirebaseDatabase

class UsersViewController: UIViewController {
	
    @IBOutlet weak var tableView: UITableView! {
        didSet {
            tableView.delegate = self
            tableView.dataSource = self
            tableView.register(UINib(nibName: "UserTableViewCell", bundle: nil), forCellReuseIdentifier: "UserTableViewCell")
            tableView.tableFooterView = UIView()
        }
    }
    
    let userListViewModel = UserListViewModel()
	override func viewDidLoad() {
		super.viewDidLoad()
        configueView()
        configuerViewModel()
	} 

    func configueView() {
        title = "Users"
    }
    func configuerViewModel() {
        userListViewModel.getUsers { [weak self] (success) in
            self?.tableView.reloadData()
        }
    }
}

extension UsersViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return userListViewModel.rowCount
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let viewModel = userListViewModel.viewModel(atIndex: indexPath.row)
        let cell = tableView.dequeueReusableCell(withIdentifier: "UserTableViewCell", for: indexPath) as! UserTableViewCell
        cell.bind(withViewModel: viewModel)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let chatViewController = storyboard?.instantiateViewController(withIdentifier: "ChatViewController") as? ChatViewController {
            chatViewController.userViewModel = userListViewModel.viewModel(atIndex: indexPath.row)
            self.navigationController?.pushViewController(chatViewController, animated: true)
        } 
    }
}
