//
//  TableCell.swift
//  MDBSocial
//
//  Created by Kristin Ho on 3/11/16.
//  Copyright © 2016 Kristin Ho. All rights reserved.
//

import UIKit

class TableCell: UITableViewCell {
    
    
    @IBOutlet weak var name: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
