//
//  CategoryViewController.swift
//  ToDoList
//
//  Created by Joseph Meyrick on 25/04/2021.
//
//
import UIKit
import RealmSwift
import SwipeCellKit
import ChameleonFramework


class CategoryViewController: SwipeTableViewController {
    
    let realm = try! Realm()
    let palette = [FlatPurple()]
    
    var categories: Results<Category>?


    override func viewDidLoad() {
        super.viewDidLoad()
        //print(realm.configuration.fileURL)
        tableView.separatorStyle = .none
        load()
        
    }

    //MARK: - TableView Datasource Methods

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categories?.count ?? 1
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let cell = super.tableView(tableView, cellForRowAt: indexPath)
        
        if let category = categories?[indexPath.row] {
            
            cell.textLabel?.text = category.name ?? "No Categories Added Yet"
    
            cell.backgroundColor = UIColor(hexString: category.bgcolour ?? "FFFFFF")
            cell.textLabel?.textColor = ContrastColorOf(UIColor(hexString: category.bgcolour)!, returnFlat: true)
        }

        return cell
    }
    
    //MARK: - TableView Delegate Methods
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "goToItems", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destinationVC = segue.destination as! TodoListViewController
        
        if let indexPath = tableView.indexPathForSelectedRow {
            destinationVC.selectedCategory = categories?[indexPath.row]
        }
    }
    
    //MARK: - Make User Menu Edits
    
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
    
        var textField = UITextField()
        
        let alert = UIAlertController(title: "Add new Category", message: "", preferredStyle: .alert)
        
        alert.addTextField { (alertTextField) in
            alertTextField.placeholder = "Create new item"
            textField = alertTextField
        }
        
    
        let action = UIAlertAction(title: "Add", style: .default) { (action) in
            
            if textField.text!.isEmpty {
                
                alert.dismiss(animated: true, completion: nil)
                
            } else {
                
                let newCategory = Category()
                
                newCategory.name = textField.text!
                newCategory.bgcolour = RandomFlatColor().hexValue()
              
                self.save(category: newCategory)
                
            }
        }

        alert.addAction(action)
        present(alert, animated: true, completion: nil)
    }

    //MARK: - Data Manipulation Methods

    func save(category: Category) {

        do {
            try realm.write {
                realm.add(category)
            }
        } catch {
            print("Error saving categpry\(error)")
        }

        tableView.reloadData()
    }


    func load() {
        
        categories = realm.objects(Category.self)
        tableView.reloadData()
        
    }
    
    override func updateModel(at indexPath: IndexPath) {
        if let categoryForDeletion = categories?[indexPath.row]{
            do {
                try self.realm.write {
                    self.realm.delete(categoryForDeletion)
                }
            } catch {
                print("error deleting category \(error)")
            }

        }
    }
}
