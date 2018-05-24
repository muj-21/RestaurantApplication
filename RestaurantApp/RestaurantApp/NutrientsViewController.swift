//
//  NutrientsViewController.swift
//  RestaurantApp
//
//  Created by Mujtaba Ahmed on 13/01/2018.
//  Copyright © 2018 Mujtaba Ahmed. All rights reserved.
//

import UIKit

class NutrientsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate {
    
    
    @IBOutlet weak var tableviewNutr: UITableView!
    
    var nutrients: [Nutrients]? = []
    
    

    override func viewDidLoad() {
        super.viewDidLoad()

        fetchNutrients()
        searchBar()
    }
    
    
    func fetchNutrients(){
        let urlRequest = URLRequest(url: URL(string: "https://next.json-generator.com/api/json/get/4kUfGzQV4")!)
        let task = URLSession.shared.dataTask(with: urlRequest) {(data,response,error) in
            if error != nil {
                print(error)
                return
            }
            self.nutrients = [Nutrients]()
            do{
                let json = try JSONSerialization.jsonObject(with: data!, options: .mutableContainers) as! [String : AnyObject]
                
                if let nutrientsFromJson = json["Nutrients"] as? [[String : AnyObject]] {
                    for nutrientFromJson in nutrientsFromJson {
                        let nutrient = Nutrients()
                        if let name = nutrientFromJson["name"] as? String, let restaurant = nutrientFromJson["restaurant"] as? String, let urlToImage = nutrientFromJson["urlToImage"] as? String, let protein = nutrientFromJson["protein"] as? String, let energy = nutrientFromJson["energy"] as? String, let carbohydrate = nutrientFromJson["carbohydrate"] as? String {
                            
                            nutrient.name = name
                            nutrient.restaurant = restaurant
                            nutrient.nutrToImgURL = urlToImage
                            nutrient.protein = protein
                            nutrient.energy = energy
                            nutrient.carbs = carbohydrate
                            
                        }
                        self.nutrients?.append(nutrient)
                        
                    }
                    
                }
                DispatchQueue.main.async {
                    self.tableviewNutr.reloadData()
                }
                
            }catch let error {
                print(error)
            }
            
        }
        task.resume()
    }
    
    func searchBar(){
        let searchBar = UISearchBar(frame: CGRect(x: 0, y: 0, width: self.view.frame.width, height: 50))
        searchBar.delegate = self
        searchBar.showsScopeBar = true
        searchBar.tintColor = UIColor.lightGray
        searchBar.scopeButtonTitles = ["name", "restaurant"]
        self.tableviewNutr.tableHeaderView = searchBar
    }
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String){
        if searchText == ""{
            fetchNutrients()
        }
        else{
            if searchBar.selectedScopeButtonIndex == 0{
                nutrients = nutrients?.filter({ (name) -> Bool in
                    return (name.name?.lowercased().contains(searchText.lowercased()))!
                })
            }
            else{
                nutrients = nutrients?.filter({ (restaurant) -> Bool in
                    return (restaurant.restaurant?.lowercased().contains(searchText.lowercased()))!
                })
            }
            
            self.tableviewNutr.reloadData()
        }
        
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "nutrientsCell", for: indexPath) as! NutrientsCell
        
        cell.nutrName.text = self.nutrients?[indexPath.item].name
        cell.nutrRestaurant.text = self.nutrients?[indexPath.item].restaurant
        cell.nutrImgView.downloadImageNutr(from: (self.nutrients?[indexPath.item].nutrToImgURL!)!)
        cell.nutrProtein.text = self.nutrients?[indexPath.item].protein
        cell.nutrEnergy.text = self.nutrients?[indexPath.item].energy
        cell.nutrCarbs.text = self.nutrients?[indexPath.item].carbs
        
        return cell
        
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.nutrients?.count ?? 0
        
    }
   
}





extension UIImageView{
    func downloadImageNutr(from url: String){
        
        let urlRequest = URLRequest(url: URL(string: url)!)
        
        let task = URLSession.shared.dataTask(with: urlRequest){(data,response,error) in
            
            if error != nil{
                print(error)
                return
            }
            DispatchQueue.main.async {
                self.image = UIImage(data: data!)
            }
        }
        task.resume()
        
    }


}
