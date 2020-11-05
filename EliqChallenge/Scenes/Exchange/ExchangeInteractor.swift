//
//  ExchangeInteractor.swift
//  EliqChallenge
//
//  Created by Athena Yousefi on 11/5/20.
//  Copyright © 2020 Athena Yousefi. All rights reserved.
//

import Foundation

protocol ExchangeInteractorLogic {
    func initialize(request: ExchangeModel.Initialize.Request)
    func convert(request: ExchangeModel.Convert.Request)
}

class ExchangeInteractor: ExchangeInteractorLogic {
    
    let latestCurrencyFetcher: LatestCurrencyRateFetcher
    var rates: [String: Double]?
    
    var presenter: ExchangePresenterLogic?
    
    init(latestCurrencyFetcher: LatestCurrencyRateFetcher) {
        self.latestCurrencyFetcher = latestCurrencyFetcher
        latestCurrencyFetcher.fetchLatestRates { (rate) in
            self.rates = rate
            self.initialize(request: .init())
        }
    }
        
    func initialize(request: ExchangeModel.Initialize.Request) {
        self.presenter?.presentInitValues(response: .init(supportedCurrencies: Currency.allCases))
    }
    
    func convert(request: ExchangeModel.Convert.Request) {
        guard let rates = self.rates else { return }
        guard let fromRate = rates[request.from.rawValue],
            let toRate = rates[request.to.rawValue] else { return }
        let fromValue = request.fromValue
        let toValue = fromValue * toRate / fromRate
        let receiver = request.sender == .first ? EditingTextField.second : EditingTextField.first
        self.presenter?.presentConvertResponse(response: .init(reciever: receiver, to: Double(round(10*toValue)/10)))
    }
}
