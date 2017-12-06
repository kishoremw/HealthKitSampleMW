//
//  MWError.swift
//  HealthKitSampleMW
//
//  Created by Ashok on 05/12/17.
//  Copyright © 2017 Ashok Kumar. All rights reserved.
//

import Foundation

enum MWError: Error {
    case custom(title: String)
    case defaultError(error: NSError)
    case unknownError
}

extension MWError {
    var errorDescription: String! {
        switch self {
        case .custom(let title):
            return title
        case .defaultError(let error):
            return error.localizedDescription
        case .unknownError:
            return "An unknown error."
        }
    }
}
