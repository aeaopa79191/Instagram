//
//  PhotoCell.swift
//  Instagram
//
//  Created by KaKin Chiu on 1/23/16.
//  Copyright © 2016 KaKinChiu. All rights reserved.
//

import UIKit

class PhotoCell: UITableViewCell {


    @IBOutlet weak var photo: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
