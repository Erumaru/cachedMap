//
//  Person.swift
//  CachedMap
//
//  Created by erumaru on 11/6/19.
//  Copyright © 2019 KBTU. All rights reserved.
//

import Foundation
import CoreData

public class Person: NSManagedObject {
    @NSManaged var name: String
    @NSManaged var age: Int64
}

public class Place: NSManagedObject {
    @NSManaged var longitude: Double
    @NSManaged var latitude: Double
}
