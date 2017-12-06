//
//  ViewController.swift
//  HealthKitSampleMW
//
//  Created by Ashok on 05/12/17.
//  Copyright © 2017 Ashok Kumar. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let healthKitHelper = MWHealthKitHelper.shared
        healthKitHelper.authorizeHealthKit(success: {
            healthKitHelper.getStepsSessions(success: {
                // HealthData is successfully uploaded to the server
                
                // Enable background queries only once
                healthKitHelper.startEnablingBackgroundDelivery()
            }, failure: { (error) in
                print(error.errorDescription)
            })
        }) { (error) in
            print(error.errorDescription)
        }
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

