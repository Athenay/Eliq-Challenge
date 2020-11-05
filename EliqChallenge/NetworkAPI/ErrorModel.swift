//
//  ErrorModel.swift
//  EliqChallenge
//
//  Created by Athena Yousefi on 11/5/20.
//  Copyright © 2020 Athena Yousefi. All rights reserved.
//

import Foundation

struct ErrorModel: Error, Decodable {
    let code: ErrorCode
    let type, info: String
}


enum ErrorCode: Int, Decodable {
    case limitedPlan = 105
    case notFound = 404
    case invalidAPIKey = 101
    case invalidEndpoint = 103
    case maximumRequestsReached = 104
    case noResult = 106
    case inactiveAccount = 102
    case invalidBaseCurrency = 201
    case invalidSumbols = 202
    case noDateSpecified = 301
    case invalidDateSpecified = 302
    case invalidStartDate = 502
    case invalidEndDate = 503
    case tooLargeTimeFrame = 505
    
    case unknowError = -1 
}
