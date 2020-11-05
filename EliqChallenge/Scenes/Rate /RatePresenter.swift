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
}

class RatePresenter: RatePresenterLogic {
    weak var viewController: RateDisplayLogic?
    
    
    func presentRatesResult(response: RateModel.FetchRates.Response) {
        switch response.response {
        case .success(let response):
            break
        case .failure(let error):
            break
        }
    }
    
    func presentDailyResult(response: RateModel.FetchDailyRate.Response) {
        DispatchQueue.main.async {
            switch response.response {
            case .success(let result):
                self.viewController?.displayDailyRate(viewModel: .init(date: result.date ?? "", rateValue: "\(result.rates![response.selectedCurrency.rawValue]!) \(response.selectedCurrency.rawValue)", isNextButtonEnable: response.isNextButtonEnable))
            case .failure(let error):
                break
            }
        }
    }
}
