//
//  ViewController.swift
//  FirebaseUserTest
//
//  Created by Uzair Ahmed on 15/04/21.
//  Copyright © 2021 Uzair Ahmed. All rights reserved.
//

import UIKit
import FirebaseAuth

class ViewController: UIViewController {

    @IBOutlet weak var viewContainer: UIView!
    @IBOutlet weak var emailTF: UITextField!
    @IBOutlet weak var passwordTF: UITextField!
     
    let logoutBTN : UIButton = {
        let button = UIButton()
        button.setTitle("Logout", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .darkGray
        button.isHidden = true
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        emailTF.becomeFirstResponder()
        
        logoutBTN.frame = CGRect(x: 50, y: 100, width: 300, height: 50)
        logoutBTN.isHidden = true
        logoutBTN.addTarget(self, action: #selector(logoutFunction), for: UIControl.Event.touchUpInside)
        view.addSubview(logoutBTN)
    }

    @objc func logoutFunction() {
        print("loggedOut")
        self.logoutBTN.isHidden = true
        self.viewContainer.isHidden = false
        
        
    }
    
    @IBAction func submitBTN(_ sender: Any) {
        
        guard let email = emailTF.text, !email.isEmpty else {
            print("Email field is can't be empty")
            return
        }
        
        guard let password = passwordTF.text, !password.isEmpty else {
            print("Password can't be empty")
            return
        }
        
        //Firebase Auth
        FirebaseAuth.Auth.auth().signIn(withEmail: email, password: password, completion: { [weak self] result, error in
             
            if result != nil {
               self?.viewContainer.isHidden = true
                self?.logoutBTN.isHidden = false
                self?.emailTF.resignFirstResponder()
                self?.passwordTF.resignFirstResponder()
            }
            
            
            guard let strongSelf = self else {
                return
            }
            
            guard error == nil else {
                print("ERROR", error!)
                strongSelf.showCreateAccount(email: email, password: password)
                return
            }
            
        })
          
    }
    
    
    func showCreateAccount(email : String, password : String) {
         
        let alertController = UIAlertController(title: "Sign Up", message: "Oh no! Account doesn't exist. Create an account with the same email and Password?", preferredStyle: .alert)
        let okAction = UIAlertAction(title: "Ok", style: .default) { (_) in
            
            FirebaseAuth.Auth.auth().createUser(withEmail: email, password: password, completion: { [weak self] result, error in
                
                guard let strongSelf = self else {
                    return
                }
                
                guard error == nil else {
                    print("Account creation failed", error)
                    return
                }
                
                self?.viewContainer.isHidden = true
                self?.logoutBTN.isHidden = false
                
            }
        )}
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        alertController.addAction(okAction)
        alertController.addAction(cancelAction)
        present(alertController, animated: true, completion: nil)
    }
    
}

