//
//  RateRestaurantViewController.swift
//  RestaurantApp
//
//  Created by Mujtaba Ahmed on 11/01/2018.
//  Copyright © 2018 Mujtaba Ahmed. All rights reserved.
//

import UIKit
import Social

class RateRestaurantViewController: UIViewController, UITextFieldDelegate {

    
    @IBOutlet weak var rstImage: UIImageView!
    @IBOutlet weak var rstTitle: UILabel!
    @IBOutlet weak var rstAddress: UILabel!
    
    var selectedRestaurant:Restaurant?
    var socialMessage:String?
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        

        // Do any additional setup after loading the view.
        rstTitle.text = selectedRestaurant?.title
        rstAddress.text = selectedRestaurant?.addr
        rstImage.downloadImage(from: (selectedRestaurant?.imgURL)!)
        
//         socialMessage = "\(selectedCityService!.landmarkName!) - I wish I could visit this place!"
        socialMessage = "\(selectedRestaurant!.title!) - I reccomend you visit this place"
        }
    
    
    @IBAction func bynShareClicked(_ sender: UIButton) {
        
        print ("\(sender.titleLabel!.text!)requested...")
        
        //set up
        
        var serviceType:String
        
        //decide which service to call depending on Title of Button that called this handler
        if(sender.titleLabel?.text == "FaceBook")
        {
            serviceType = SLServiceTypeFacebook
        }
        else if sender.titleLabel?.text == "Twitter"
        {
            serviceType = SLServiceTypeTwitter
        }
        else
        {
            return //service type unknown, so go no further
        }
        
        if(SLComposeViewController.isAvailable(forServiceType: serviceType))
        {
            let socialController = SLComposeViewController(forServiceType: serviceType)
            
            socialController?.setInitialText(socialMessage)
            
            self.present(socialController!, animated: true, completion: nil)
            
        }
        else
        {
            let alert = UIAlertController(title: sender.titleLabel?.text, message: "This serivce is unavailabe, please sign in", preferredStyle: .alert)
            
            let action = UIAlertAction(title: "OK", style: .default)
            alert.addAction(action)
            present(alert, animated: true, completion:
                {
                    let settingdPath = "App-Prefs:root=\(sender.titleLabel!.text!.uppercased())"
                    print(settingdPath)
                    UIApplication.shared.open(URL(string:settingdPath)!)
            })
        }
        
        
    }
    
    
    
    
    
    
    }
