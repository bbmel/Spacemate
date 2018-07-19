//
//  MatchesViewController.swift
//  Spacemate
//
//  Created by Melanie Gravier on 7/19/18.
//  Copyright © 2018 Mel. All rights reserved.
//

import UIKit
import Parse

class MatchesViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var tableView: UITableView!
    
    var images : [UIImage] = []
    var userIds : [String] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = self
        tableView.delegate = self
        
        if let query = PFUser.query() {
            query.whereKey("accepted", contains: PFUser.current()?.objectId)
            
            if let acceptedPeeps = PFUser.current()?["accepted"] as? [String] {
                query.whereKey("objectId", containedIn: acceptedPeeps)
                
                query.findObjectsInBackground(block: { (objects, error) in
                    if let users = objects {
                        for user in users {
                            if let theUser = user as? PFUser {
                                if let imageFile = theUser["photo"] as? PFFile {
                                    imageFile.getDataInBackground(block: { (data, error) in
                                        if let imageData = data {
                                            if let image = UIImage(data: imageData) {
                                                self.images.append(image)
                                                if let objectId = theUser.objectId {
                                                    self.userIds.append(objectId)
                                                    self.tableView.reloadData()
                                                }
                                            }
                                        }
                                        
                                    })
                                }
                            }
                        }
                    }
                })
            }
            
            
        }
        
        
        // Do any additional setup after loading the view.
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return images.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "matchCell", for: indexPath) as? MatchTableViewCell {
            cell.messageLabel.text = "No messages yet"
            cell.profileImageView.image = images[indexPath.row]
            cell.recipientObjectId = userIds[indexPath.row]
            return cell
        }
        return UITableViewCell()
    }
    
    @IBAction func backTapped(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    
    
}
