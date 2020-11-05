//
//  CurrencyInteractor.swift
//  EliqChallenge
//
//  Created by Athena Yousefi on 11/5/20.
//  Copyright © 2020 Athena Yousefi. All rights reserved.
//

import Foundation

protocol CurrencyInteractorLogic {
    func fetchCurrencies(request: CurrencyModel.Fetch.Request)
}

class CurrencyInteractor: CurrencyInteractorLogic {
    var presenter: CurrencyPresenterLogic?
    var worker: CurrencyWorkerLogic?
    
    func fetchCurrencies(request: CurrencyModel.Fetch.Request) {
        worker?.fetchCurrencies(completion: { (result) in
            self.presenter?.presentCurrencies(response: .init(result: result))
        })
    }
}
