//
//  UpdateViewController.swift
//  Spacemate
//
//  Created by Melanie Gravier on 7/17/18.
//  Copyright © 2018 Mel. All rights reserved.
//

import UIKit
import Parse

class UpdateViewController: UIViewController, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var userGenderSwitch: UISwitch!
    @IBOutlet weak var interestedGenderSwitch: UISwitch!
    
    @IBOutlet weak var errorLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        errorLabel.isHidden = true
        
        if let isFemale = PFUser.current()?["isFemale"] as? Bool {
            userGenderSwitch.setOn(isFemale, animated: false)
        }
        
        if let isInterestedInWomen = PFUser.current()?["isInterestedInWomen"] as? Bool {
            interestedGenderSwitch.setOn(isInterestedInWomen, animated: false)
        }
        
        if let photo = PFUser.current()?["photo"] as? PFFile {
            photo.getDataInBackground(block: { (data, error) in
                if let imageData = data {
                    if let image = UIImage(data: imageData) {
                        self.profileImageView.image = image
                    }
                }
            })
        }
        
        createMale()
    }
            
    
        // Do any additional setup after loading the view.
    
    func createMale() {
        let imageUrls = ["https://www.disneyclips.com/imagesnewb6/images/n191.gif", "https://www.disneyclips.com/imagesnewb/images/lefou.png", "https://www.disneyclips.com/imagesnewb/images/clipgaston.gif", "https://www.disneyclips.com/imagesnewb/images/hades_face.gif", "https://www.disneyclips.com/imagesnewb/images/clippain.gif", "https://www.disneyclips.com/imagesnewb/images/clipshanyu5.gif", "https://www.disneyclips.com/imagesnewb/images/smee.png", "https://www.disneyclips.com/imagesnewb/images/hook.png", "https://www.disneyclips.com/imagesnewb3/images/clipbroad3.gif", "https://www.disneyclips.com/imagesnewb3/images/clipgol2.gif", "https://www.disneyclips.com/imagesnewb3/images/clipxan.gif", "https://www.disneyclips.com/imagesnewb/images/maurice_dressedup.gif", "https://www.disneyclips.com/imagesnewb/images/prince.png", "https://www.disneyclips.com/imagesnewb/images/beast5.png"]
        
        var counter = 66
        
        for imageUrl in imageUrls {
            counter += 1
            if let url = URL(string: imageUrl) {
                if let data = try? Data(contentsOf: url) {
                    let imageFile = PFFile(name: "photo.png", data: data)
                    let user = PFUser()
                    user["photo"] = imageFile
                    user.username = String(counter)
                    user.password = "abc123"
                    user["isFemale"] = false
                    user["isInterestedInWomen"] = false
                    
                    user.signUpInBackground(block: { (success, error) in
                        if success {
                            print("Male male user created!")
                        }
                    })
                }
            }
        }
        
    }
    
    
    @IBAction func updateImageTapped(_ sender: Any) {
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.sourceType = .photoLibrary
        imagePicker.allowsEditing = false
        
        present(imagePicker, animated: true, completion: nil)
        
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        if let image = info[UIImagePickerControllerOriginalImage] as? UIImage {
            profileImageView.image = image
        }
        
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func updateTapped(_ sender: Any) {
        PFUser.current()?["isFemale"] = userGenderSwitch.isOn
        PFUser.current()?["isInterestedInWomen"] = interestedGenderSwitch.isOn
        
        if let image = profileImageView.image {
            if let imageData = UIImagePNGRepresentation(image) {
                PFUser.current()?["photo"] = PFFile(name: "profile.png", data: imageData)
                PFUser.current()?.saveInBackground(block: { (success, error) in
                    if error != nil {
                        var errorMessage = "Update failed, try again"
                        
                        if let newError = error as NSError? {
                            if let detailError = newError.userInfo["error"] as? String {
                                errorMessage = detailError
                            }
                        }
                        self.errorLabel.isHidden = false
                        self.errorLabel.text = errorMessage
                    } else {
                        print("Update successful!")
                        
                        // proceed to swipe screen once info has been updated
                        self.performSegue(withIdentifier: "updateToSwipeSegue", sender: nil)
                    }
                })
            }
        }
        
    }
}
