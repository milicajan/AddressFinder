//
//  Alert.swift
//  addressFinder
//
//  Created by Milica Jankovic on 2/26/19.
//  Copyright © 2019 Milica Jankovic. All rights reserved.
//

import UIKit

class Alert: NSObject {
  static let sharedInstance = Alert()
  
  //Show alert
  func showAlert(view: UIViewController, title: String, message: String) {
    let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
    let defaultAction = UIAlertAction(title: "OK", style: .default, handler: { action in
    })
    alert.addAction(defaultAction)
    DispatchQueue.main.async(execute: {
      view.present(alert, animated: true)
    })
  }
  
  private override init() {
  }
}
  
//      func  showAlertLoading()  {
//          let alert = UIAlertController(title: nil, message: "Loading... Please wait.", preferredStyle: .alert)
//
//          let loadingIndicator = UIActivityIndicatorView(frame: CGRect(x: 10, y: 5, width: 50, height: 50))
//          loadingIndicator.hidesWhenStopped = true
//          loadingIndicator.style = UIActivityIndicatorView.Style.gray
//          loadingIndicator.startAnimating();
//
//          alert.view.addSubview(loadingIndicator)
//          //present(alert, animated: true, completion: nil)
//      }
//}
  // MARK: Alert methodes
//
//    func showAlertNetworkError() {
//        let alert = UIAlertController(title: "NETWORK ERROR", message: "There is no internet connection.Please try again.",
//                                      preferredStyle: .alert)
//        let action = UIAlertAction(title:"OK", style: .default, handler: nil)
//        alert.addAction(action)
//
//        present(alert, animated: true, completion: nil)
//    }
//
//    func showAlertWrongAddress() {
//        let alert  = UIAlertController(title: "WRONG ADDRESS", message: "Your address does not exist. Please check again.",
//                                       preferredStyle: .alert)
//        let action = UIAlertAction(title: "OK", style: .default, handler: nil)
//        alert.addAction(action)
//
//        present(alert, animated: true, completion:  nil)
//    }
//

//// MARK: Alert methode
//
//func locationIsSavedAlert() {
//  let alert = UIAlertController(title: "SAVED!", message: "Your location is saved successfully!",
//                                preferredStyle: .alert)
//  let action = UIAlertAction(title: "OK", style: .default, handler: nil)
//
//  alert.addAction(action)
//  present(alert, animated: true, completion:  nil)
//}
//
//func locationExsitAlert() {
//  let alert = UIAlertController(title: "WARNING!", message: "Location already exists.",
//                                preferredStyle: .alert)
//
//  let action = UIAlertAction(title: "OK", style: .default, handler: nil)
//  alert.addAction(action)
//  present(alert, animated: true, completion: nil)
//}
//}
