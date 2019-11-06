//
//  Person.swift
//  CachedMap
//
//  Created by erumaru on 11/6/19.
//  Copyright © 2019 KBTU. All rights reserved.
//

import Foundation
import CoreData
import RealmSwift

public class Person: NSManagedObject {
    @NSManaged public var name: String
    @NSManaged public var age: Int64
}

public class RealmPerson: Object {
    @objc dynamic var name = ""
    @objc dynamic var age = 0
}
