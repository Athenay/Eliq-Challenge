//
//  FetchRatesParams.swift
//  EliqChallenge
//
//  Created by Athena Yousefi on 11/5/20.
//  Copyright © 2020 Athena Yousefi. All rights reserved.
//

import Foundation

struct FetchRatesParams: Encodable {
    let startDate: String
    let endDate: String
    let symbols: String
    let base: String
    let accessKey: String = Info.APIKEY
}
