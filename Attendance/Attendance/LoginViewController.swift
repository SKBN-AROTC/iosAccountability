//
//  LoginViewController.swift
//  Attendance
//
//  Created by Will Chu on 10/3/22.
//

import FirebaseCore
import FirebaseAuth

// Google Auth
import GoogleSignIn

class LoginViewController: UIViewController {
    
    // GUI Elements
    @IBOutlet weak var button: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        if FirebaseApp.app() == nil {
            FirebaseApp.configure()
        }
    }
    @IBAction func buttonClicked(){
        guard let clientID = FirebaseApp.app()?.options.clientID else { return }
        
        // Create Google Sign In configuration object.
        let config = GIDConfiguration(clientID: clientID)
        GIDSignIn.sharedInstance.signIn(with: config, presenting: self) { [self] user, error in
            guard error == nil else {
                let  alert = UIAlertController(title: "INVALID LOGIN ATTEMPT", message: "Please try again", preferredStyle: UIAlertController.Style.alert)
                alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
                self.present(alert, animated: true, completion: nil)
                return
            }
            
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let tabbar = storyboard.instantiateViewController(withIdentifier: "tabbar") as! UITabBarController
            tabbar.modalPresentationStyle = .fullScreen
            self.present(tabbar, animated: true, completion: nil)
        }
    }

    
}

