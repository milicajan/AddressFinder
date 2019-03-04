//
//  File.swift
//  addressFinder
//
//  Created by Milica Jankovic on 11/8/17.
//  Copyright © 2017 Milica Jankovic. All rights reserved.
//

import MapKit
import SwiftyJSON

class Address: NSObject, MKAnnotation {
  
  let title: String?
  let city: String
  let state: String
  let postal: String
  let coordinate: CLLocationCoordinate2D
  
  
  init(title: String, city: String, state: String, postal: String, coordinate: CLLocationCoordinate2D) {
    self.title = title
    self.city = city
    self.state = state
    self.postal = postal
    self.coordinate = coordinate
    
    super.init()
  }
  
  var subtitle: String? {
    let  fullAdress = "\(city), \(state), \(postal)"
    return fullAdress
    
  }
}
