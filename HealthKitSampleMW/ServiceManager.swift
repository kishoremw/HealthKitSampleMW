//
//  ServiceManager.swift
//  HealthKitSampleMW
//
//  Created by Ashok on 05/12/17.
//  Copyright © 2017 Ashok Kumar. All rights reserved.
//

import Foundation
import HealthKit

class ServiceManager {
    static let shared = ServiceManager()
    
    func sendHealtDataToServer(healthData: [[String: Any]], newAnchor: HKQueryAnchor? = nil, newAnchor_Identifier: String, success: (() -> ())? = nil, failure: ((MWError) -> ())? = nil) {
        // Start sending health data to the server and call success(), failure() accordingly. and save the anchor in successive case
        saveAnchorObject(anchor: newAnchor, identifier: newAnchor_Identifier)
        success?()
    }
}
