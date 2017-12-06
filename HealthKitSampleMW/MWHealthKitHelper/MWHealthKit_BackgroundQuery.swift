//
//  MWHealthKit_BackgroundQuery.swift
//  HealthKitSampleMW
//
//  Created by Ashok on 06/12/17.
//  Copyright © 2017 Ashok Kumar. All rights reserved.
//

import HealthKit
import Foundation

extension MWHealthKitHelper {
    
    func startEnablingBackgroundDelivery() {
        setUpBackgroundDeliveryForSteps(type: HKObjectType.quantityType(forIdentifier: HKQuantityTypeIdentifier.stepCount))
    }
    
    func setUpBackgroundDeliveryForSteps(type: HKSampleType?) {
        guard let sampleType = type else { print("ERROR: \(type?.identifier ?? "") is not an HKSampleType"); return }
        
        func queryForUpdates(type: HKObjectType, success: (() -> ())? = nil, failure: ((MWError) -> ())? = nil) {
            getStepsSessions(success: success, failure: failure)
        }
        
        let query: HKObserverQuery = HKObserverQuery(sampleType: sampleType, predicate: nil) { (query: HKObserverQuery, completionHandler: @escaping HKObserverQueryCompletionHandler, error: Error?) in
            
            var logString = "observer query update handler called for type \(sampleType.identifier)"
            
            if let error = error {
                logString += ", with error: \(error)"
            }
            
            print(logString)
            
            queryForUpdates(type: sampleType, success: {
                //Tell Apple we are done handling this event.  This needs to be done inside this handler
                completionHandler()
            }, failure: { (error) in
                //Tell Apple we are done handling this event.  This needs to be done inside this handler
                completionHandler()
            })
        }
        
        enableBackgroundQuery(query, sampleType: sampleType, frequency: .immediate)
    }
    
    func enableBackgroundQuery(_ query: HKObserverQuery, sampleType: HKObjectType?, frequency: HKUpdateFrequency) {
        healthKitStore.execute(query)
        
        healthKitStore.enableBackgroundDelivery(for: sampleType!, frequency: .immediate) { (succeeded: Bool, error: Error?) in
            if succeeded {
                print("Enabled background delivery of \(sampleType?.identifier ?? "") changes")
            } else {
                if let theError = error {
                    print("Failed to enable background delivery of \(sampleType?.identifier ?? "") changes. ")
                    print("Error = \(theError)")
                }
            }
        }
    }
    
    func disableBackgroundQuery() {
        // Disabling background queries
        healthKitStore.disableAllBackgroundDelivery { (succeeded: Bool, error: Error?) in
            if succeeded {
                print("Disabled all background delivery")
            } else {
                if let theError = error {
                    print("Failed to Disabled all background delivery")
                    print("Error = \(theError)")
                }
            }
        }
    }
    
}
