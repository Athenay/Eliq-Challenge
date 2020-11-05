//
//  RateEndpoint.swift
//  EliqChallenge
//
//  Created by Athena Yousefi on 11/5/20.
//  Copyright © 2020 Athena Yousefi. All rights reserved.
//

import Foundation

enum RateEndpoint {
    case fetchRates(params: FetchRatesParams)
    case fetchDailyRate(date: String, params: FetchDailyRateParams)
}

extension RateEndpoint: RequestProtocol {
    var baseURL: URL {
        return Info.baseURL
    }
    
    var relativePath: String {
        switch self {
        case .fetchRates:
            return "/timeseries"
        case .fetchDailyRate(let date,_):
            return "/\(date)"
        }
    }
    
    var method: HTTPMethod {
        return .get
    }
    
    var headers: [String : String]? {
        return nil
    }
    
    var requestType: RequestType {
        switch self {
        case .fetchRates(params: let params):
            guard let urlParams = params.stringDictionary else { break }
            return .requestParameters(urlParameters: urlParams)
        case .fetchDailyRate(_, let params):
            guard let urlParams = params.stringDictionary else { break }
            return .requestParameters(urlParameters: urlParams)
        }
        return .requestPlain
    }
    
    
}
