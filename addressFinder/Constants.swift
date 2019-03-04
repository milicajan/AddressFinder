//
//  Constants.swift
//  addressFinder
//
//  Created by Milica Jankovic on 11/5/17.
//  Copyright © 2017 Milica Jankovic. All rights reserved.
//
import UIKit

struct  AppColor {
  
        static let errorColor = UIColor(red: 225.0/255.0, green: 64.0/255.0, blue: 76.0/255.0, alpha: 1.0)
        static let defaultColor = UIColor(red: 0/255.0, green: 112.0/255.0, blue: 140.0/255.0, alpha: 1.0)
}

struct ErrorMessage {
  
        static let empty = "This field is mandatory"
        static let addressLimit = "Maximum 100 letters"
        static let cityLimit = "Maximum 50 letters"
        static let stateLimit = "Maximum 50 letters"
        static let postalMinimum = "Minimum one digit"
        static let postalMaximum = "Maximum six digits"
        static let postalNumericInput = "Only numeric input"
}

struct Identifier {
        static let locationCell = "locationCell"
        static let  bookmarkCell = "CustomBookmarkedLocationCell"

        static let mapSegue = "showMap"
        static let popUpSegue = "showPopUp"
        static let locationSegue = "showLocation"
        static let bookmarksSegue = "showBookmarks"
}

    struct NetworkError {
      static let title = "NETWORK ERROR"
      static let message = "There is no internet connection.Please try again later."
    }
    
    struct WrongAddress {
      static let title = "WRONG ADDRESS"
      static let message = "Your address does not exist. Please check again."
    }

    struct LocationSaved {
      static let title = "SAVED!"
      static let message = "Your location is successfully saved!"
    }

    struct LocationExist {
      static let title = "WARNING!"
      static let message = "Location already saved."
    }


