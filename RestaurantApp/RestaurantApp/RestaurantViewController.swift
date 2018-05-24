//
//  RestaurantViewController.swift
//  RestaurantApp
//
//  Created by Mujtaba Ahmed on 14/11/2017.
//  Copyright © 2017 Mujtaba Ahmed. All rights reserved.
//

import UIKit
import CoreData


class RestaurantViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate {
    
    @IBOutlet weak var tableview: UITableView!
    
    var restaurants: [Restaurant]? = []
    

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        fetchRestaurants()
        searchBar()
        
        
    }
    func fetchRestaurants(){
        let urlRequest = URLRequest(url: URL(string: "https://next.json-generator.com/api/json/get/VJdSiCSQV")!)
        let task = URLSession.shared.dataTask(with: urlRequest) {(data,response,error) in
            if error != nil {
                print(error)
                return
            }
            self.restaurants = [Restaurant]()
            do{
                let json = try JSONSerialization.jsonObject(with: data!, options: .mutableContainers) as! [String : AnyObject]
                
                if let restaurantsFromJson = json["Restaurant"] as? [[String : AnyObject]] {
                    for restaurantFromJson in restaurantsFromJson {
                        let restaurant = Restaurant()
                        if let name = restaurantFromJson["name"] as? String, let address = restaurantFromJson["address"] as? String, let urlToImage = restaurantFromJson["urlToImage"] as? String{
                            restaurant.title = name
                            restaurant.addr = address
                            restaurant.imgURL = urlToImage
                            
                        }
                        self.restaurants?.append(restaurant)
                        
                    }
                    
                }
                DispatchQueue.main.async {
                    self.tableview.reloadData()
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
        searchBar.scopeButtonTitles = ["name", "address"]
        self.tableview.tableHeaderView = searchBar
    }
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String){
        if searchText == ""{
            fetchRestaurants()
    }
        else{
            if searchBar.selectedScopeButtonIndex == 0{
                restaurants = restaurants?.filter({ (title) -> Bool in
                    return (title.title?.lowercased().contains(searchText.lowercased()))!
                })
            }
            else{
                restaurants = restaurants?.filter({ (address) -> Bool in
                    return (address.addr?.lowercased().contains(searchText.lowercased()))!
                })
            }
            
            self.tableview.reloadData()
        }
        
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "restaurantCell", for: indexPath) as! RestaurantCell
        cell.title.text = self.restaurants?[indexPath.item].title
        cell.address.text = self.restaurants?[indexPath.item].addr
        cell.imgView.downloadImage(from: (self.restaurants?[indexPath.item].imgURL!)!)

        return cell
    }
    
        func numberOfSections(in tableView: UITableView) -> Int {
            return 1
        }
        
        func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return self.restaurants?.count ?? 0
        }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destVC = segue.destination as! RateRestaurantViewController
        let selectedRestaurantIndex = self.tableview.indexPathForSelectedRow?.row
        destVC.selectedRestaurant = restaurants?[selectedRestaurantIndex!]
    }
        
}





extension UIImageView{
    func downloadImage(from url: String){
        
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


































