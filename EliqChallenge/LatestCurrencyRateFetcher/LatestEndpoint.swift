//
//  LatestCurrencyFetchEndpoint.swift
//  EliqChallenge
//
//  Created by Athena Yousefi on 11/5/20.
//  Copyright © 2020 Athena Yousefi. All rights reserved.
//

import Foundation


enum LatestEndpoint {
    case fetchLatest(params: LatestCurrencyRequestParam)
}

extension LatestEndpoint: RequestProtocol {
    var baseURL: URL {
        return Info.baseURL
    }
    
    var relativePath: String {
        switch self {
        case .fetchLatest:
            return "/latest"
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
        case .fetchLatest(params: let params):
            guard let urlParams = params.stringDictionary else { break }
            return .requestParameters(urlParameters: urlParams)
        }
        return .requestPlain
    }
    
    
}
