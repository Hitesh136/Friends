//
//  LoginViewController.swift
//  Friends
//
//  Created by Hitesh  Agarwal on 01/12/19.
//  Copyright © 2019 Hitesh  Agarwal. All rights reserved.
//

import UIKit
import FirebaseAuth
import FirebaseDatabase

class LoginViewController: BaseViewController {
	
	@IBOutlet weak var emailTextField: UITextField!
	@IBOutlet weak var passwordTextField: UITextField!
	@IBOutlet weak var comfirmPasswordTextField: UITextField!

	override func viewDidLoad() {
		super.viewDidLoad()
		emailTextField.text = "test_135626@gmail.com"
		passwordTextField.text = "dummy@123"
	}
	
	override func viewWillAppear(_ animated: Bool) {
		super.viewWillAppear(animated)
		configureView()
	}
	
	func configureView() {
		navigationController?.setNavigationBarHidden(true, animated: true)
	}
	
	@IBAction func actionRegister(_ sender: Any) {
		let profileViewController = storyboard?.instantiateViewController(withIdentifier: "ProfileViewController") as! ProfileViewController
		self.navigationController?.pushViewController(profileViewController, animated: true)
	}
	
	@IBAction func actionLogin(_ sender: Any) {
		showLoader()
		Auth.auth().signIn(withEmail: emailTextField.text!, password: passwordTextField.text!) { (result, error) in
			if let error = error {
				print(error)
			}
			print("Login successfully")
			hideLoader()
			appDelegate.redirectToViewController()
			
		}
	}
}
