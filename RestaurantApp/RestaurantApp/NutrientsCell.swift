//
//  NutrientsCell.swift
//  RestaurantApp
//
//  Created by Mujtaba Ahmed on 13/01/2018.
//  Copyright © 2018 Mujtaba Ahmed. All rights reserved.
//

import UIKit

class NutrientsCell: UITableViewCell {
    
    
    @IBOutlet weak var nutrImgView: UIImageView!
    @IBOutlet weak var nutrName: UILabel!
    @IBOutlet weak var nutrRestaurant: UILabel!
    @IBOutlet weak var nutrProtein: UILabel!
    @IBOutlet weak var nutrEnergy: UILabel!
    @IBOutlet weak var nutrCarbs: UILabel!
    
    
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
