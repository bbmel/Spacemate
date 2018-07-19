//
//  MatchTableViewCell.swift
//  Spacemate
//
//  Created by Melanie Gravier on 7/19/18.
//  Copyright © 2018 Mel. All rights reserved.
//

import UIKit

class MatchTableViewCell: UITableViewCell {
    @IBOutlet weak var profileImageView: UIImageView!
    
    @IBOutlet weak var messageLabel: UILabel!
    
    @IBOutlet weak var messageTextField: UITextField!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    @IBAction func sendTapped(_ sender: Any) {
    }
    

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
