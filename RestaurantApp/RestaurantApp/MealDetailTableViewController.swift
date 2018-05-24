//
//  MealDetailTableViewController.swift
//  RestaurantApp
//
//  Created by Mujtaba Ahmed on 12/01/2018.
//  Copyright © 2018 Mujtaba Ahmed. All rights reserved.
//

import UIKit
import CoreData

class MealDetailTableViewController: UITableViewController,UINavigationControllerDelegate, UIImagePickerControllerDelegate {
    
    
    @IBOutlet weak var mealPriceTextField: UITextField!
    @IBOutlet weak var mealImageView: UIImageView!
    
    @IBOutlet weak var mealNameTextField: UITextField!
    
    @IBOutlet weak var mealDescriptionTextView: UITextView!
    
    var managedObjectContext: NSManagedObjectContext?{
        return (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    }
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setSaveBarButton()

    }
    
    func setSaveBarButton(){
        
        let saveBarButton = UIBarButtonItem(barButtonSystemItem: .save, target: self, action: #selector(MealDetailTableViewController.saveMeal))
        navigationItem.rightBarButtonItem = saveBarButton
        
    }
    
    
    
    @IBAction func pickMealImage(_ sender: UITapGestureRecognizer) {
        
        let pickerController = UIImagePickerController()
        pickerController.delegate = self
        pickerController.allowsEditing = true
        
        let alertController = UIAlertController(title: "Add an image", message: "Choose from", preferredStyle: .actionSheet)
        
        let cameraAction = UIAlertAction(title: "Camera", style: .default) {(action) in
            pickerController.sourceType = .photoLibrary
            self.present(pickerController, animated: true, completion: nil)
        
    }
        let photosLibraryAction = UIAlertAction(title: "Photos Library", style: .default) { (action) in
            pickerController.sourceType = .photoLibrary
            self.present(pickerController, animated: true, completion: nil)
        }
        
        let savedPhotosAction = UIAlertAction(title: "Saved Photo Album", style: .default) { (action) in
            pickerController.sourceType = .savedPhotosAlbum
            self.present(pickerController, animated: true, completion: nil)
        }
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .destructive, handler: nil)
        
        alertController.addAction(cameraAction)
        alertController.addAction(photosLibraryAction)
        alertController.addAction(savedPhotosAction)
        alertController.addAction(cancelAction)
        
        present(alertController, animated: true, completion: nil)
        
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        self.dismiss(animated: true, completion: nil)
        if let image = info[UIImagePickerControllerOriginalImage] as? UIImage{
           self.mealImageView.image = image
        }
        
    }
    
    
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
    
    
    
    func saveMeal(){
        
        if mealPriceTextField.text!.isEmpty || mealNameTextField.text!.isEmpty || mealDescriptionTextView.text.isEmpty || mealImageView.image == nil{
            
            
            let alertController = UIAlertController(title: "Oops", message: "Please provide all the informations to save this meal", preferredStyle: .alert)
            
            alertController.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
            self.present(alertController, animated: true, completion: nil)
            
        } else{
            
            //Here we save
            if let moc = managedObjectContext{
                let meal = Meal(context: moc)
                meal.mealPrice = Float(mealPriceTextField.text!)!
                meal.mealName = mealNameTextField.text!
                meal.mealDescription = mealDescriptionTextView.text!
                
                if let data = UIImageJPEGRepresentation(self.mealImageView.image!, 1.0){
                    
                    meal.mealImage = data as NSData
                }
                
                saveToCoreDate() {
                    self.navigationController!.popToRootViewController(animated: true)
                }
            }
        }
        

    }
    
    
    func saveToCoreDate(completion: @escaping ()->Void){
        managedObjectContext?.perform {
            do{
                try self.managedObjectContext?.save()
                completion()
                print("Meal saved to Core Data")
            }catch let error {
                print("Could not save Meal to Core Data: \(error.localizedDescription)")
            }

        }
        
        
        
    }
}
