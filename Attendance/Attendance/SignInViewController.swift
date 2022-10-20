//
//  SignInViewController.swift
//  Attendance
//
//  Created by Will Chu on 10/3/22.
//

import UIKit
import CoreLocation

// Firebase imports
import FirebaseCore
import FirebaseDatabase
import FirebaseAuth

// Google Auth
import GoogleSignIn

class SignInViewController: UIViewController, CLLocationManagerDelegate {
    
    // GUI Elements
    @IBOutlet weak var locLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    

    // Firebase
    var ref: DatabaseReference!
    
    // GPS
    let locationManager = CLLocationManager()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        // Ask for Authorisation from the User.
        self.locationManager.requestAlwaysAuthorization()

        // For use in foreground
        self.locationManager.requestWhenInUseAuthorization()

        if CLLocationManager.locationServicesEnabled() {
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
            locationManager.startUpdatingLocation()
        }
        
        // Firebase setup
        ref = Database.database().reference()
        
    }
    
    @IBAction func buttonClicked() {

        var netid = "\(GIDSignIn.sharedInstance.currentUser!.profile!.email)"
        let scarletmail = "@scarletmail.rutgers.edu"
        if netid.contains(scarletmail) {
            netid = netid.replacingOccurrences(of: "@scarletmail.rutgers.edu", with: "")
        }
    
        // get curent date
        let date = Date()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyyMMdd"
        let formattedDate = dateFormatter.string(from: date)
    
        // get current gps
        guard let locValue: CLLocationCoordinate2D = locationManager.location?.coordinate else { return }
    
        // Create Location Alert
        let alert = UIAlertController(title: "INVALID LOCATION ATTEMPT", message: "Valid: \(atSKBN(x:locValue.latitude, y: locValue.longitude))", preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
        
        let profile = GIDSignIn.sharedInstance.currentUser!.profile!
        self.ref.child(formattedDate).setValue(profile.name)
    }
        
    // SKBN Geofence
    // Coordinates: 40.504017, -74.452259
    // Error Margin 0.0005
    func atSKBN(x: Double, y: Double) -> Bool{
        // Longitude bounds
        if ((x >= 40.5035) && (x <= 40.5045)){
            if ((y >= -74.4527) && (y <= -74.4517)){
                return true
            }
        }
        return false
    }

}

