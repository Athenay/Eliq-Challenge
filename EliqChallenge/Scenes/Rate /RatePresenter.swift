//
//  RatePresenter.swift
//  EliqChallenge
//
//  Created by Athena Yousefi on 11/5/20.
//  Copyright © 2020 Athena Yousefi. All rights reserved.
//

import Foundation

protocol RatePresenterLogic {
    func presentRatesResult(response: RateModel.FetchRates.Response)
    func presentDailyResult(response: RateModel.FetchDailyRate.Response)
    func presentPageTitle(response: RateModel.Initialize.Response)
}

class RatePresenter: RatePresenterLogic {
    weak var viewController: RateDisplayLogic?
    
    
    func presentRatesResult(response: RateModel.FetchRates.Response) {
        switch response.response {
        case .success(let result):
            self.displayChart(response: result, selectedCurrency: response.selectedCurrency)
        case .failure:
            break
        }
    }
    
    func displayChart(response: RatesResponse, selectedCurrency: Currency) {
        if let rates = response.rates {
            var dailyRates = [Double]()
            rates.keys.forEach { (key) in
                if let value = rates[key]?[selectedCurrency.rawValue] {
                    dailyRates.append(value)
                }
            }
            
            if let max = dailyRates.max() {
                dailyRates = dailyRates.map { $0/max }
            }
            
            let data = dailyRates.map { DataEntry(color: .white, height: Float($0))}
            DispatchQueue.main.async {
                self.viewController?.displayRateChart(viewModel: .init(dataEtries: data))
            }
        }
    }
    
    func presentDailyResult(response: RateModel.FetchDailyRate.Response) {
        DispatchQueue.main.async {
            switch response.response {
            case .success(let result):
                DispatchQueue.main.async {
                    self.viewController?.displayDailyRate(viewModel: .init(date: result.date ?? "", rateValue: "\(result.rates![response.selectedCurrency.rawValue]!) \(response.selectedCurrency.rawValue)", isNextButtonEnable: response.isNextButtonEnable))
                }
            case .failure:
                break
            }
        }
    }
    
    func presentPageTitle(response: RateModel.Initialize.Response) {
        DispatchQueue.main.async {
            self.viewController?.dispalyPageTitle(viewModel: .init(pageTitle: response.pageTitle))
        }
    }
}
