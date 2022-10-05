//
//  ViewController.swift
//  Attendance
//
//  Created by Will Chu on 10/3/22.
//

import UIKit
import CoreLocation

class ViewController: UIViewController, CLLocationManagerDelegate {
    
    // GUI Elements
    @IBOutlet weak var locLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    
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

    }
    
    @IBAction func buttonClicked() {
        // print current time
        let date = Date()
        let calendar = Calendar.current
        let hour = calendar.component(.hour, from: date)
        let minutes = calendar.component(.minute, from: date)
        print("time = \(hour):\(minutes)") // Debug purposes
        timeLabel.text = "\(hour):\(minutes)" // Debug purposes
        
        // print current gps
        guard let locValue: CLLocationCoordinate2D = locationManager.location?.coordinate else { return }
        print("locations = \(locValue.latitude) \(locValue.longitude)")
        locLabel.text = "\(locValue.latitude) \(locValue.longitude)" // Debug purposes
        
        // Create Debug Alert
        let alert = UIAlertController(title: "Debug", message: "Valid: \(atSKBN(x: locValue.latitude, y: locValue.longitude))", preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
        print(atSKBN(x: locValue.latitude, y: locValue.longitude))
        
    }
    
    

    // SKBN Geofence
    // Coordinates: 40.504017, -74.452259
    // Error Margin 0.0001
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

