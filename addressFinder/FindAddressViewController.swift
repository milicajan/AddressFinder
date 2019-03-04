//
//  FindAddressViewController.swift
//  AddressFinder
//
//  Created by Milica Jankovic on 10/30/17.
//  Copyright © 2017 Milica Jankovic. All rights reserved.
//

import UIKit
import MapKit


class FindAddressViewController: UIViewController, UITextFieldDelegate {
    
    // MARK: Outlets
  
  @IBOutlet var addressView: InputView!
  @IBOutlet var cityView: InputView!
  @IBOutlet var stateView: InputView!
  @IBOutlet var postalView: InputView!
  
  @IBOutlet weak var searchButton: UIButton!
  @IBOutlet var scrollView: UIScrollView!

  
  // MARK: Properties
  
  var address = Address(title: "", city: "", state: "", postal: "", coordinate: CLLocationCoordinate2D(latitude: 0.0 , longitude: 0.0))
  let service = Service()

  // MARK: Actions
    
    @IBAction func backButtonTapAction() {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func searchLocationButtonTapAction(_ sender: UIButton) {
      validateTextFieldInputForAllViews()
      if (validTextFieldInput(for: addressView) && validTextFieldInput(for: cityView) && validTextFieldInput(for: stateView) && validTextFieldInput(for: postalView))  {
         searchForAddressLocation()
          hideKeyboard()
      }
  }
  
  // MARK: View lifecycle
  
  override func viewDidLoad() {
    super.viewDidLoad()
    setTextFieldDelegate()
    addObservers()
    self.view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(didTapView(gesture:))))
  }
  
  deinit {
  removeObservers()
  }

  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    addObservers()
  }

  override func viewWillDisappear(_ animated: Bool) {
    super.viewWillDisappear(animated)
     hideKeyboard()
     removeObservers()
  }
  
  // MARK: Validate textFiled input methods
  
  func validateTextFieldInputForAllViews() {
   let _ = validTextFieldInput(for: addressView)
   let _  = validTextFieldInput(for: cityView)
    let _ = validTextFieldInput(for: stateView)
    let _ = validTextFieldInput(for: postalView)
  }
  
  func validTextFieldInput(for view: InputView) -> Bool {
      if (view.textField.text?.isEmpty)! {
           view.isEmptyError = true
           return false
      } else {
        return verifyCondition(for: view)
      }
    }
  
  
  func verifyCondition(for view: InputView) -> Bool {
  
    switch view {
      
    case addressView where (view.textField.text?.count)! > 100:
    view.addressError = true
    return false
      
    case cityView where ((view.textField.text?.count)!) > 50:
    view.cityError = true
    return false
      
    case stateView where (view.textField.text?.count)! > 50:
    view.stateError = true
    return false
      
    case postalView:
     return checkPostalViewCondition()
   
    default:
      view.setupSuccessLayout()
      return true
    
    }
  }
    
      func checkPostalViewCondition() -> Bool {
        if (postalView.textField.text?.count)! < 2 {
          postalView.postalMinError = true
          return false
        } else if (postalView.textField.text?.count)! > 6 {
          postalView.postalMaxError = true
          return false
        } else {
          postalView.setupSuccessLayout()
          return true
      }
  }
  

  // MARK: Set textfield delegate
  
  func setTextFieldDelegate() {
    addressView.textField.delegate = self
    cityView.textField.delegate = self
    stateView.textField.delegate = self
    postalView.textField.delegate = self
  }
  
  // MARK: Keyboard methods
  
  func hideKeyboard() {
    addressView.textField.resignFirstResponder()
    cityView.textField.resignFirstResponder()
    stateView.textField.resignFirstResponder()
    postalView.textField.resignFirstResponder()
  }
  
  @objc func keyboardWillChange(notification: Notification) {
  
    guard let frame = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue else {
      return
    }
    
    if notification.name == UIResponder.keyboardWillShowNotification ||
      notification.name == UIResponder.keyboardWillChangeFrameNotification {
      let contentInset = UIEdgeInsets(top: 0, left: 0, bottom: frame.height + 15, right: 0)
      scrollView.contentInset = contentInset
    } else {
    scrollView.contentInset = UIEdgeInsets.zero
    }
    scrollView.scrollIndicatorInsets = scrollView.contentInset
  }

    // MARK: UITapGestureRecognizer methode
    
    @objc func didTapView(gesture: UITapGestureRecognizer) {
        view.endEditing(true)
    }
  
    // MARK: Searching for address coordinates

    func searchForAddressLocation() {
      LoadingIndicatorView.show("Searching...")
      
      if let address = addressView.textField.text, let city = cityView.textField.text, let state = stateView.textField.text,
        let postal = postalView.textField.text {
        
        let parameters = ["Address": "\(address)",
          "City": "\(city)",
          "State": "\(state)",
          "Zip": "\(postal)",
          "f": "pjson" ]
   
      service.executeNetworkRequest(parameters: parameters, completionHandler: { [weak self] results, error in

        DispatchQueue.main.async {
          if let coordonates = results {
            LoadingIndicatorView.hide()
            self?.address = Address(title: address, city: city, state: state, postal: postal, coordinate: CLLocationCoordinate2D(latitude: coordonates.0 , longitude: coordonates.1))
            print(coordonates)
            self?.performSegue(withIdentifier: Identifier.locationSegue, sender: nil)
          } else if let err = error as? URLError {
              LoadingIndicatorView.hide()
              self?.handleURLError(err)
          } else {
            LoadingIndicatorView.hide()
            Alert.sharedInstance.showAlert(view: self!, title: WrongAddress.title, message: WrongAddress.message)
          }
        }
      })
    }
  }
  
  // MARK: Handaling URLError
  
  func handleURLError(_ error: URLError) {
    if error.code == URLError.notConnectedToInternet {
      Alert.sharedInstance.showAlert(view: self, title: NetworkError.title, message: NetworkError.message)
    } else {
      Alert.sharedInstance.showAlert(view: self, title: NetworkError.title, message: "\(error)")
    }
  }
  
    // MARK: Segue

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showLocation" {
            let mapViewController = segue.destination as! MapViewController
            mapViewController.address = self.address
            navigationItem.backBarButtonItem?.title = ""
        }
    }
}

// MARK: Handaling keyboard events

extension FindAddressViewController {
  
//Listen for keyboard events
func addObservers() {
  NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillChange(notification:)), name: UIResponder.keyboardWillShowNotification, object: nil)
  NotificationCenter.default.addObserver(self, selector:  #selector(keyboardWillChange(notification:)), name: UIResponder.keyboardWillHideNotification, object: nil)
  NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillChange(notification:)), name: UIResponder.keyboardWillChangeFrameNotification, object: nil)
}
  
//Stop listening for keyboard events
func removeObservers() {
  NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
  NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
  NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillChangeFrameNotification, object: nil)
 }
}

// MARK: TextFieldDelegate methods
extension FindAddressViewController {
  
func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
    //Only numeric input in postalView
    if textField == postalView.textField {
      let allowedCharacters = "1234567890"
      let allowedCharacterSet = CharacterSet(charactersIn: allowedCharacters)
      let typedCharacterSet = CharacterSet(charactersIn: string)
      let alphabet = allowedCharacterSet.isSuperset(of: typedCharacterSet)
      if !alphabet {
        postalView.setupErrorLayout()
        postalView.label.text = ErrorMessage.postalNumericInput
        return alphabet
      } else {
        postalView.setupSuccessLayout()
      }
    }
    return true
}
  
  func textFieldShouldReturn() -> Bool {
    hideKeyboard()
    return true
  }
}





