//
//  ViewController.swift
//  CachedMap
//
//  Created by erumaru on 11/6/19.
//  Copyright © 2019 KBTU. All rights reserved.
//

import UIKit
import CoreData
import SnapKit
import GoogleMaps

class ViewController: UIViewController {

    // MARK: - Variables
    
    // MARK: - Outlets
    lazy var mapView: GMSMapView = {
        let cameraPosition = GMSCameraPosition(latitude: 43.238643, longitude: 76.933594, zoom: 13)
        let view = GMSMapView(frame: .zero, camera: cameraPosition)
        view.delegate = self
        
        return view
    }()
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        markup()
//        saveData()
//        fetchData()
        printMapData()
    }
    
    // MARK: - Configurations
    private func printMapData() {
        let request = NSFetchRequest<Place>(entityName: "Place")
        do {
            let data =  try AppDelegate.persistentContainer.viewContext.fetch(request)
            
            print("$$$$$$$$$$$$$$$$$$$$$$")
            print(data.map { "\($0.longitude) \($0.latitude)" })
            print("$$$$$$$$$$$$$$$$$$$$$$")
        } catch {
            print(error)
        }
    }
    
    private func saveData() {
        for age in 1...100 {
            let person = Person(context: AppDelegate.persistentContainer.viewContext)
            person.name = "Dana"
            person.age = Int64(age)
            do {
                try AppDelegate.persistentContainer.viewContext.save()
            } catch {
                print(error)
            }
        }
        
    }
    
    private func fetchData() {
        let request = NSFetchRequest<Person>(entityName: "Person")
        request.predicate = NSPredicate(format: "age > 999")
        do {
            let persons = try AppDelegate.persistentContainer.viewContext.fetch(request)
            
            print(persons.map { "\($0.name) \($0.age)" })
        } catch {
            print(error)
        }
    }
    
    // MARK: - Markup
    private func markup() {
        view.backgroundColor = .red
        
        [mapView].forEach { view.addSubview($0) }
        
        mapView.snp.makeConstraints() {
            $0.edges.equalToSuperview()
        }
    }
}

extension ViewController: GMSMapViewDelegate {
    func mapView(_ mapView: GMSMapView, didTapAt coordinate: CLLocationCoordinate2D) {
        let place = Place(context: AppDelegate.persistentContainer.viewContext)
        place.latitude = coordinate.latitude
        place.longitude = coordinate.longitude
        try? AppDelegate.persistentContainer.viewContext.save()
        
        print("\(coordinate.longitude) \(coordinate.latitude)")
    }
}
