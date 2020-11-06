//
//  RateModel.swift
//  EliqChallenge
//
//  Created by Athena Yousefi on 11/5/20.
//  Copyright © 2020 Athena Yousefi. All rights reserved.
//

import Foundation

enum RateModel {
    
    enum Initialize {
        struct Request {
            
        }
        struct Response {
            let pageTitle: String
        }
        struct ViewModel {
            let pageTitle: String
        }
    }
    
    enum FetchRates {
        struct Request {
            
        }
        struct Response {
            let selectedCurrency: Currency
            let response: Result<RatesResponse, ErrorModel>
        }
        struct ViewModel {
            let dataEtries: [DataEntry]
        }
    }
    
    enum FetchDailyRate {
        struct Request {
        }
        struct Response {
            let selectedCurrency: Currency
            let isNextButtonEnable: Bool
            let response: Result<DailyRateResponse, ErrorModel>
        }
        struct ViewModel {
            let date: String
            let rateValue: String
            let isNextButtonEnable: Bool
        }
    }
}
