//
//  BookmarkViewController.swift
//  addressFinder
//
//  Created by Milica Jankovic on 11/13/17.
//  Copyright © 2017 Milica Jankovic. All rights reserved.
//

import UIKit
import CoreData
import MapKit


class  BookmarkViewController: UIViewController, UITableViewDelegate, BookmarkTableViewCellDelegate {
  
 
    // MARK: Outlets

    @IBOutlet weak var tableView: UITableView!

    // MARK: Variables

   var locations: [Location] = []
   var indexPath: IndexPath?
   var fullAddress = Address(title: "", city: "", state: "", postal: "",  coordinate: CLLocationCoordinate2D(latitude: 0.0 , longitude: 0.0))
  
  
  // MARK: Actions

    @IBAction func backButtonTappedAction(_ sender: UIBarButtonItem) {
        dismiss(animated: true, completion: nil)
    }

    // MARK: View lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
  
        self.tableView.rowHeight = UITableView.automaticDimension
        self.tableView.estimatedRowHeight = 120
      
        fetchData()
        tableView.reloadData()
    }

  
  // MARK: CellDelgate methods
  
  func showLocationButtonTap(_ sender: CustomBookmarkedLocationCell) {

    if let indexPath = tableView.indexPath(for: sender){
      
      let location = locations[indexPath.row]
      if let address = location.address, let city = location.city,
                                  let state = location.state,
                                  let postal = location.postal {


    self.fullAddress = Address(title: address, city: city, state: state, postal: postal,  coordinate: CLLocationCoordinate2D(latitude:  location.latitude, longitude: location.longitude))
    performSegue(withIdentifier: Identifier.mapSegue, sender: nil)
    }
   }
  }
  
  func deleteLocationButtonTap(_ sender: CustomBookmarkedLocationCell) {
    if let indexPath = tableView.indexPath(for: sender) {
      self.indexPath = indexPath
      performSegue(withIdentifier: Identifier.popUpSegue, sender: nil)
    }
  }
  
//    // MARK: CoreData methods
//
  func fetchData() {
    guard let appDeledate = UIApplication.shared.delegate as? AppDelegate else { return }
    let managedContext = appDeledate.persistentContainer.viewContext

    let fetchRequest = NSFetchRequest<Location>(entityName: "Location")

    do {
      locations = try managedContext.fetch(fetchRequest)
    } catch let error as NSError {
      print("Could not fetch. \(error), \(error.userInfo)")
    }
  }
  
  func deleteData(at index: IndexPath) {
    guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
    let managedContext = appDelegate.persistentContainer.viewContext
   
    let location = locations[index.row]
    managedContext.delete(location)
    appDelegate.saveContext()
    
    locations.remove(at: index.row)
    tableView.deleteRows(at: [index], with: .automatic)
  }
  
   // MARK: Segue methods
  
  @IBAction func unwindToBookmarkViewController(_ segue: UIStoryboardSegue) {
    guard let indexPath = indexPath else { return }
      deleteData(at: indexPath)
  }
  
  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
          if segue.identifier == Identifier.mapSegue {
              let mapViewController = segue.destination as! MapViewController
              mapViewController.address = fullAddress
          } else if segue.identifier == Identifier.popUpSegue {
            _ = segue.destination as! PopUpViewController
          }
      }
}

// MARK: TableView DataSource

extension BookmarkViewController: UITableViewDataSource {
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return locations.count
  }
  
   func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    
    tableView.register(UINib(nibName: Identifier.bookmarkCell, bundle: nil), forCellReuseIdentifier: Identifier.bookmarkCell)
     let cell = tableView.dequeueReusableCell(withIdentifier: Identifier.bookmarkCell) as! CustomBookmarkedLocationCell
    
      cell.delegate = self
      let location = locations[indexPath.row]
      cell.addressLabel.text = location.address
      cell.cityLabel.text = location.city
      cell.stateLabel.text = location.state
      cell.postalLabel.text = location.postal
    
    return cell
  }
}

 //MARK: TableViewDelegate methods

extension BookmarkViewController {
  
  func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }

    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
      deleteData(at: indexPath)
    }
}




