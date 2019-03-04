//
//  MapViewController.swift
//  addressFinder
//
//  Created by Milica Jankovic on 11/8/17.
//  Copyright © 2017 Milica Jankovic. All rights reserved.
//

import Foundation
import UIKit
import MapKit
import CoreData

class MapViewController: UIViewController {

  // MARK: Outlets
  
  @IBOutlet weak var mapView: MKMapView!
 
  // Properties
  
  let regionRadius: CLLocationDistance = 1000
  var locations: [Location] = []
  var address = Address(title: "", city: "", state: "", postal: "",  coordinate: CLLocationCoordinate2D(latitude: 0.0 , longitude: 0.0 ))
  
  // MARK: View lifecycle
  
  override func viewDidLoad() {
    super.viewDidLoad()

    centerMapOnLocation(location: self.address.coordinate)
    mapView.addAnnotation(address)
    mapView.delegate = self
  }
  
  // MARK: Actions
  
  @IBAction func saveLocationTapButton(_ sender: UIButton) {
   // Before saving fetch data to confirm if already exists
    guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
    let managedContext = appDelegate.persistentContainer.viewContext
    let fetchRequest = NSFetchRequest<Location>(entityName: "Location")
    let address = self.address.title
    let predicate = NSPredicate(format: "address == %@", address!)
    fetchRequest.predicate = predicate
    fetchRequest.fetchLimit = 1
    
    do {
      let count = try managedContext.count(for: fetchRequest)
      if (count == 0) {
        saveLocation(address: self.address)
      } else {
        Alert.sharedInstance.showAlert(view: self, title: LocationExist.title, message: LocationExist.message)
      }
    } catch let error as NSError {
      print("Could not fetch. \(error), \(error.userInfo)")
    }
  }
  
  
  // MARK: Core Data saving fetching methods
  
  func saveLocation(address: Address) {
   
    guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
    let managedContext = appDelegate.persistentContainer.viewContext
    
    let entity = NSEntityDescription.entity(forEntityName: "Location", in: managedContext)!
    let location = NSManagedObject(entity: entity, insertInto: managedContext)
    
    location.setValue(address.title, forKey: "address")
    location.setValue(address.city, forKey: "city")
    location.setValue(address.state, forKey: "state")
    location.setValue(address.postal, forKey: "postal")
    location.setValue(address.coordinate.latitude, forKey: "latitude")
    location.setValue(address.coordinate.longitude, forKey: "longitude")
  
    do {
      try managedContext.save()
      Alert.sharedInstance.showAlert(view: self, title: LocationSaved.title, message: LocationSaved.message)
    } catch let error as NSError {
      print("Could not save. \(error), \(error.userInfo)")
    }
  }


  // MARK: CLLocation method
  
  func centerMapOnLocation(location: CLLocationCoordinate2D) {
    let coordinateRegion = MKCoordinateRegion(center: location, latitudinalMeters: regionRadius, longitudinalMeters: regionRadius)
    mapView.setRegion(coordinateRegion, animated: true)
  }
}


// MARK: MapViewDelegate

extension MapViewController: MKMapViewDelegate {

    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {

        if let annotation = annotation as? Address {

            let reuseIdentifier = "pin"
            var view: MKPinAnnotationView

            if let dequeuedView = mapView.dequeueReusableAnnotationView(withIdentifier: reuseIdentifier) as? MKPinAnnotationView {
                dequeuedView.annotation = annotation
                view = dequeuedView
            } else {

                view = MKPinAnnotationView(annotation: annotation, reuseIdentifier: reuseIdentifier)
                view.canShowCallout = true
                view.calloutOffset = CGPoint(x: -5, y: 5)
            }
            return view
        }
        return nil
    }
}

