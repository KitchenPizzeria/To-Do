//
//  SwipeCellKitController.swift
//  ToDoList
//
//  Created by Joseph Meyrick on 29/04/2021.
//
//
import Foundation
import SwipeCellKit
import UIKit
import ChameleonFramework

class SwipeTableViewController: UITableViewController, SwipeTableViewCellDelegate {
    
    var cell: UITableViewCell?
    
    override func viewDidLoad() {
        
        tableView.rowHeight = 80.0
        
    }
    //MARK: - Tableview Data Source Methods
    
    // cellForRowAt indexPath
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! SwipeTableViewCell
                
        cell.delegate = self
        
        let borderColor: UIColor = FlatBlack()
        cell.layer.masksToBounds = true
        cell.layer.cornerRadius = 30
        cell.layer.borderWidth = 1
        cell.layer.shadowOffset = CGSize(width: -10, height: 10)
        cell.layer.borderColor = borderColor.cgColor
        
        
        return cell
    }
    
    
    
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath, for orientation: SwipeActionsOrientation) -> [SwipeAction]? {
        
        guard orientation == .right else { return nil }

        let deleteAction = SwipeAction(style: .destructive, title: "Delete") { action, indexPath in
            
            self.updateModel(at: indexPath)
        }

        deleteAction.image = UIImage(named: "Trash-Icon")

        return [deleteAction]
    }
    
    func tableView(_ tableView: UITableView, editActionsOptionsForRowAt indexPath: IndexPath, for orientation: SwipeActionsOrientation) -> SwipeOptions {
        var options = SwipeOptions()
        options.expansionStyle = .destructive
        return options
    }
    
    func updateModel (at indexPath: IndexPath){
        //update data model
    }
}

