//
//  SignInSelectionVC.swift
//  FirebaseUserTest
//
//  Created by Uzair Ahmed on 16/04/21.
//  Copyright © 2021 Uzair Ahmed. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth
import GoogleSignIn


class SignInSelectionVC: UIViewController, GIDSignInDelegate {

    @IBOutlet var signGoogleBTN: GIDSignInButton!
    
    @IBOutlet var gmailName : UILabel!
    @IBOutlet var gEmail : UILabel!
     
    override func viewDidLoad() {
        super.viewDidLoad()

        //GoogleSignIn
        GIDSignIn.sharedInstance().delegate = self
        GIDSignIn.sharedInstance()?.presentingViewController = self
        
        GIDSignIn.sharedInstance()?.restorePreviousSignIn()
        
        if(GIDSignIn.sharedInstance()?.currentUser != nil) {
            print("User is logged In")
        } else {
           // GIDSignIn.sharedInstance()?.signIn()
        }
        
        
        
      //  GIDSignIn.sharedInstance().signIn()
    }
    
    
   

}


extension SignInSelectionVC {
    
    func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!, withError error: Error!) {
        let name = user.profile.name!
        let email = user.profile.email!
        
        print("Name: \(name) Email: \(email)")
        
        self.gmailName.text = name
        self.gEmail.text = email
        
       // let vc = UIViewController()
        //vc.modalPresentationStyle = .fullScreen
       // self.present(vc, animation : true)
    }
}
