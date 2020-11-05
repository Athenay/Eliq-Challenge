//
//  LatestCurrencyRequestParam.swift
//  EliqChallenge
//
//  Created by Athena Yousefi on 11/5/20.
//  Copyright © 2020 Athena Yousefi. All rights reserved.
//

import Foundation

struct LatestCurrencyRequestParam: Encodable {
    let symbols: String
    let base: String
    let accessKey: String = Info.APIKEY
}
