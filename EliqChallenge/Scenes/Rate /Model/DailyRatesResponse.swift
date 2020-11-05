//
//  DailyRatesResponse.swift
//  EliqChallenge
//
//  Created by Athena Yousefi on 11/5/20.
//  Copyright © 2020 Athena Yousefi. All rights reserved.
//

import Foundation

struct DailyRateResponse: Decodable {
    let success: Bool
    let error: ErrorModel?
    let historical: Bool?
    let date: String?
    let timestamp: Int?
    let base: String?
    let rates: [String: Double]?

}
