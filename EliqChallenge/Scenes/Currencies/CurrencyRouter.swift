//
//  CurrencyRouter.swift
//  EliqChallenge
//
//  Created by Athena Yousefi on 11/5/20.
//  Copyright © 2020 Athena Yousefi. All rights reserved.
//

import Foundation

protocol CurrencyRoutingLogic {
    func navigateToExchange()
    func navigateToRate(selectedCurrency: Currency)
}

class CurrencyRouter: CurrencyRoutingLogic {
    weak var viewController: CurrencyViewController?
    
    func navigateToExchange() {
        let dependencyContainer = ExchangeDependencyContainer()
        let viewController = dependencyContainer.makeExchangeViewControlelr()
        self.viewController?.navigationController?.pushViewController(viewController, animated: true)
    }
    
    func navigateToRate(selectedCurrency: Currency) {
        let dependencyContainer = RateDependencyContainer()
        let rateViewController = dependencyContainer.makeRateViewController(selectedCurrency: selectedCurrency)
        self.viewController?.navigationController?.pushViewController(rateViewController, animated: true)
    }
    
    
}
