//
//  CurrencyPresenter.swift
//  EliqChallenge
//
//  Created by Athena Yousefi on 11/5/20.
//  Copyright © 2020 Athena Yousefi. All rights reserved.
//

import Foundation

protocol CurrencyPresenterLogic {
    func presentCurrencies(response: CurrencyModel.Fetch.Response)
}

class CurrencyPresenter: CurrencyPresenterLogic {
    weak var viewController: CurrencyDisplayLogic?
    
    func presentCurrencies(response: CurrencyModel.Fetch.Response) {
        switch response.result {
        case .success(let currencies):
            presentList(currencies: currencies)
        case .failure:
            //In this case because of there is no network request, so the is no error
            break
        }
    }
    
    private func presentList(currencies: [Currency]) {
        let cells = currencies.map { return CellModel(nibName: "CurrencyCollectionViewCell", reuseId: "CurrencyCollectionViewCell", model: $0)}
        let section = SectionModel(cells: cells)
        self.viewController?.displayList(viewModel: .init(sections: [section]))
    }
}
