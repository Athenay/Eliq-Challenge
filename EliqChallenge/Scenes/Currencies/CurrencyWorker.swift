//
//  CurrencyWorker.swift
//  EliqChallenge
//
//  Created by Athena Yousefi on 11/5/20.
//  Copyright © 2020 Athena Yousefi. All rights reserved.
//

import Foundation

protocol CurrencyWorkerLogic {
    func fetchCurrencies(completion: (Result<[Currency], Error>) -> Void)
}

class CurrencyWorker: CurrencyWorkerLogic {
    func fetchCurrencies(completion: (Result<[Currency], Error>) -> Void) {
        completion(.success(Currency.allCases))
    }
}
