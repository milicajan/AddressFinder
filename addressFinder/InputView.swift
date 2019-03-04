//
//  MyCustomView.swift
//  addressFinder
//
//  Created by Milica Jankovic on 11/5/17.
//  Copyright © 2017 Milica Jankovic. All rights reserved.
//

import UIKit


 class InputView: UIView {
  
  // MARK: Outlets
    @IBOutlet var contentView: UIView!
    @IBOutlet var textField: UITextField!
    @IBOutlet var bottomLine: UIView!
    @IBOutlet var label: UILabel!
  
  // MARK: Initializers
 override init(frame: CGRect) {
    super.init(frame: frame)
    commonInit()
  }
  
  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
    commonInit()
  }
  
  func commonInit() {
    Bundle.main.loadNibNamed("InputView", owner: self, options: nil)
    addSubview(contentView)
    contentView.frame = self.bounds
    contentView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
  }
  
  
  // MARK: Inspectables
  @IBInspectable var textFieldPlaceholder: String? {
    didSet {
      textField.placeholder = textFieldPlaceholder
    }
  }
  
  // Properties
  
 var isEmptyError: Bool = false {
        didSet {
          if (isEmptyError) {
           setupErrorLayout()
           label.text = ErrorMessage.empty
          } else {
            setupSuccessLayout()
          }
    }
  }
  
  var addressError: Bool = false {
    didSet {
      if (addressError) {
          setupErrorLayout()
          label.text = ErrorMessage.addressLimit
      } else {
        setupSuccessLayout()
      }
    }
  }
  
  var cityError: Bool = false {
    didSet {
      if (cityError) {
      setupErrorLayout()
      label.text = ErrorMessage.cityLimit
      } else {
        setupSuccessLayout()
      }
      
    }
  }
  
  var stateError: Bool = false {
    didSet {
      if (stateError) {
        setupErrorLayout()
        label.text = ErrorMessage.stateLimit
      } else {
        setupSuccessLayout()
      }
    }
  }
  
  var postalMinError: Bool = false {
    didSet {
      if (postalMinError) {
        setupErrorLayout()
        label.text = ErrorMessage.postalMinimum
        
      } else {
        setupSuccessLayout()
      }
    }
  }
  
  var postalMaxError: Bool = false {
    didSet {
      if (postalMaxError) {
        setupErrorLayout()
        label.text = ErrorMessage.postalMaximum
        
      } else {
        setupSuccessLayout()
      }
    }
  }
  
  func setupErrorLayout() {
    label.isHidden = false
    label.textColor = AppColor.errorColor
    bottomLine.backgroundColor = AppColor.errorColor
  }
  
  func setupSuccessLayout() {
    label.isHidden = true
    bottomLine.backgroundColor = AppColor.defaultColor
  }
}

