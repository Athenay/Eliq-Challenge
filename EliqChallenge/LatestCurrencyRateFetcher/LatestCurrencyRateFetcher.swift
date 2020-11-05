//
//  LatestCurrencyRateFetcher.swift
//  EliqChallenge
//
//  Created by Athena Yousefi on 11/5/20.
//  Copyright © 2020 Athena Yousefi. All rights reserved.
//

import Foundation

class LatestCurrencyRateFetcher {
    private var fetchInterval: TimeInterval
    private var networkAPI: NetworkAPI
    private var rates: [String: Double]?
    private var timer: Timer!
    private let base: String
    private let dispatchQueue = DispatchQueue(label: "com.eliq.eliqchallenge")
    
    internal init(base: String, fetchInterval: TimeInterval, networkAPI: NetworkAPI) {
        self.fetchInterval = fetchInterval
        self.networkAPI = networkAPI
        self.base = base
        self.timer = Timer.scheduledTimer(timeInterval: fetchInterval, target: self, selector: #selector(self.timeElapsed), userInfo: nil, repeats: true)
    }
    
  
    
    @objc func timeElapsed() {
        fetchLatestRates(completion: nil)
    }
    
    
    public func fetchLatestRates(completion: (([String: Double]) -> Void)?) {
        if let rates = self.rates {
            completion?(rates)
        } else {
            dispatchQueue.async {
                let currencies = Currency.allCases.map { $0.rawValue }
                let symbols = currencies.joined(separator: ",")
                
                self.networkAPI.sendRequest(request: LatestEndpoint.fetchLatest(params: .init(symbols: symbols, base: self.base))) { [weak self] (result: Result<DailyRateResponse, NetworkError>) in
                    guard let self = self else { return }
                    switch result {
                    case .success(let response):
                        guard let rates = response.rates else { return }
                        self.rates = rates
                        completion?(rates)
                    case .failure:
                        self.fetchLatestRates(completion: nil)
                    }
                }
            }
        }
    }
    
}
