//
//  MealTableViewController.swift
//  RestaurantApp
//
//  Created by Mujtaba Ahmed on 12/01/2018.
//  Copyright © 2018 Mujtaba Ahmed. All rights reserved.
//

import UIKit
import CoreData

class MealTableViewController: UITableViewController {
    
    var mealsArray = [Meal]()
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    var managedObjectContext: NSManagedObjectContext?{
        return(UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
            retrieveMeal()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return mealsArray.count
    }


    let cellID = "mealCell"
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellID, for: indexPath) as! MealTableViewCell

        // Configure the cell...
        cell.configureCell(meal:mealsArray[indexPath.row])

        return cell
    }
    func retrieveMeal(){
        fetchMealsFromCoreData { (meals) in
            if let meals = meals{
                self.mealsArray = meals
                self.tableView.reloadData()
            }
        }
        
        
    }
    func fetchMealsFromCoreData(completion: ([Meal]?)->Void){
        var results = [Meal]()
        let request: NSFetchRequest<Meal> = Meal.fetchRequest()
        do{
            results = try managedObjectContext!.fetch(request)
            completion(results)
        }catch {
            print("Could not fetch Meals from Core Data: \(error.localizedDescription)")
        }
    }


    override  func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete{
            let rmvMeals = mealsArray[indexPath.row]
            context.delete(rmvMeals)
            (UIApplication.shared.delegate as! AppDelegate).saveContext()
            
            do{
                mealsArray = try context.fetch(Meal.fetchRequest())
                
            }
            catch{
                print("Fetching Failed")
            }
        }
        tableView.reloadData()
    }
    
    
}
