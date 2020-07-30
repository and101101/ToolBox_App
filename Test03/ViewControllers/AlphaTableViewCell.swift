//
//  AlphaTableViewCell.swift
//  Test03
//
//  Created by Andrew Matula on 6/25/20.
//  Copyright © 2020 Andrew Matula. All rights reserved.
//

import UIKit

class AlphaTableViewCell: UITableViewCell {
    
    @IBOutlet var myLabel:UILabel!
    @IBOutlet weak var priority: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
