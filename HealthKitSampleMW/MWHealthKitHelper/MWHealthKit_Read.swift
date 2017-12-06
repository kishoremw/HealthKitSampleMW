//
//  MWHealthKit_Read.swift
//  HealthKitSampleMW
//
//  Created by Ashok on 06/12/17.
//  Copyright © 2017 Ashok Kumar. All rights reserved.
//

import HealthKit

extension MWHealthKitHelper {
    
    func getStepsSessions(success: (() -> ())? = nil, failure: ((MWError) -> ())? = nil) {
        healthDataForQuantityType(HKObjectType.quantityType(forIdentifier: HKQuantityTypeIdentifier.stepCount), unit: HKUnit.count(), success: success, failure: failure)
    }
    
    func healthDataForQuantityType(_ healthQuantityType: HKQuantityType?, unit: HKUnit, success: (() -> ())? = nil, failure: ((MWError) -> ())? = nil )
    {
        guard let healthQuantityType = healthQuantityType else { failure?(MWError.custom(title: "'healthQuantityType' is nil")); return }
        
        if (HKHealthStore.isHealthDataAvailable()) {
            let query = HKAnchoredObjectQuery(type: healthQuantityType, predicate: nil, anchor: getAnchor(identifier: healthQuantityType.identifier), limit: Int(HKObjectQueryNoLimit)) { (query, newSamples, deletedSamples, newAnchor, error) -> Void in
                
                guard let samples = newSamples as? [HKQuantitySample] else {
                    print("newSamples are nil, Error: \(error?.localizedDescription ?? "")\n, identifier: \(healthQuantityType.identifier)")
                    return
                }
                
                var healthKitData = [[String: Any]]()
                
                for quantitySample in samples {
                    let quantity = quantitySample.quantity
                    
                    let healthValue = quantity.doubleValue(for: unit)
                    
                    var dicHealth = [String: Any]()
                    dicHealth["Value"] = healthValue
                    dicHealth["Source"] = quantitySample.sourceRevision.source.name
                    dicHealth["WasUserEntered"] = quantitySample.metadata?["HKWasUserEntered"] as? Int
                    
                    healthKitData.append(dicHealth)
                }
                
                ServiceManager.shared.sendHealtDataToServer(healthData: healthKitData, newAnchor: newAnchor, newAnchor_Identifier: healthQuantityType.identifier, success: success, failure: failure)
            }
            
            self.healthKitStore.execute(query)
        } else {
            failure?(MWError.custom(title: "'HKHealthStore.isHealthDataAvailable()' is false"))
        }
    }
    
}
