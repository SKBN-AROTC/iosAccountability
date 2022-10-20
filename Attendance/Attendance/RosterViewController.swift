//
//  RosterViewController.swift
//  Attendance
//
//  Created by Will Chu on 10/20/22.
//

import FirebaseCore
import FirebaseAuth
import FirebaseDatabase

// Google Auth
import GoogleSignIn

class RosterViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var search: UISearchBar! //TODO
    @IBOutlet weak var platoonSegControl: UISegmentedControl! //TODO
    @IBOutlet weak var squadSegControl: UISegmentedControl! //TODO
    @IBOutlet weak var tableView: UITableView! //TODO
    
    var ref: DatabaseReference!
    var databaseHandle : DatabaseHandle!
    var cadets = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        // Firebase setup
        ref = Database.database().reference()
        
        // get curent date
        let date = Date()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyyMMdd"
        let formattedDate = dateFormatter.string(from: date)
        
        // Table View
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "PostCell")
        tableView.delegate = self
        tableView.dataSource = self
        
        // Retrieve the posts and listen for changes
        databaseHandle = ref.child(formattedDate).observe(.childAdded, with: { (snapshot) in
            
            // Try to convert the value of the data to a string
            let post = snapshot.value as? String
            
            if let actualPost = post {
                
                // Append the data to our postData array
                self.cadets.append(actualPost)
                
                self.tableView.reloadData()
            }
        })
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cadets.count
    
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PostCell", for: indexPath)
        cell.textLabel?.text = cadets[indexPath.row]

        return cell
    }
}

