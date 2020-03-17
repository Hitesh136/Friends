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
import Firebase

class ProfileViewController: BaseViewController {
	
	var databaseHandle: DatabaseHandle!
	
	@IBOutlet weak var userImageView: UIImageView!
	@IBOutlet weak var emailTextField: UITextField!
	@IBOutlet weak var userNameTextField: UITextField!
	@IBOutlet weak var lastNameTextField: UITextField!
	@IBOutlet weak var countryTextField: UITextField!
	@IBOutlet weak var cityTextField: UITextField!
	@IBOutlet weak var phoneTextField: UITextField!
	@IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var backBarButton: UIBarButtonItem!
    @IBOutlet weak var logoutBarButton: UIBarButtonItem!
    @IBOutlet weak var registerButton: UIButton!
    
    lazy var localUserId: String = {
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
		emailTextField.text = "test\(localUserId)@gmail.com"
		userNameTextField.text = "first_test\(localUserId)"
		lastNameTextField.text = "last_test\(localUserId)"
		countryTextField.text = "country\(localUserId)"
		cityTextField.text = "city\(localUserId)"
		phoneTextField.text = "phone\(localUserId)"
		passwordTextField.text = "dummy@123"
        
        userImageView.layer.cornerRadius = (userImageView.frame.height / 2)
        userImageView.clipsToBounds = true
        
        //Manage Navigationbar buttons
//        if User.isLogined {
        if true { 
            navigationItem.leftBarButtonItem = nil
            registerButton.setTitle("Update", for: .normal)
        } else {
            navigationItem.rightBarButtonItem = nil
            registerButton.setTitle("Register", for: .normal)
        }
	}
	
	
    @IBAction func actionDone(_ sender: Any) {
       
	}
    
    @IBAction func actionLogout(_ sender: Any) {
        do {
            try Auth.auth().signOut()
            appDelegate.redirectToViewController()
        } catch let error {
            print("SingOut Error:\(error)")
        }
    }
    
    func uploadImage(withUserId userId: String) {
        if let uploadData = userImageView.image?.jpegData(compressionQuality: 0.1) {
            let storageRef = Storage.storage().reference().child("images/image\(userId).png")
            storageRef.putData(uploadData, metadata: nil) { [weak self] (metadata, error) in
            
                if let error = error {
                    hideLoader()
                    print(error)
                    return
                }
                
                
                storageRef.downloadURL { [weak self] (url, error) in
                    guard let self = self else {
                        hideLoader()
                        return
                    }
                    if let absoluteString = url?.absoluteString {
                        self.updateFirebaserUser(withUserid: userId, andWithImageURL: absoluteString)
                    }
                    hideLoader()
                }
            }
        }
    }
	
    func updateFirebaserUser(withUserid userId: String, andWithImageURL imageURL: String) {
		let newUser: [String: Any] = [
			"city": cityTextField.text!,
			"country": countryTextField.text!,
			"firstName": userNameTextField.text!,
			"lastName": lastNameTextField.text!,
			"phone": phoneTextField.text!,
            "email": emailTextField.text!,
            "profileURL": imageURL
		]
        ref.child(AppConstants.users).child(userId).updateChildValues(newUser)
        print("Regiser successfully")
        appDelegate.redirectToViewController()
	}
}

extension ProfileViewController {
	@IBAction func actionProfile(_ sender: Any) {
        let imagPickerViewController = UIImagePickerController()
        imagPickerViewController.delegate = self
        imagPickerViewController.sourceType = .photoLibrary;
        imagPickerViewController.allowsEditing = true
        present(imagPickerViewController, animated: true, completion: nil)
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
			
			
			guard let self = self else {
                hideLoader()
                return
            }
			
			if let error = error {
				print(error)
                hideLoader()
				return
			}
			
			guard let userId = authResult?.user.uid else {
                hideLoader()
				return
			}
            self.uploadImage(withUserId: userId)
		}
	}
}

extension ProfileViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController,
                               didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        picker.dismiss(animated: true, completion: nil)
        guard let editedImage = (info[.editedImage] ?? info[.originalImage])as? UIImage else { return }
        userImageView.image = editedImage
    }
}
