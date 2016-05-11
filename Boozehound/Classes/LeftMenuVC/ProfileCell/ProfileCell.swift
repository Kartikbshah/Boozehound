//
//  ProfileCell.swift
//  Boozehound
//
//  Created by MAC-186 on 2/23/16.
//  Copyright © 2016 MoveoApps. All rights reserved.
//

import UIKit

class ProfileCell: UITableViewCell {

    @IBOutlet var imgProfilePic: UIImageView!
    @IBOutlet var lblUserName: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
