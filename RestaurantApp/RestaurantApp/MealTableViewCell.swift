//
//  MealTableViewCell.swift
//  RestaurantApp
//
//  Created by Mujtaba Ahmed on 12/01/2018.
//  Copyright © 2018 Mujtaba Ahmed. All rights reserved.
//

import UIKit
import CoreData

class MealTableViewCell: UITableViewCell {

    
    @IBOutlet weak var mealImageView: UIImageView!
    @IBOutlet weak var mealTitleLabel: UILabel!
    
    @IBOutlet weak var mealPriceLabel: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    func configureCell(meal: Meal){
        self.mealPriceLabel.text = "\(meal.mealPrice)"
        self.mealTitleLabel.text = meal.mealName
        self.mealImageView.image = UIImage(data: meal.mealImage as! Data)
    }

}
