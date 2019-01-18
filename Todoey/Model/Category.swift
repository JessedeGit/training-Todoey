//
//  Category.swift
//  Todoey
//
//  Created by applelee on 17/1/19.
//  Copyright © 2019 Jesse-Team. All rights reserved.
//

import Foundation
import RealmSwift

class Category: Object {
    @objc dynamic var name = ""
    let items = List<Item>()
}

