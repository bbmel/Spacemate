//
//  UpdateViewController.swift
//  Spacemate
//
//  Created by Melanie Gravier on 7/17/18.
//  Copyright © 2018 Mel. All rights reserved.
//

import UIKit

class UpdateViewController: UIViewController, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var userGenderSwitch: UISwitch!
    @IBOutlet weak var interestedGenderSwitch: UISwitch!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
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
        
    }
    


}
