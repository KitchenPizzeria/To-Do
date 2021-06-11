//
//  category.swift
//  ToDoList
//
//  Created by Joseph Meyrick on 27/04/2021.
//

import Foundation
import RealmSwift

class Category: Object {
    @objc dynamic var name: String = ""
    @objc dynamic var bgcolour: String = "FFFFFF"
    let items = List<Item>()
}
