//
//  Currency.swift
//  EliqChallenge
//
//  Created by Athena Yousefi on 11/5/20.
//  Copyright © 2020 Athena Yousefi. All rights reserved.
//

import Foundation

enum CurrencyModel {
    
    enum Fetch {
        struct Request {
            
        }
        struct Response {
            var result: Result<[Currency], Error>
        }
        struct ViewModel {
            var sections: [SectionModelLogic]
        }
    }
    
}

enum Currency: String, CaseIterable, Decodable {
    case SEK = "SEK"
    case AUD = "AUD"
    case USD = "USD"
    case CAD = "CAD"
    case PLN = "PLN"
    case MXN = "MXN"
}
