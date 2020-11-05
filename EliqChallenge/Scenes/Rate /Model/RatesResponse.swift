//
//  RatesResponse.swift
//  EliqChallenge
//
//  Created by Athena Yousefi on 11/5/20.
//  Copyright © 2020 Athena Yousefi. All rights reserved.
//

import Foundation

struct RatesResponse: Decodable {
    let success: Bool
    let error: ErrorModel?
    let timeseries: Bool?
    let startDate, endDate, base: String?
    let rates: [String: [String: Double]]?
}
