//
//  MWHealthKitAnchorManager.swift
//  HealthKitSampleMW
//
//  Created by Ashok on 06/12/17.
//  Copyright © 2017 Ashok Kumar. All rights reserved.
//

import HealthKit

func getAnchor(identifier: String) -> HKQueryAnchor {
    let key = "HKClientAnchorKey_\(identifier)"
    
    if let encoded = UserDefaults.standard.data(forKey: key) {
        if let anchor = NSKeyedUnarchiver.unarchiveObject(with: encoded) as? HKQueryAnchor {
            print("Anchor is retrieved for: \(key)")
            return anchor
        }
    }
    
    print("Anchor is not retrieved for(It's nil): \(key)")
    return HKQueryAnchor(fromValue: Int(HKAnchoredObjectQueryNoAnchor))
}

func saveAnchorObject(anchor : HKQueryAnchor? = nil, identifier: String) {
    let key = "HKClientAnchorKey_\(identifier)"
    
    if let anchor = anchor {
        let encoded = NSKeyedArchiver.archivedData(withRootObject: anchor)
        
        UserDefaults.standard.setValue(encoded, forKey: key)
        UserDefaults.standard.synchronize()
        
        print("Anchor is saved for: \(key)")
    }
}
