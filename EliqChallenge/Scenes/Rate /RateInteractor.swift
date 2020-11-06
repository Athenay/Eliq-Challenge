//
//  RateInteractor.swift
//  EliqChallenge
//
//  Created by Athena Yousefi on 11/5/20.
//  Copyright © 2020 Athena Yousefi. All rights reserved.
//

import Foundation

protocol RateInteractorLogic {
    func fetchRates(request: RateModel.FetchRates.Request)
    func fetchDailyRate(request: RateModel.FetchDailyRate.Request)
    func nextButtionTapped(request: RateModel.FetchDailyRate.Request)
    func previousButtonTapped(request: RateModel.FetchDailyRate.Request)
    func initialize(request: RateModel.Initialize.Request)
}

class RateInteractor: RateInteractorLogic {
    
    var worker: RateWorkerLogic?
    var presenter: RatePresenterLogic?
    
    private let rateDays: Int
    private let base: String
    private let currency: Currency
    var dailyRateDate = Date()
    private var isLoadingDailyRate = false
    
    init(rateDays: Int = 9, base: String = "EUR", currency: Currency) {
        self.rateDays = rateDays
        self.base = base
        self.currency = currency
    }
    
    lazy var dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "YYYY-MM-dd"
        return formatter
    }()
    
}
extension RateInteractor {
    
    func fetchRates(request: RateModel.FetchRates.Request) {
        self.worker?.fetchRates(params: .init(startDate: getRateStartDate(), endDate: getRateEndDate(), symbols: currency.rawValue, base: base), completion: { [weak self] (result) in
            guard let self = self else { return }
            switch result {
            case .success(let response):
                self.presenter?.presentRatesResult(response: .init(selectedCurrency: self.currency, response: .success(response)))
            case .failure(let error):
                if error.code == .limitedPlan {
                    self.presentMockData()
                } else {
                    self.presenter?.presentRatesResult(response: .init(selectedCurrency: self.currency, response: .failure(error)))
                }
            }
        })
    }
    
    func getRateStartDate() -> String {
        let date = Date().subtractDays(n: rateDays)
        return formatDateToString(date: date)
    }
    
    func getRateEndDate() -> String {
        let date = Date()
        return formatDateToString(date: date)
    }
    
    func formatDateToString(date: Date) -> String {
        return dateFormatter.string(from: date)
    }
    
    /*
     This function will be called only when the subscription plan is limited for the API KEY. This will mock the data to show the result.
     But for production level this should not be there. It is just for seeng the result in case of not efficient subscription plan.
     */
    
    func presentMockData() {
        let currency = self.currency.rawValue
        let rates = [
            formatDateToString(date: Date().subtractDays(n: 9)): [currency: 1.522891],
            formatDateToString(date: Date().subtractDays(n: 8)): [currency: 0.778047],
            formatDateToString(date: Date().subtractDays(n: 7)): [currency: 1.002303],
            formatDateToString(date: Date().subtractDays(n: 6)): [currency: 0.815066],
            formatDateToString(date: Date().subtractDays(n: 5)): [currency: 1.274202],
            formatDateToString(date: Date().subtractDays(n: 4)): [currency: 1.199083],
            formatDateToString(date: Date().subtractDays(n: 3)): [currency: 0.714491],
            formatDateToString(date: Date().subtractDays(n: 2)): [currency: 1.022891],
            formatDateToString(date: Date().subtractDays(n: 1)): [currency: 0.880135],
            formatDateToString(date: Date()): [currency: 1.322891],
        ]
        let mockRespone = RatesResponse(success: true, error: nil, timeseries: true, startDate: getRateEndDate(), endDate: getRateEndDate(), base: base, rates: rates)
        self.presenter?.presentRatesResult(response: .init(selectedCurrency: self.currency, response: .success(mockRespone)))
    }
}

extension RateInteractor {
    
    func fetchDailyRate(request: RateModel.FetchDailyRate.Request) {
        self.fetchDailyRate(date: self.dailyRateDate)
    }
    
    private func fetchDailyRate(date: Date) {
        guard !isLoadingDailyRate else { return }
        self.isLoadingDailyRate = true
        self.worker?.fetchDailyRates(date: formatDateToString(date: date), params: .init(symbols: currency.rawValue, base: base), completion: { [weak self] (result) in
            guard let self = self else { return }
            self.isLoadingDailyRate = false
            switch result {
            case .success(let response):
                self.dailyRateDate = date
                let todayStringFormat = self.formatDateToString(date: Date())
                let dailyRateDateStringFormat = self.formatDateToString(date: self.dailyRateDate)
                self.presenter?.presentDailyResult(response: .init(selectedCurrency: self.currency, isNextButtonEnable: dailyRateDateStringFormat != todayStringFormat, response: .success(response)))
            case .failure(let error):
                self.presenter?.presentDailyResult(response: .init(selectedCurrency: self.currency, isNextButtonEnable: true, response: .failure(error)))
            }
        })
    }
    
    func nextButtionTapped(request: RateModel.FetchDailyRate.Request) {
        self.fetchDailyRate(date: self.dailyRateDate.addDays(n: 1))
    }
    
    func previousButtonTapped(request: RateModel.FetchDailyRate.Request) {
        self.fetchDailyRate(date: self.dailyRateDate.subtractDays(n: 1))
    }
    
}

extension RateInteractor {
    func initialize(request: RateModel.Initialize.Request) {
        self.presenter?.presentPageTitle(response: .init(pageTitle: currency.rawValue))
    }
}
