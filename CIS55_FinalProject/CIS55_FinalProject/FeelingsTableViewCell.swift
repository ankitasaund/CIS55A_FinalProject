//
//  FeelingsTableViewCell.swift
//  CIS55_FinalProject
//
//  Created by Jan on 3/15/17.
//  Copyright © 2017 DeAnza. All rights reserved.
//

import UIKit

class FeelingsTableViewCell: UITableViewCell {
   
    @IBOutlet weak var emotionName: UILabel!
    @IBOutlet weak var songImage: UIImageView!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
