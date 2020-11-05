//
//  CurrencyDependencyContainer.swift
//  EliqChallenge
//
//  Created by Athena Yousefi on 11/5/20.
//  Copyright © 2020 Athena Yousefi. All rights reserved.
//

import Foundation

protocol CurrencyFactory {
    func makeCurrencyViewController() -> CurrencyViewController
}

struct CurrencyDependencyContainer: CurrencyFactory {
    func makeCurrencyViewController() -> CurrencyViewController {
        let viewController = CurrencyViewController(nibName: "CurrencyViewController", bundle: nil)
        let presenter = CurrencyPresenter()
        let interactor = CurrencyInteractor()
        let worker = CurrencyWorker()
        viewController.interactor = interactor
        presenter.viewController = viewController
        interactor.presenter = presenter
        interactor.worker = worker
        return viewController
    }
}
