//
//  MyCustomCellTableViewCell.swift
//  addressFinder
//
//  Created by Milica Jankovic on 11/13/17.
//  Copyright © 2017 Milica Jankovic. All rights reserved.
//

import UIKit

protocol BookmarkTableViewCellDelegate: class {
  func showLocationButtonTap(_ sender: CustomBookmarkedLocationCell)
  func deleteLocationButtonTap(_ sender: CustomBookmarkedLocationCell)
}

//@IBDesignable
class CustomBookmarkedLocationCell: UITableViewCell {
  
  // MARK: Outlets
  @IBOutlet var addressLabel: UILabel!
  @IBOutlet var cityLabel: UILabel!
  @IBOutlet var stateLabel: UILabel!
  @IBOutlet var postalLabel: UILabel!
  
  @IBOutlet var showButton: UIButton! {
    didSet {
      let showImage = UIImage(named: "eye@1")?.withRenderingMode(.alwaysOriginal)
      showButton.setImage(showImage, for: .normal)
  }
}

  @IBOutlet var deleteButton: UIButton! {
    didSet {
      let deleteImage = UIImage(named: "garbage")?.withRenderingMode(.alwaysOriginal)
      deleteButton.setImage(deleteImage, for: .normal)
    }
  }
  
  // MARK: Properties
  
  weak var delegate: BookmarkTableViewCellDelegate?
  
  // MARK: Actions
  
  @IBAction func showButtonTap(_ sender: UIButton) {
    delegate?.showLocationButtonTap(self)
  }
  
  @IBAction func deleteButtonTap(_ sender: UIButton) {
    delegate?.deleteLocationButtonTap(self)
  }
  
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
      
  }
}

