//
//  RateWorker.swift
//  EliqChallenge
//
//  Created by Athena Yousefi on 11/5/20.
//  Copyright © 2020 Athena Yousefi. All rights reserved.
//

import Foundation

protocol RateWorkerLogic {
    func fetchRates(params: FetchRatesParams, completion: @escaping (Result<RatesResponse, ErrorModel>) -> Void)
    func fetchDailyRates(date: String, params: FetchDailyRateParams, completion: @escaping (Result<DailyRateResponse, ErrorModel>) -> Void)
}


class RateWorker: RateWorkerLogic {
    let networkManager: NetworkAPI
    
    init(networkManager: NetworkAPI) {
        self.networkManager = networkManager
    }
    
    func fetchRates(params: FetchRatesParams, completion: @escaping (Result<RatesResponse, ErrorModel>) -> Void) {
        self.networkManager.sendRequest(request: RateEndpoint.fetchRates(params: params)) { (result: Result<RatesResponse, NetworkError>) in
            switch result {
            case .success(let response):
                if let error = response.error {
                    completion(.failure(error))
                    
                } else {
                    completion(.success(response))
                }
            case .failure(let error):
                completion(.failure(.init(code: .unknowError, type: error.localizedDescription, info: error.localizedDescription)))
            }
        }
    }
    
    func fetchDailyRates(date: String, params: FetchDailyRateParams, completion: @escaping (Result<DailyRateResponse, ErrorModel>) -> Void) {
        self.networkManager.sendRequest(request: RateEndpoint.fetchDailyRate(date: date, params: params)) { (result: Result<DailyRateResponse, NetworkError>) in
            switch result {
            case .success(let response):
                if let error = response.error {
                    completion(.failure(error))
                    
                } else {
                    completion(.success(response))
                }
                debugPrint("Success")
            case .failure(let error):
                debugPrint("Failed \(error.localizedDescription) \(error)")
                completion(.failure(.init(code: .unknowError, type: error.localizedDescription, info: error.localizedDescription)))
            }
        }
    }
}
