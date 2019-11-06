//
//  ViewController.swift
//  CachedMap
//
//  Created by erumaru on 11/6/19.
//  Copyright © 2019 KBTU. All rights reserved.
//

import UIKit
import CoreData
import RealmSwift

class ViewController: UIViewController {

    // MARK: - Variables
    let realm = try! Realm()
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        markup()
        saveData()
        fetchData()
    }
    
    // MARK: - Configurations
    private func saveData() {
        realm.beginWrite()
        for age in 1..<100 {
            let person = Person(context: AppDelegate.persistentContainer.viewContext)
            person.name = "Abzal"
            person.age = Int64(age)
            try? AppDelegate.persistentContainer.viewContext.save()
            
            let realmPerson = RealmPerson()
            realmPerson.name = "Abzal"
            realmPerson.age = age
            realm.add(realmPerson)
        }
        try? realm.commitWrite()
    }
    
    private func fetchData() {
        print("Realm:")
        let persons = realm.objects(RealmPerson.self).filter("(age > 98) AND (name contains 'A')", "Abzal")
        print(persons.compactMap { return "\($0.name) \($0.age)" })
        
        do {
            let request = NSFetchRequest<Person>(entityName: "Person")
            let predicate = NSPredicate(format: "(age > 75 AND age < 78) AND (name contains 'A')", "Abzal")
            request.predicate = predicate
            
            let persons = try AppDelegate.persistentContainer.viewContext.fetch(request)
            
            print("CoreData:")
            print(persons.map { "\($0.name) \($0.age)" })
        } catch {
            print(error)
        }
    }
    
    // MARK: - Markup
    private func markup() {
        view.backgroundColor = .red
        
        
    }
}

