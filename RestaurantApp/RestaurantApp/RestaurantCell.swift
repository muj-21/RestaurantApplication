//
//  RestaurantCell.swift
//  RestaurantApp
//
//  Created by Mujtaba Ahmed on 11/01/2018.
//  Copyright © 2018 Mujtaba Ahmed. All rights reserved.
//

import UIKit

class RestaurantCell: UITableViewCell {
    
    
    @IBOutlet weak var imgView: UIImageView!
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var address: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
