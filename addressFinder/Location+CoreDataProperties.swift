//
//  Location+CoreDataProperties.swift
//  addressFinder
//
//  Created by Milica Jankovic on 2/28/19.
//  Copyright © 2019 Milica Jankovic. All rights reserved.
//
//

import Foundation
import CoreData


extension Location {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Location> {
        return NSFetchRequest<Location>(entityName: "Location")
    }

    @NSManaged public var address: String?
    @NSManaged public var city: String?
    @NSManaged public var state: String?
    @NSManaged public var postal: String?
    @NSManaged public var latitude: Double
    @NSManaged public var longitude: Double

}
