//
//  ExchangeModel.swift
//  EliqChallenge
//
//  Created by Athena Yousefi on 11/5/20.
//  Copyright © 2020 Athena Yousefi. All rights reserved.
//

import Foundation

enum ExchangeModel {
    enum Convert {
        struct Request {
            let sender: EditingTextField
            let from: Currency
            let fromValue: Double
            let to: Currency
        }
        struct Respone {
            let reciever: EditingTextField
            let to: Double
        }
        struct ViewModel {
            let reciever: EditingTextField
            let to: Double
        }
    }
    
    enum Initialize {
        struct Request {
        }
        struct Respone {
            let supportedCurrencies: [Currency]
        }
        struct ViewModel {
            let supportedCurrencies: [Currency]
        }
    }
}

enum EditingTextField {
    case first, second
}
