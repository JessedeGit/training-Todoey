//
//  Item.swift
//  Todoey
//
//  Created by applelee on 17/1/19.
//  Copyright © 2019 Jesse-Team. All rights reserved.
//

import Foundation
import RealmSwift

class Item: Object {
    @objc dynamic var done = false
    @objc dynamic var title = ""
    @objc dynamic var dateCreated = Date()
    var parent = LinkingObjects(fromType: Category.self, property: "items")
}
