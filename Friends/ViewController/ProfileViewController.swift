//
//  ProfileViewController.swift
//  Friends
//
//  Created by Hitesh  Agarwal on 01/12/19.
//  Copyright © 2019 Hitesh  Agarwal. All rights reserved.
//

import UIKit
import FirebaseAuth
import FirebaseDatabase
import FirebaseStorage

class ProfileViewController: UIViewController {
	
	var databaseHandle: DatabaseHandle!
	
	@IBOutlet weak var userImageView: UIImageView!
	@IBOutlet weak var emailTextField: UITextField!
	@IBOutlet weak var userNameTextField: UITextField!
	@IBOutlet weak var lastNameTextField: UITextField!
	@IBOutlet weak var countryTextField: UITextField!
	@IBOutlet weak var cityTextField: UITextField!
	@IBOutlet weak var phoneTextField: UITextField!
	@IBOutlet weak var passwordTextField: UITextField!
	
	lazy var userId: String = {
		return "_\(Int.random(in: 0...1000000))"
	}()
	
	lazy var ref: DatabaseReference = {
		return Database.database().reference()
	}()
	
	
	override func viewDidLoad() {
		super.viewDidLoad()
		configureView()
	}
	
	override func viewWillAppear(_ animated: Bool) {
		super.viewWillAppear(animated)
		navigationController?.setNavigationBarHidden(false, animated: true)
	}
	
	func configureView() {
		emailTextField.text = "test\(userId)@gmail.com"
		userNameTextField.text = "first_test\(userId)"
		lastNameTextField.text = "last_test\(userId)"
		countryTextField.text = "country\(userId)"
		cityTextField.text = "city\(userId)"
		phoneTextField.text = "phone\(userId)"
		passwordTextField.text = "dummy@123"
	}
	
	
	@IBAction func actionDone(_ sender: Any) {
		
		//		let profileViewController = storyboard?.instantiateViewController(withIdentifier: "ProfileViewController") as! ProfileViewController
		//		self.navigationController?.pushViewController(profileViewController, animated: true)
		//		if let uploadData = userImageView.image?.jpegData(compressionQuality: 0.1) {
		//			let storageRef = Storage.storage().reference().child("images/image\(userId).png")
		//			storageRef.putData(uploadData, metadata: nil) { (metadata, error) in
		//				if let error = error {
		//					print(error)
		//					return
		//				}
		//
		//				storageRef.downloadURL { [weak self] (url, error) in
		//					guard let self = self else { return	}
		//					if let absoluteString = url?.absoluteString {
		//						self.createFirebaseUser(imageURL: absoluteString)
		//					}
		//				}
		//			}
		//		}
	}
	
	func updateFirebaserUser(withUserid userId: String) {
		let newUser: [String: Any] = [
			"city": cityTextField.text!,
			"country": countryTextField.text!,
			"firstName": userNameTextField.text!,
			"lastName": lastNameTextField.text!,
			"phone": phoneTextField.text!,
			//			"profileURL": imageURL
		]
		ref.child("users").child(userId).updateChildValues(newUser)
	}
}

extension ProfileViewController {
	@IBAction func actionProfile(_ sender: Any) {
	}
	
	@IBAction func actionCancel(_ sender: Any) {
		navigationController?.popViewController(animated: true)
	}
	
	@IBAction func actionRegister(_ sender: Any) {
		
		guard let email = emailTextField.text, let passowrd = passwordTextField.text else {
			print("Invalid Form")
			return
		}
		
		showLoader()
		Auth.auth().createUser(withEmail: email, password: passowrd) { [weak self] (authResult, error) in
			
			hideLoader()
			guard let self = self else { return }
			
			if let error = error {
				print(error)
				return
			}
			
			guard let userId = authResult?.user.uid else {
				return
			}
			self.updateFirebaserUser(withUserid: userId)
			UserDefaults.isLogined = true
			appDelegate.redirectToViewController()
		}
	}
}
