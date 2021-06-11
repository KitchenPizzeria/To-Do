//
//  item.swift
//  ToDoList
//
//  Created by Joseph Meyrick on 27/04/2021.
//

import Foundation
import RealmSwift

class Item: Object {
    
    @objc dynamic var done : Bool = false
    @objc dynamic var title : String = ""
    @objc dynamic var dateCreated: Date?
    
    var ParentCategory = LinkingObjects(fromType: Category.self, property: "items")
        
}
