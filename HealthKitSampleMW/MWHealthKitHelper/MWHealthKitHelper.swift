//
//  MWHealthKitHelper.swift
//  HealthKitSampleMW
//
//  Created by Ashok on 05/12/17.
//  Copyright © 2017 Ashok Kumar. All rights reserved.
//

import HealthKit

class MWHealthKitHelper: NSObject {
    
    static let shared = MWHealthKitHelper()
    let healthKitStore: HKHealthStore = HKHealthStore()
    
}


// MARK:- ---> Autherization

extension MWHealthKitHelper {
    
    func authorizeHealthKit(success: (() -> ())? = nil, failure: ((MWError) -> ())? = nil) {
        
        // If the store is not available (for instance, iPad) return an error and don't go on.
        if !HKHealthStore.isHealthDataAvailable() {
            failure?(MWError.custom(title: "HealthKit is not available in this Device"))
            return;
        }
        
        var healthKitTypesToRead = Set<HKObjectType>()
        healthKitTypesToRead.insert(HKObjectType.quantityType(forIdentifier: HKQuantityTypeIdentifier.stepCount)!)

        // Request HealthKit authorization
        healthKitStore.requestAuthorization(toShare: nil, read: healthKitTypesToRead) { (successFlag, error) in
            if let error = error {
                failure?(MWError.defaultError(error: error as NSError))
            } else if successFlag {
                success?()
            } else {
                failure?(MWError.unknownError)
            }
        }
    }
    
}

// MARK: Autherization <---

