//
//  PhotoTableViewCell.swift
//  Instagram
//
//  Created by Trustin Harris on 3/1/18.
//  Copyright © 2018 Trustin Harris. All rights reserved.
//

import UIKit
import Parse
import ParseUI

class PhotoTableViewCell: UITableViewCell {

    @IBOutlet weak var CaptionLabel: UILabel!
    @IBOutlet weak var PostIV: PFImageView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()

    }
    
    var IGPost : PFObject! {
        didSet {
            self.PostIV.file = IGPost["media"] as? PFFile
            self.CaptionLabel.text = IGPost["caption"] as! String
            self.PostIV.loadInBackground()
        }
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}

