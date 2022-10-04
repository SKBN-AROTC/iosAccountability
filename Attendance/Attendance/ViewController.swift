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
    let locLabel = UILabel()
    let timeLabel = UILabel()
    let button = UIButton()
    
    // Date time
    let date = Date()
    
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
        let calendar = Calendar.current
        let hour = calendar.component(.hour, from: date)
        let minutes = calendar.component(.minute, from: date)
        print("time = \(hour):\(minutes)")
        timeLabel.text = "\(hour):\(minutes)" // Debug purposes
        
        // print current gps
        guard let locValue: CLLocationCoordinate2D = locationManager.location?.coordinate else { return }
        print("locations = \(locValue.latitude) \(locValue.longitude)")
        locLabel.text = "\(locValue.latitude) \(locValue.longitude)" // Debug purposes
        
        
    }


}

