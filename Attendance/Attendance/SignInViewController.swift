//
//  SignInViewController.swift
//  Attendance
//
//  Created by Will Chu on 10/17/22.
//

import UIKit

import FirebaseCore
import FirebaseAuth

// Google Auth
import GoogleSignIn

class SigninViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        // Firebase setup
        FirebaseApp.configure()
    }

    @IBAction func buttonClicked() {
        
        guard let clientID = FirebaseApp.app()?.options.clientID else { return }
        
        // Create Google Sign In configuration object.
        let config = GIDConfiguration(clientID: clientID)
        
        GIDSignIn.sharedInstance.signIn(with: config, presenting: self) { user, error in
            guard error == nil else {
                return
            }
            
        }
        
        
    }
}

