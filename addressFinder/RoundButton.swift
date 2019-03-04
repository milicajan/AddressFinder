//
//  RoundButton.swift
//  addressFinder
//
//  Created by Milica Jankovic on 2/27/19.
//  Copyright © 2019 Milica Jankovic. All rights reserved.
//

import UIKit

@IBDesignable class RoundButton: UIButton {

  override init(frame: CGRect) {
    super.init(frame: frame)
    sharedInit()
  }
  
  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
    sharedInit()
  }
  
  override func prepareForInterfaceBuilder() {
    sharedInit()
  }
  
  func sharedInit() {
    self.backgroundColor = AppColor.defaultColor
    self.setTitle("+", for: .normal)
    refreshCorners(value: cornerRadius)
  }
  
  func refreshCorners(value: CGFloat) {
    layer.cornerRadius = value
  }
  
  @IBInspectable var cornerRadius: CGFloat = 15 {
    didSet {
      refreshCorners(value: cornerRadius)
    }
  }
}
