//
//  Networking.swift
//  addressFinder
//
//  Created by Milica Jankovic on 2/26/19.
//  Copyright © 2019 Milica Jankovic. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

struct Service {
// Only for locations in USA
   let url = "https://sampleserver1.arcgisonline.com/ArcGIS/rest/services/Locators/ESRI_Geocode_USA/GeocodeServer///findAddressCandidates"
  
  // MARK: fetchingData method
  
  func executeNetworkRequest(parameters: [String : String], completionHandler: @escaping ((Double, Double)?, Error?) -> ()) {
  
    Alamofire.request(url, method: .get, parameters: parameters).responseJSON { responseData in
      
      switch responseData.result {
        
                            case .success:
                            let json = JSON(responseData.result.value as Any)
                            print(json)
                               if (json["candidates"].arrayValue.isEmpty) {
                                 completionHandler(nil, nil)
                                } else {
                                  let firstLocation =  json["candidates"][0].dictionaryValue
                                  if let latitude = firstLocation["location"]?["y"].doubleValue,
                                  let longitude = firstLocation["location"]?["x"].doubleValue {
                                  let coordinates = (latitude, longitude)
                                  completionHandler(coordinates, nil)
                                }
                              }
        
                            case .failure(let error):
                              completionHandler(nil,error)
     
  }
  }
}
}
